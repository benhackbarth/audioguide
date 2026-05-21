"""DAW-like take browser for TRANSMISSIONS batch renders."""

from __future__ import annotations

from pathlib import Path

from PySide6.QtCore import Qt, QUrl, Signal
from PySide6.QtGui import QColor, QPainter
from PySide6.QtWidgets import (
	QApplication,
	QCheckBox,
	QComboBox,
	QFileDialog,
	QGridLayout,
	QHBoxLayout,
	QLabel,
	QPlainTextEdit,
	QPushButton,
	QSlider,
	QSpinBox,
	QTreeWidget,
	QTreeWidgetItem,
	QVBoxLayout,
	QWidget,
)

try:
	from PySide6.QtMultimedia import QAudioOutput, QMediaPlayer
except ImportError:  # pragma: no cover - depends on the user's PySide install.
	QAudioOutput = None
	QMediaPlayer = None

from .audio_preview import extract_audio_peaks
from .keeper_export import (
	DEFAULT_ABLETON_PROJECT_DIRNAME,
	DEFAULT_ASSEMBLY_FILENAME,
	export_ableton_project,
	export_keepers,
	export_reaper_assembly,
)
from .output_browser import open_path, reveal_path
from .take_manifest import TakeEntry, default_manifest_path, load_take_entries, save_take_annotation


DEFAULT_TAGS = ("drums", "bass", "vocal", "texture", "noise", "loop", "intro", "hook", "break", "weird", "favorite")


class WaveformWidget(QWidget):
	"""Compact waveform overview with a playback cursor."""

	seek_requested = Signal(float)

	def __init__(self, parent: QWidget | None = None):
		super().__init__(parent)
		self._peaks: list[float] = []
		self._position_ratio = 0.0
		self.setMinimumHeight(78)

	def set_audio_file(self, path: str | Path | None) -> None:
		"""Load peak data for *path*."""
		self._peaks = extract_audio_peaks(path, 180) if path is not None else []
		self._position_ratio = 0.0
		self.update()

	def set_position_ratio(self, ratio: float) -> None:
		"""Move the playback cursor."""
		self._position_ratio = max(0.0, min(1.0, ratio))
		self.update()

	def paintEvent(self, _event):  # noqa: N802 - Qt override
		painter = QPainter(self)
		rect = self.rect()
		painter.fillRect(rect, QColor("#141414"))
		mid_y = rect.height() / 2
		if not self._peaks:
			painter.setPen(QColor("#666666"))
			painter.drawText(rect, Qt.AlignmentFlag.AlignCenter, "No waveform")
		else:
			bar_width = max(1, rect.width() / len(self._peaks))
			painter.setPen(QColor("#8ac7ff"))
			painter.setBrush(QColor("#8ac7ff"))
			for index, peak in enumerate(self._peaks):
				height = max(1.0, peak * rect.height() * 0.82)
				x = int(index * bar_width)
				y = int(mid_y - height / 2)
				painter.drawRect(x, y, max(1, int(bar_width)), int(height))
		cursor_x = int(rect.width() * self._position_ratio)
		painter.setPen(QColor("#ffcc66"))
		painter.drawLine(cursor_x, 0, cursor_x, rect.height())
		painter.end()

	def mousePressEvent(self, event):  # noqa: N802 - Qt override
		if self.width() > 0:
			self.seek_requested.emit(max(0.0, min(1.0, event.position().x() / self.width())))


