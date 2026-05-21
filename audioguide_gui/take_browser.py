"""DAW-like take browser for TRANSMISSIONS batch renders."""

from __future__ import annotations

from pathlib import Path

from PySide6.QtCore import Qt
from PySide6.QtWidgets import (
	QApplication,
	QCheckBox,
	QHBoxLayout,
	QLabel,
	QPlainTextEdit,
	QPushButton,
	QSpinBox,
	QTreeWidget,
	QTreeWidgetItem,
	QVBoxLayout,
	QWidget,
)

from .output_browser import open_path, reveal_path
from .take_manifest import TakeEntry, default_manifest_path, load_take_entries, save_take_annotation


class TakeBrowserPanel(QWidget):
	"""Browse rendered takes, audition files, and save ratings/notes."""

	def __init__(self, parent: QWidget | None = None):
		super().__init__(parent)
		self._manifest_path: Path | None = None
		self._entries: list[TakeEntry] = []
		self._current_output_name: str | None = None
		self._loading_selection = False

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
		self.reveal_button = QPushButton("Reveal")
		self.reveal_button.clicked.connect(self._reveal_current)
		self.copy_button = QPushButton("Copy Audio Path")
		self.copy_button.clicked.connect(self._copy_audio_path)

		editor_layout = QHBoxLayout()
		editor_layout.addWidget(QLabel("Rating"))
		editor_layout.addWidget(self.rating_spin)
		editor_layout.addWidget(self.keeper_check)
		editor_layout.addWidget(self.save_button)
		editor_layout.addStretch(1)

		button_layout = QHBoxLayout()
		button_layout.addWidget(self.open_audio_button)
		button_layout.addWidget(self.open_json_button)
		button_layout.addWidget(self.open_rpp_button)
		button_layout.addWidget(self.open_options_button)
		button_layout.addWidget(self.reveal_button)
		button_layout.addWidget(self.copy_button)
		button_layout.addStretch(1)

		layout = QVBoxLayout(self)
		layout.addWidget(self.status_label)
		layout.addWidget(self.tree, stretch=1)
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
		self.open_json_button.setEnabled(bool(entry and entry.json_file))
		self.open_rpp_button.setEnabled(bool(entry and entry.rpp_file))
		self.open_options_button.setEnabled(bool(entry and entry.options_file.exists()))
		self.reveal_button.setEnabled(has_entry)
		self.copy_button.setEnabled(bool(entry and entry.audio_file))
		self.rating_spin.setEnabled(has_entry)
		self.keeper_check.setEnabled(has_entry)
		self.notes_edit.setEnabled(has_entry)

	def _open_audio(self, *_args: object) -> None:
		entry = self.selected_entry()
		if entry is not None and entry.audio_file is not None:
			open_path(entry.audio_file)

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


__all__ = ["TakeBrowserPanel"]
