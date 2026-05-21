"""DAW-like take browser for TRANSMISSIONS batch renders."""

from __future__ import annotations

from pathlib import Path

from PySide6.QtCore import Qt, QUrl, Signal
from PySide6.QtGui import QColor, QPainter
from PySide6.QtWidgets import (
	QApplication,
	QCheckBox,
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
from .output_browser import open_path, reveal_path
from .take_manifest import TakeEntry, default_manifest_path, load_take_entries, save_take_annotation


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
		self.tree.setHeaderLabels(["Take", "Rating", "Keep", "Seed", "Audio", "Notes"])
		self.tree.itemSelectionChanged.connect(self._selection_changed)
		self.tree.itemDoubleClicked.connect(self._open_audio)

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

		editor_layout = QHBoxLayout()
		editor_layout.addWidget(QLabel("Rating"))
		editor_layout.addWidget(self.rating_spin)
		editor_layout.addWidget(self.keeper_check)
		editor_layout.addWidget(self.save_button)
		editor_layout.addStretch(1)

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
		button_layout.addStretch(1)

		layout = QVBoxLayout(self)
		layout.addWidget(self.status_label)
		layout.addWidget(self.tree, stretch=1)
		layout.addWidget(self.waveform)
		layout.addWidget(self.position_slider)
		layout.addWidget(self.time_label)
		layout.addLayout(editor_layout)
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
		for entry in self._entries:
			item = QTreeWidgetItem(
				[
					f"{entry.take:03d}  {entry.output_name}",
					str(entry.rating),
					"yes" if entry.keeper else "",
					"" if entry.random_seed is None else str(entry.random_seed),
					entry.audio_file.name if entry.audio_file else "",
					_trim_note(entry.notes),
				]
			)
			item.setData(0, Qt.ItemDataRole.UserRole, entry.output_name)
			self.tree.addTopLevelItem(item)
		self.tree.resizeColumnToContents(0)
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
		self.rating_spin.setEnabled(has_entry)
		self.keeper_check.setEnabled(has_entry)
		self.notes_edit.setEnabled(has_entry)

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


def _trim_note(note: str) -> str:
	collapsed = " ".join(note.split())
	if len(collapsed) <= 80:
		return collapsed
	return collapsed[:77] + "..."


def _format_ms(milliseconds: int) -> str:
	total_seconds = max(0, int(milliseconds / 1000))
	minutes, seconds = divmod(total_seconds, 60)
	return f"{minutes:02d}:{seconds:02d}"


__all__ = ["TakeBrowserPanel", "WaveformWidget"]