class TakeBrowserPanel(QWidget):
	"""Browse rendered takes, audition files, and save ratings/notes."""

	def __init__(self, parent: QWidget | None = None):
		super().__init__(parent)
		self._manifest_path: Path | None = None
		self._entries: list[TakeEntry] = []
		self._current_output_name: str | None = None
		self._loading_selection = False
		self._duration_ms = 0
		self._seeking = False

		self.status_label = QLabel("Batch takes will appear here after a render manifest is available.")
		self.tree = QTreeWidget()
		self.tree.setHeaderLabels(["Take", "Rating", "Keep", "Seed", "Audio", "Tags", "Notes"])
		self.tree.itemSelectionChanged.connect(self._selection_changed)
		self.tree.itemDoubleClicked.connect(self._open_audio)

		self.filter_combo = QComboBox()
		self.filter_combo.addItem("All takes", "all")
		self.filter_combo.addItem("Keepers", "keepers")
		self.filter_combo.addItem("Rated 4+", "rated4")
		self.filter_combo.addItem("Has audio", "audio")
		self.filter_combo.addItem("Tagged", "tagged")
		self.filter_combo.currentIndexChanged.connect(self._refresh_tree)
		self.tag_filter_combo = QComboBox()
		self.tag_filter_combo.addItem("Any tag", "")
		for tag in DEFAULT_TAGS:
			self.tag_filter_combo.addItem(tag, tag)
		self.tag_filter_combo.currentIndexChanged.connect(self._refresh_tree)
		self.sort_combo = QComboBox()
		self.sort_combo.addItem("Take number", "take")
		self.sort_combo.addItem("Rating", "rating")
		self.sort_combo.addItem("Seed", "seed")
		self.sort_combo.addItem("Output name", "name")
		self.sort_combo.currentIndexChanged.connect(self._refresh_tree)

		self.rating_spin = QSpinBox()
		self.rating_spin.setRange(0, 5)
		self.keeper_check = QCheckBox("Keeper")
		self.notes_edit = QPlainTextEdit()
		self.notes_edit.setPlaceholderText("Notes, bars to sample, edit ideas, or DAW follow-up.")
		self.notes_edit.setMaximumHeight(90)

		self.save_button = QPushButton("Save Notes")
		self.save_button.clicked.connect(self._save_current_annotation)
		self.open_audio_button = QPushButton("Open Audio")
		self.open_audio_button.clicked.connect(self._open_audio)
		self.open_json_button = QPushButton("Open JSON")
		self.open_json_button.clicked.connect(self._open_json)
		self.open_rpp_button = QPushButton("Open RPP")
		self.open_rpp_button.clicked.connect(self._open_rpp)
		self.open_options_button = QPushButton("Open Options")
		self.open_options_button.clicked.connect(self._open_options)
		self.export_keepers_button = QPushButton("Export Keepers")
		self.export_keepers_button.clicked.connect(self._export_keepers)
		self.export_rated_button = QPushButton("Export Rated 4+")
		self.export_rated_button.clicked.connect(self._export_rated)
		self.export_assembly_button = QPushButton("Export Assembly RPP")
		self.export_assembly_button.clicked.connect(self._export_assembly)
		self.export_ableton_button = QPushButton("Export Ableton")
		self.export_ableton_button.clicked.connect(self._export_ableton)
		self.play_button = QPushButton("Play")
		self.play_button.clicked.connect(self._play_pause)
		self.stop_button = QPushButton("Stop")
		self.stop_button.clicked.connect(self._stop)
		self.loop_check = QCheckBox("Loop")
		self.position_slider = QSlider(Qt.Orientation.Horizontal)
		self.position_slider.setRange(0, 1000)
		self.position_slider.sliderPressed.connect(self._slider_pressed)
		self.position_slider.sliderReleased.connect(self._slider_released)
		self.position_slider.valueChanged.connect(self._slider_value_changed)
		self.time_label = QLabel("00:00 / 00:00")
		self.waveform = WaveformWidget()
		self.waveform.seek_requested.connect(self._seek_ratio)
		self.reveal_button = QPushButton("Reveal")
		self.reveal_button.clicked.connect(self._reveal_current)
		self.copy_button = QPushButton("Copy Audio Path")
		self.copy_button.clicked.connect(self._copy_audio_path)
		self._player = None
		self._audio_output = None
		if QMediaPlayer is not None and QAudioOutput is not None:
			self._player = QMediaPlayer(self)
			self._audio_output = QAudioOutput(self)
			self._player.setAudioOutput(self._audio_output)
			self._audio_output.setVolume(0.85)
			self._player.positionChanged.connect(self._player_position_changed)
			self._player.durationChanged.connect(self._player_duration_changed)
			self._player.playbackStateChanged.connect(self._player_state_changed)
			self._player.mediaStatusChanged.connect(self._player_status_changed)

		filter_layout = QHBoxLayout()
		filter_layout.addWidget(QLabel("Filter"))
		filter_layout.addWidget(self.filter_combo)
		filter_layout.addWidget(self.tag_filter_combo)
		filter_layout.addWidget(QLabel("Sort"))
		filter_layout.addWidget(self.sort_combo)
		filter_layout.addStretch(1)

		editor_layout = QHBoxLayout()
		editor_layout.addWidget(QLabel("Rating"))
		editor_layout.addWidget(self.rating_spin)
		editor_layout.addWidget(self.keeper_check)
		editor_layout.addWidget(self.save_button)
		editor_layout.addStretch(1)

		self.tag_checks: dict[str, QCheckBox] = {}
		tags_layout = QGridLayout()
		for index, tag in enumerate(DEFAULT_TAGS):
			check = QCheckBox(tag)
			self.tag_checks[tag] = check
			tags_layout.addWidget(check, index // 6, index % 6)

		button_layout = QHBoxLayout()
		button_layout.addWidget(self.open_audio_button)
		button_layout.addWidget(self.play_button)
		button_layout.addWidget(self.stop_button)
		button_layout.addWidget(self.loop_check)
		button_layout.addWidget(self.open_json_button)
		button_layout.addWidget(self.open_rpp_button)
		button_layout.addWidget(self.open_options_button)
		button_layout.addWidget(self.reveal_button)
		button_layout.addWidget(self.copy_button)
		button_layout.addWidget(self.export_keepers_button)
		button_layout.addWidget(self.export_rated_button)
		button_layout.addWidget(self.export_assembly_button)
		button_layout.addWidget(self.export_ableton_button)
		button_layout.addStretch(1)

		layout = QVBoxLayout(self)
		layout.addWidget(self.status_label)
		layout.addLayout(filter_layout)
		layout.addWidget(self.tree, stretch=1)
		layout.addWidget(self.waveform)
		layout.addWidget(self.position_slider)
		layout.addWidget(self.time_label)
		layout.addLayout(editor_layout)
		layout.addLayout(tags_layout)
		layout.addWidget(self.notes_edit)
		layout.addLayout(button_layout)
		self._update_action_state()

	def scan(self, output_dir: str | Path) -> None:
		"""Load the default manifest in *output_dir* if present."""
		self.load_manifest(default_manifest_path(output_dir))

	def load_manifest(self, manifest_path: str | Path) -> None:
		"""Load a specific render manifest."""
		path = Path(manifest_path).expanduser()
		self.clear()
		if not path.exists():
			self.status_label.setText(f"No render manifest found at {path}.")
			return
		self._manifest_path = path
		self._entries = load_take_entries(path)
		self._refresh_tree()
		self.status_label.setText(f"Loaded {len(self._entries)} take{'s' if len(self._entries) != 1 else ''} from {path}.")
		self._update_action_state()

	def clear(self) -> None:
		"""Clear the current take list."""
		self._save_current_annotation(silent=True)
		self._manifest_path = None
		self._entries = []
		self._current_output_name = None
		self.tree.clear()
		self.rating_spin.setValue(0)
		self.keeper_check.setChecked(False)
		for check in self.tag_checks.values():
			check.setChecked(False)
		self.notes_edit.clear()
		self._stop()
		self.waveform.set_audio_file(None)
		self.position_slider.setValue(0)
		self.status_label.setText("Batch takes will appear here after a render manifest is available.")
		self._update_action_state()

	def selected_entry(self) -> TakeEntry | None:
		"""Return the currently selected take entry."""
		item = self.tree.currentItem()
		if item is None:
			return None
		output_name = item.data(0, Qt.ItemDataRole.UserRole)
		for entry in self._entries:
			if entry.output_name == output_name:
				return entry
		return None

	def _selection_changed(self) -> None:
		if self._loading_selection:
			return
		self._save_current_annotation(silent=True)
		entry = self.selected_entry()
		if entry is not None:
			self._loading_selection = True
			self.rating_spin.setValue(entry.rating)
			self.keeper_check.setChecked(entry.keeper)
			for tag, check in self.tag_checks.items():
				check.setChecked(tag in entry.tags)
			self.notes_edit.setPlainText(entry.notes)
			self._loading_selection = False
			self._current_output_name = entry.output_name
			self._load_selected_audio(entry)
		self._update_action_state()

	def _save_current_annotation(self, silent: bool = False) -> None:
		if self._manifest_path is None or self._current_output_name is None:
			return
		save_take_annotation(
			self._manifest_path,
			self._current_output_name,
			rating=self.rating_spin.value(),
			keeper=self.keeper_check.isChecked(),
			notes=self.notes_edit.toPlainText(),
			tags=self._selected_tags(),
		)
		if silent:
			return
		entry = self.selected_entry()
		if entry is None:
			return
		self.load_manifest(self._manifest_path)
		for row in range(self.tree.topLevelItemCount()):
			item = self.tree.topLevelItem(row)
			if item.data(0, Qt.ItemDataRole.UserRole) == entry.output_name:
				self.tree.setCurrentItem(item)
				break

	def _update_action_state(self) -> None:
		entry = self.selected_entry()
		has_entry = entry is not None
		self.save_button.setEnabled(has_entry)
		self.open_audio_button.setEnabled(bool(entry and entry.audio_file))
		self.play_button.setEnabled(bool(entry and entry.audio_file and self._player is not None))
		self.stop_button.setEnabled(bool(entry and entry.audio_file and self._player is not None))
		self.position_slider.setEnabled(bool(entry and entry.audio_file and self._player is not None))
		self.loop_check.setEnabled(bool(entry and entry.audio_file and self._player is not None))
		self.open_json_button.setEnabled(bool(entry and entry.json_file))
		self.open_rpp_button.setEnabled(bool(entry and entry.rpp_file))
		self.open_options_button.setEnabled(bool(entry and entry.options_file.exists()))
		self.reveal_button.setEnabled(has_entry)
		self.copy_button.setEnabled(bool(entry and entry.audio_file))
		has_manifest = self._manifest_path is not None
		self.export_keepers_button.setEnabled(has_manifest)
		self.export_rated_button.setEnabled(has_manifest)
		self.export_assembly_button.setEnabled(has_manifest)
		self.export_ableton_button.setEnabled(has_manifest)
		self.rating_spin.setEnabled(has_entry)
		self.keeper_check.setEnabled(has_entry)
		for check in self.tag_checks.values():
			check.setEnabled(has_entry)
		self.notes_edit.setEnabled(has_entry)

	def _refresh_tree(self) -> None:
		current = self._current_output_name
		self.tree.clear()
		for entry in self._visible_entries():
			item = QTreeWidgetItem(
				[
					f"{entry.take:03d}  {entry.output_name}",
					str(entry.rating),
					"yes" if entry.keeper else "",
					"" if entry.random_seed is None else str(entry.random_seed),
					entry.audio_file.name if entry.audio_file else "",
					", ".join(entry.tags),
					_trim_note(entry.notes),
				]
			)
			item.setData(0, Qt.ItemDataRole.UserRole, entry.output_name)
			self.tree.addTopLevelItem(item)
			if current and entry.output_name == current:
				self.tree.setCurrentItem(item)
		self.tree.resizeColumnToContents(0)
		self.tree.resizeColumnToContents(5)

	def _visible_entries(self) -> list[TakeEntry]:
		entries = [entry for entry in self._entries if self._matches_filter(entry)]
		sort_mode = self.sort_combo.currentData()
		if sort_mode == "rating":
			return sorted(entries, key=lambda entry: (-entry.rating, entry.take))
		if sort_mode == "seed":
			return sorted(entries, key=lambda entry: (entry.random_seed is None, entry.random_seed or 0, entry.take))
		if sort_mode == "name":
			return sorted(entries, key=lambda entry: entry.output_name.lower())
		return sorted(entries, key=lambda entry: entry.take)

	def _matches_filter(self, entry: TakeEntry) -> bool:
		tag_filter = str(self.tag_filter_combo.currentData() or "")
		if tag_filter and tag_filter not in entry.tags:
			return False
		filter_mode = self.filter_combo.currentData()
		if filter_mode == "keepers":
			return entry.keeper
		if filter_mode == "rated4":
			return entry.rating >= 4
		if filter_mode == "audio":
			return entry.audio_file is not None
		if filter_mode == "tagged":
			return bool(entry.tags)
		return True

	def _selected_tags(self) -> list[str]:
		return [tag for tag, check in self.tag_checks.items() if check.isChecked()]

	def _load_selected_audio(self, entry: TakeEntry) -> None:
		self._stop()
		self.waveform.set_audio_file(entry.audio_file)
		self.position_slider.setValue(0)
		self.time_label.setText("00:00 / 00:00")
		if entry.audio_file is not None and self._player is not None:
			self._player.setSource(QUrl.fromLocalFile(str(entry.audio_file)))

	def _open_audio(self, *_args: object) -> None:
		entry = self.selected_entry()
		if entry is not None and entry.audio_file is not None:
			open_path(entry.audio_file)

	def _play_pause(self) -> None:
		if self._player is None:
			return
		entry = self.selected_entry()
		if entry is None or entry.audio_file is None:
			return
		if self._player.source().isEmpty():
			self._player.setSource(QUrl.fromLocalFile(str(entry.audio_file)))
		if self._player.playbackState() == QMediaPlayer.PlaybackState.PlayingState:
			self._player.pause()
		else:
			self._player.play()

	def _stop(self) -> None:
		if self._player is not None:
			self._player.stop()
			self._player.setPosition(0)
		self.position_slider.setValue(0)
		self.waveform.set_position_ratio(0)

	def _slider_pressed(self) -> None:
		self._seeking = True

	def _slider_released(self) -> None:
		self._seeking = False
		self._seek_ratio(self.position_slider.value() / 1000.0)

	def _slider_value_changed(self, value: int) -> None:
		if self._seeking:
			self.waveform.set_position_ratio(value / 1000.0)

	def _seek_ratio(self, ratio: float) -> None:
		if self._player is None or self._duration_ms <= 0:
			return
		self._player.setPosition(int(self._duration_ms * ratio))

	def _player_position_changed(self, position: int) -> None:
		if self._duration_ms > 0:
			ratio = position / self._duration_ms
			if not self._seeking:
				self.position_slider.setValue(int(ratio * 1000))
			self.waveform.set_position_ratio(ratio)
		self.time_label.setText(f"{_format_ms(position)} / {_format_ms(self._duration_ms)}")

	def _player_duration_changed(self, duration: int) -> None:
		self._duration_ms = max(0, duration)
		self.time_label.setText(f"00:00 / {_format_ms(self._duration_ms)}")

	def _player_state_changed(self, state) -> None:
		if QMediaPlayer is not None and state == QMediaPlayer.PlaybackState.PlayingState:
			self.play_button.setText("Pause")
		else:
			self.play_button.setText("Play")

	def _player_status_changed(self, status) -> None:
		if QMediaPlayer is None:
			return
		if status == QMediaPlayer.MediaStatus.EndOfMedia and self.loop_check.isChecked():
			self._player.setPosition(0)
			self._player.play()

	def _open_json(self) -> None:
		entry = self.selected_entry()
		if entry is not None and entry.json_file is not None:
			open_path(entry.json_file)

	def _open_rpp(self) -> None:
		entry = self.selected_entry()
		if entry is not None and entry.rpp_file is not None:
			open_path(entry.rpp_file)

	def _open_options(self) -> None:
		entry = self.selected_entry()
		if entry is not None and entry.options_file.exists():
			open_path(entry.options_file)

	def _reveal_current(self) -> None:
		entry = self.selected_entry()
		if entry is None:
			return
		path = entry.audio_file or entry.json_file or entry.rpp_file
		if path is None and entry.options_file.exists():
			path = entry.options_file
		if path is None:
			return
		reveal_path(path)

	def _copy_audio_path(self) -> None:
		entry = self.selected_entry()
		if entry is not None and entry.audio_file is not None:
			QApplication.clipboard().setText(str(entry.audio_file))

	def _export_keepers(self) -> None:
		self._export_keeper_pack(keepers=True, rated=True, min_rating=4)

	def _export_rated(self) -> None:
		self._export_keeper_pack(keepers=False, rated=True, min_rating=4)

	def _export_keeper_pack(self, *, keepers: bool, rated: bool, min_rating: int) -> None:
		self._save_current_annotation(silent=True)
		if self._manifest_path is None:
			return
		default_dir = self._manifest_path.parent / "keepers"
		directory = QFileDialog.getExistingDirectory(self, "Choose keeper export folder", str(default_dir))
		if not directory:
			return
		result = export_keepers(
			self._manifest_path,
			directory,
			min_rating=min_rating,
			keepers=keepers,
			rated=rated,
		)
		self.status_label.setText(
			f"Exported {result.exported_count} take{'s' if result.exported_count != 1 else ''} to {result.destination}."
		)

	def _export_assembly(self) -> None:
		self._save_current_annotation(silent=True)
		if self._manifest_path is None:
			return
		default_dir = self._manifest_path.parent / "keepers"
		result = export_keepers(self._manifest_path, default_dir)
		default_path = result.destination / DEFAULT_ASSEMBLY_FILENAME
		path, _ = QFileDialog.getSaveFileName(
			self,
			"Export REAPER assembly",
			str(default_path),
			"REAPER projects (*.rpp);;All files (*)",
		)
		if not path:
			return
		assembly_path = export_reaper_assembly(result.manifest_path, path)
		self.status_label.setText(f"Exported REAPER assembly: {assembly_path}")

	def _export_ableton(self) -> None:
		self._save_current_annotation(silent=True)
		if self._manifest_path is None:
			return
		default_dir = self._manifest_path.parent / "keepers"
		result = export_keepers(self._manifest_path, default_dir)
		project_dir = QFileDialog.getExistingDirectory(
			self,
			"Choose Ableton project folder",
			str(result.destination / DEFAULT_ABLETON_PROJECT_DIRNAME),
		)
		if not project_dir:
			return
		ableton_path = export_ableton_project(result.manifest_path, project_dir)
		self.status_label.setText(f"Exported Ableton project folder: {ableton_path}")

	def keyPressEvent(self, event):  # noqa: N802 - Qt override
		if event.key() in (Qt.Key.Key_J, Qt.Key.Key_Down):
			self._select_relative(1)
			return
		if event.key() in (Qt.Key.Key_K, Qt.Key.Key_Up):
			self._select_relative(-1)
			return
		super().keyPressEvent(event)

	def _select_relative(self, offset: int) -> None:
		count = self.tree.topLevelItemCount()
		if count == 0:
			return
		current = self.tree.indexOfTopLevelItem(self.tree.currentItem())
		next_row = max(0, min(count - 1, current + offset if current >= 0 else 0))
		self.tree.setCurrentItem(self.tree.topLevelItem(next_row))


def _trim_note(note: str) -> str:
	collapsed = " ".join(note.split())
	if len(collapsed) <= 80:
		return collapsed
	return collapsed[:77] + "..."


def _format_ms(milliseconds: int) -> str:
	total_seconds = max(0, int(milliseconds / 1000))
	minutes, seconds = divmod(total_seconds, 60)
	return f"{minutes:02d}:{seconds:02d}"


__all__ = ["DEFAULT_TAGS", "TakeBrowserPanel", "WaveformWidget"]
