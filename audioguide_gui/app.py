"""PySide6 application and main window for the AudioGuide GUI."""

from __future__ import annotations

from concurrent.futures import Future
from dataclasses import replace
from pathlib import Path
import shlex
import sys

from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtGui import QAction
from PySide6.QtWidgets import (
	QApplication,
	QCheckBox,
	QComboBox,
	QDialog,
	QDialogButtonBox,
	QDoubleSpinBox,
	QFileDialog,
	QGroupBox,
	QHBoxLayout,
	QLabel,
	QLineEdit,
	QMainWindow,
	QPlainTextEdit,
	QPushButton,
	QSpinBox,
	QTabWidget,
	QTextBrowser,
	QVBoxLayout,
	QWidget,
)

from .option_builder import OptionBuilder, OptionBuilderError
from .output_browser import OutputBrowserPanel
from .presets import CreativePreset, PresetError, list_presets, render_preset_options
from .project import (
	PROJECT_FILE_EXTENSION,
	AudioGuideProject,
	ProjectConfig,
	ProjectFileError,
	load_project_file,
	save_project_file,
)
from .render_manifest import write_render_manifest
from .runner import AudioGuideRunner, AudioGuideToolRunner, RunnerError, bundled_resource_path
from .take_browser import TakeBrowserPanel
from .tutorial import GUIDED_TOUR_STEPS, GuidedTourStep, render_tutorial_html


class PathPicker(QWidget):
	"""A labeled path field with a browse button."""

	def __init__(self, label: str, dialog_title: str, mode: str, parent: QWidget | None = None):
		super().__init__(parent)
		self._dialog_title = dialog_title
		self._mode = mode

		self.label = QLabel(label)
		self.path_edit = QLineEdit()
		self.path_edit.setReadOnly(True)
		if self._mode == "file_or_directory":
			self.browse_button = QPushButton("Browse File…")
			self.folder_button = QPushButton("Browse Folder…")
			self.folder_button.clicked.connect(self._choose_directory)
		else:
			self.browse_button = QPushButton("Browse…")
			self.folder_button = None
		self.browse_button.clicked.connect(self._choose_path)

		layout = QHBoxLayout(self)
		layout.addWidget(self.label)
		layout.addWidget(self.path_edit, stretch=1)
		layout.addWidget(self.browse_button)
		if self.folder_button is not None:
			layout.addWidget(self.folder_button)

	@property
	def path(self) -> str:
		"""Return the selected path as text."""
		return self.path_edit.text().strip()

	def set_path(self, path: str) -> None:
		"""Set the selected path text."""
		self.path_edit.setText(path)

	def set_enabled(self, enabled: bool) -> None:
		"""Enable or disable editing controls for this picker."""
		self.browse_button.setEnabled(enabled)
		if self.folder_button is not None:
			self.folder_button.setEnabled(enabled)

	def _choose_path(self) -> None:
		if self._mode == "file":
			path, _ = QFileDialog.getOpenFileName(self, self._dialog_title)
		elif self._mode == "save_file":
			path, _ = QFileDialog.getSaveFileName(self, self._dialog_title)
		elif self._mode == "file_or_directory":
			path, _ = QFileDialog.getOpenFileName(self, self._dialog_title)
		else:
			path = QFileDialog.getExistingDirectory(self, self._dialog_title)
		if path:
			self.path_edit.setText(path)

	def _choose_directory(self) -> None:
		path = QFileDialog.getExistingDirectory(self, self._dialog_title)
		if path:
			self.path_edit.setText(path)


class _RunnerSignals(QObject):
	"""Qt signal bridge for runner callbacks emitted from worker threads."""

	log_updated = Signal(str)
	future_done = Signal(object)


class ToolPanel(QWidget):
	"""GUI wrapper for one AudioGuide utility script."""

	def __init__(
		self,
		*,
		title: str,
		script_name: str,
		input_label: str,
		output_label: str | None,
		output_flag: str | None,
		parent: QWidget | None = None,
	):
		super().__init__(parent)
		self._title = title
		self._script_path = bundled_resource_path(script_name)
		self._output_flag = output_flag
		self._runner: AudioGuideToolRunner | None = None
		self._future: Future[int] | None = None
		self._cancel_requested = False
		self._signals = _RunnerSignals(self)
		self._signals.log_updated.connect(self._append_log)
		self._signals.future_done.connect(self._run_finished)

		description = QLabel(f"Run {script_name} from the GUI.")
		self.input_picker = PathPicker(input_label, f"Choose input for {title}", "file_or_directory")
		self.output_picker: PathPicker | None = None
		if output_label is not None:
			self.output_picker = PathPicker(output_label, f"Choose output for {title}", "save_file")

		self.arguments_edit = QLineEdit()
		self.arguments_edit.setPlaceholderText("Advanced flags, e.g. -t -45 --minimum 0.2")
		arguments_layout = QHBoxLayout()
		arguments_layout.addWidget(QLabel("Advanced flags"))
		arguments_layout.addWidget(self.arguments_edit, stretch=1)

		self.run_button = QPushButton("Run")
		self.run_button.clicked.connect(self._run_clicked)
		self.cancel_button = QPushButton("Cancel")
		self.cancel_button.setEnabled(False)
		self.cancel_button.clicked.connect(self._cancel_clicked)
		button_layout = QHBoxLayout()
		button_layout.addStretch(1)
		button_layout.addWidget(self.cancel_button)
		button_layout.addWidget(self.run_button)

		self.log_output = QPlainTextEdit()
		self.log_output.setReadOnly(True)
		self.log_output.setPlaceholderText(f"{script_name} log output will appear here.")

		layout = QVBoxLayout(self)
		layout.addWidget(description)
		layout.addWidget(self.input_picker)
		if self.output_picker is not None:
			layout.addWidget(self.output_picker)
		layout.addLayout(arguments_layout)
		layout.addLayout(button_layout)
		layout.addWidget(QLabel("Live log output"))
		layout.addWidget(self.log_output, stretch=1)

	def _build_arguments(self) -> list[str]:
		input_path = self.input_picker.path
		if not input_path:
			raise ValueError("Choose an input file or folder before running this tool.")

		try:
			advanced_args = shlex.split(self.arguments_edit.text())
		except ValueError as exc:
			raise ValueError(f"Cannot parse advanced flags: {exc}") from exc

		arguments = list(advanced_args)
		if self.output_picker is not None:
			output_path = self.output_picker.path
			if self._output_flag is None:
				if not output_path:
					raise ValueError("Choose an output location before running this tool.")
				arguments.extend([input_path, output_path])
			else:
				if output_path:
					arguments.extend([self._output_flag, output_path])
				arguments.append(input_path)
		else:
			arguments.append(input_path)
		return arguments

	def _run_clicked(self) -> None:
		try:
			arguments = self._build_arguments()
		except ValueError as exc:
			self._append_log(f"Cannot run {self._title}: {exc}")
			return

		self.log_output.clear()
		self._cancel_requested = False
		self._runner = AudioGuideToolRunner(self._script_path, arguments)
		self._runner.add_log_callback(lambda line: self._signals.log_updated.emit(line))
		self._runner.add_error_callback(lambda message: self._signals.log_updated.emit(f"Runner error: {message}"))

		try:
			self._future = self._runner.start()
		except RunnerError as exc:
			self._append_log(f"Cannot run {self._title}: {exc}")
			return

		self._set_running(True)
		self._future.add_done_callback(lambda future: self._signals.future_done.emit(future))

	def _cancel_clicked(self) -> None:
		if self._runner is None:
			return
		self._cancel_requested = True
		self._append_log(f"Cancellation requested for {self._title}…")
		self._runner.cancel()
		self.cancel_button.setEnabled(False)

	@Slot(str)
	def _append_log(self, line: str) -> None:
		self.log_output.appendPlainText(line)

	@Slot(object)
	def _run_finished(self, future: Future[int]) -> None:
		self._set_running(False)
		try:
			exit_code = future.result()
		except Exception as exc:
			self._append_log(f"{self._title} failed: {exc}")
			return
		if self._cancel_requested:
			self._append_log(f"{self._title} cancelled with exit code {exit_code}.")
		elif exit_code == 0:
			self._append_log(f"{self._title} finished successfully.")
		else:
			self._append_log(f"{self._title} exited with code {exit_code}.")

	def _set_running(self, running: bool) -> None:
		self.run_button.setEnabled(not running)
		self.cancel_button.setEnabled(running)
		self.input_picker.set_enabled(not running)
		if self.output_picker is not None:
			self.output_picker.set_enabled(not running)
		self.arguments_edit.setEnabled(not running)


class TutorialPanel(QWidget):
	"""Read-only guided tutorial embedded in the GUI."""

	def __init__(self, parent: QWidget | None = None):
		super().__init__(parent)
		self.start_tour_button = QPushButton("Start Guided Tour")
		browser = QTextBrowser()
		browser.setOpenExternalLinks(True)
		browser.setHtml(render_tutorial_html())

		layout = QVBoxLayout(self)
		layout.addWidget(self.start_tour_button)
		layout.addWidget(browser)


class GuidedTourDialog(QDialog):
	"""Small stepper dialog for walking through the GUI."""

	def __init__(self, steps: tuple[GuidedTourStep, ...], parent: QWidget | None = None):
		super().__init__(parent)
		self._steps = steps
		self._index = 0
		self.setWindowTitle("Guided Tour")
		self.resize(460, 260)

		self.step_label = QLabel("")
		self.step_label.setWordWrap(True)
		self.body_label = QLabel("")
		self.body_label.setWordWrap(True)
		self.location_label = QLabel("")
		self.location_label.setWordWrap(True)

		self.previous_button = QPushButton("Previous")
		self.previous_button.clicked.connect(self.previous_step)
		self.next_button = QPushButton("Next")
		self.next_button.clicked.connect(self.next_step)
		self.close_button = QPushButton("Close")
		self.close_button.clicked.connect(self.accept)

		button_layout = QHBoxLayout()
		button_layout.addWidget(self.previous_button)
		button_layout.addWidget(self.next_button)
		button_layout.addStretch(1)
		button_layout.addWidget(self.close_button)

		layout = QVBoxLayout(self)
		layout.addWidget(self.step_label)
		layout.addWidget(self.location_label)
		layout.addWidget(self.body_label, stretch=1)
		layout.addLayout(button_layout)
		self._render()

	def current_step(self) -> GuidedTourStep:
		"""Return the currently displayed guided-tour step."""
		return self._steps[self._index]

	def next_step(self) -> None:
		"""Advance to the next tour step."""
		if self._index < len(self._steps) - 1:
			self._index += 1
			self._render()

	def previous_step(self) -> None:
		"""Return to the previous tour step."""
		if self._index > 0:
			self._index -= 1
			self._render()

	def _render(self) -> None:
		step = self.current_step()
		self.step_label.setText(f"{self._index + 1}/{len(self._steps)}  {step.title}")
		self.location_label.setText(f"Go to tab: {step.tab}")
		self.body_label.setText(step.body)
		self.previous_button.setEnabled(self._index > 0)
		self.next_button.setEnabled(self._index < len(self._steps) - 1)


class MainWindow(QMainWindow):
	"""AudioGuide GUI window that builds options and launches renders."""

	def __init__(self):
		super().__init__()
		self.setWindowTitle("AudioGuide GUI")
		self.resize(800, 560)

		self._option_builder = OptionBuilder()
		self._runner: AudioGuideRunner | None = None
		self._render_future: Future[int] | None = None
		self._cancel_requested = False
		self._current_project_path: Path | None = None
		self._last_options_file_path = ""
		self._last_render_output_dir = ""
		self._render_jobs: list[tuple[ProjectConfig, Path]] = []
		self._active_render_job_index = -1
		self._signals = _RunnerSignals(self)
		self._signals.log_updated.connect(self._append_log)
		self._signals.future_done.connect(self._render_finished)

		self._create_project_menu()
		self._create_help_menu()

		self.target_picker = PathPicker("Target sound file", "Choose target sound file", "file")
		self.corpus_picker = PathPicker("Corpus folder", "Choose corpus folder", "directory")
		self.drums_picker = PathPicker("Drums", "Choose drum corpus folder", "directory")
		self.vocals_picker = PathPicker("Vocals", "Choose vocal corpus folder", "directory")
		self.noise_picker = PathPicker("Noise", "Choose noise corpus folder", "directory")
		self.output_picker = PathPicker("Output folder", "Choose output folder", "directory")

		self.output_name_edit = QLineEdit("output")
		output_name_layout = QHBoxLayout()
		output_name_layout.addWidget(QLabel("Output name"))
		output_name_layout.addWidget(self.output_name_edit, stretch=1)

		self.csound_checkbox = QCheckBox("Csound audio render")
		self.csound_checkbox.setChecked(True)
		self.json_checkbox = QCheckBox("JSON dictionary")
		self.json_checkbox.setChecked(True)
		self.reaper_checkbox = QCheckBox("Reaper project")
		self.aaf_checkbox = QCheckBox("AAF")

		formats_layout = QHBoxLayout()
		formats_layout.addWidget(self.csound_checkbox)
		formats_layout.addWidget(self.json_checkbox)
		formats_layout.addWidget(self.reaper_checkbox)
		formats_layout.addWidget(self.aaf_checkbox)
		formats_layout.addStretch(1)

		formats_group = QGroupBox("Output Formats")
		formats_group.setLayout(formats_layout)
		self.output_formats_group = formats_group

		self._presets = list_presets()
		self.preset_combo = QComboBox()
		self.preset_combo.addItem("Custom", "")
		for preset in self._presets:
			self.preset_combo.addItem(preset.label, preset.name)
		self.preset_combo.currentIndexChanged.connect(self._preset_selection_changed)
		self.apply_preset_button = QPushButton("Apply Preset")
		self.apply_preset_button.clicked.connect(self._apply_selected_preset)
		self.preset_description = QLabel("")
		self.preset_description.setWordWrap(True)
		self.candidate_percent_spin = QSpinBox()
		self.candidate_percent_spin.setRange(1, 100)
		self.candidate_percent_spin.setValue(25)
		self.max_segment_spin = QDoubleSpinBox()
		self.max_segment_spin.setRange(0.1, 32.0)
		self.max_segment_spin.setSingleStep(0.1)
		self.max_segment_spin.setValue(1.0)
		self.max_overlap_spin = QSpinBox()
		self.max_overlap_spin.setRange(1, 32)
		self.max_overlap_spin.setValue(4)
		self.output_gain_spin = QSpinBox()
		self.output_gain_spin.setRange(-48, 12)
		self.output_gain_spin.setValue(-3)
		self.density_spin = QSpinBox()
		self.density_spin.setRange(1, 32)
		self.density_spin.setValue(4)
		self.chop_size_spin = QDoubleSpinBox()
		self.chop_size_spin.setRange(0.05, 16.0)
		self.chop_size_spin.setSingleStep(0.05)
		self.chop_size_spin.setValue(0.5)
		self.chaos_spin = QSpinBox()
		self.chaos_spin.setRange(1, 100)
		self.chaos_spin.setValue(25)
		self.timbre_bias_spin = QSpinBox()
		self.timbre_bias_spin.setRange(1, 100)
		self.timbre_bias_spin.setValue(25)
		self.rhythm_lock_spin = QSpinBox()
		self.rhythm_lock_spin.setRange(1, 100)
		self.rhythm_lock_spin.setValue(20)

		preset_picker_layout = QHBoxLayout()
		preset_picker_layout.addWidget(QLabel("Preset"))
		preset_picker_layout.addWidget(self.preset_combo, stretch=1)
		preset_picker_layout.addWidget(self.apply_preset_button)

		preset_layout = QVBoxLayout()
		preset_layout.addLayout(preset_picker_layout)
		preset_layout.addWidget(self.preset_description)
		parameter_layout = QHBoxLayout()
		parameter_layout.addWidget(QLabel("Pool %"))
		parameter_layout.addWidget(self.candidate_percent_spin)
		parameter_layout.addWidget(QLabel("Max seg"))
		parameter_layout.addWidget(self.max_segment_spin)
		parameter_layout.addWidget(QLabel("Overlap"))
		parameter_layout.addWidget(self.max_overlap_spin)
		parameter_layout.addWidget(QLabel("Gain"))
		parameter_layout.addWidget(self.output_gain_spin)
		preset_layout.addLayout(parameter_layout)
		macro_layout = QHBoxLayout()
		macro_layout.addWidget(QLabel("Density"))
		macro_layout.addWidget(self.density_spin)
		macro_layout.addWidget(QLabel("Chop"))
		macro_layout.addWidget(self.chop_size_spin)
		macro_layout.addWidget(QLabel("Chaos"))
		macro_layout.addWidget(self.chaos_spin)
		macro_layout.addWidget(QLabel("Timbre"))
		macro_layout.addWidget(self.timbre_bias_spin)
		macro_layout.addWidget(QLabel("Rhythm"))
		macro_layout.addWidget(self.rhythm_lock_spin)
		preset_layout.addLayout(macro_layout)

		self.preset_group = QGroupBox("TRANSMISSIONS Preset")
		self.preset_group.setLayout(preset_layout)

		self.take_count_spin = QSpinBox()
		self.take_count_spin.setRange(1, 99)
		self.take_count_spin.setValue(1)
		self.random_seed_edit = QLineEdit()
		self.random_seed_edit.setPlaceholderText("blank = timestamp/random")
		batch_layout = QHBoxLayout()
		batch_layout.addWidget(QLabel("Takes"))
		batch_layout.addWidget(self.take_count_spin)
		batch_layout.addWidget(QLabel("Seed"))
		batch_layout.addWidget(self.random_seed_edit, stretch=1)
		self.batch_group = QGroupBox("Batch Variations")
		self.batch_group.setLayout(batch_layout)

		self.advanced_options_edit = QPlainTextEdit()
		self.advanced_options_edit.setPlaceholderText(
			"Paste raw AudioGuide option syntax here. Text is preserved verbatim and appended "
			"after generated settings."
		)

		self.preview_options_button = QPushButton("Preview Generated Options File")
		self.preview_options_button.clicked.connect(self._preview_options_clicked)
		self.save_options_button = QPushButton("Save Options File As…")
		self.save_options_button.clicked.connect(self._save_options_clicked)
		self.load_options_button = QPushButton("Load Existing Options File…")
		self.load_options_button.clicked.connect(self._load_options_clicked)

		advanced_button_layout = QHBoxLayout()
		advanced_button_layout.addWidget(self.preview_options_button)
		advanced_button_layout.addWidget(self.save_options_button)
		advanced_button_layout.addWidget(self.load_options_button)
		advanced_button_layout.addStretch(1)

		advanced_layout = QVBoxLayout()
		advanced_layout.addWidget(QLabel("Raw AudioGuide options"))
		advanced_layout.addWidget(self.advanced_options_edit, stretch=1)
		advanced_layout.addLayout(advanced_button_layout)

		self.advanced_options_group = QGroupBox("Advanced Options")
		self.advanced_options_group.setLayout(advanced_layout)

		self.render_button = QPushButton("Render")
		self.render_button.clicked.connect(self._render_clicked)
		self.cancel_button = QPushButton("Cancel")
		self.cancel_button.setEnabled(False)
		self.cancel_button.clicked.connect(self._cancel_clicked)

		button_layout = QHBoxLayout()
		button_layout.addStretch(1)
		button_layout.addWidget(self.cancel_button)
		button_layout.addWidget(self.render_button)

		self.output_browser = OutputBrowserPanel()
		self.take_browser = TakeBrowserPanel()

		self.log_output = QPlainTextEdit()
		self.log_output.setReadOnly(True)
		self.log_output.setPlaceholderText("AudioGuide GUI log output will appear here.")

		render_layout = QVBoxLayout()
		render_layout.addWidget(self.target_picker)
		render_layout.addWidget(self.corpus_picker)
		render_layout.addWidget(self.drums_picker)
		render_layout.addWidget(self.vocals_picker)
		render_layout.addWidget(self.noise_picker)
		render_layout.addWidget(self.output_picker)
		render_layout.addLayout(output_name_layout)
		render_layout.addWidget(self.output_formats_group)
		render_layout.addWidget(self.preset_group)
		render_layout.addWidget(self.batch_group)
		render_layout.addWidget(self.advanced_options_group, stretch=1)
		render_layout.addLayout(button_layout)
		render_layout.addWidget(QLabel("Log output"))
		render_layout.addWidget(self.log_output, stretch=1)

		render_tab = QWidget()
		render_tab.setLayout(render_layout)

		tools_tabs = QTabWidget()
		tools_tabs.addTab(
			ToolPanel(
				title="Segment Sound File",
				script_name="agSegmentSf.py",
				input_label="Sound file or folder",
				output_label="Segmentation output file",
				output_flag="-f",
			),
			"Segment",
		)
		tools_tabs.addTab(
			ToolPanel(
				title="Get Sound File Descriptors",
				script_name="agGetSfDescriptors.py",
				input_label="Sound file or folder",
				output_label="Descriptor JSON output file",
				output_flag=None,
			),
			"Descriptors",
		)
		tools_tabs.addTab(
			ToolPanel(
				title="Granulate Sound File",
				script_name="agGranulateSf.py",
				input_label="Sound file or folder",
				output_label="Segmentation output file",
				output_flag="-f",
			),
			"Granulate",
		)

		self.tutorial_panel = TutorialPanel()
		self.tutorial_panel.start_tour_button.clicked.connect(self._start_guided_tour)
		self._tour_dialog: GuidedTourDialog | None = None

		self.main_tabs = QTabWidget()
		self.main_tabs.addTab(render_tab, "Render")
		self.main_tabs.addTab(self.take_browser, "Takes")
		self.main_tabs.addTab(self.output_browser, "Output Browser")
		self.main_tabs.addTab(tools_tabs, "Tools")
		self.main_tabs.addTab(self.tutorial_panel, "Tutorial")
		self.setCentralWidget(self.main_tabs)
		self._update_window_title()

	def _create_project_menu(self) -> None:
		project_menu = self.menuBar().addMenu("Project")

		self.new_project_action = QAction("New Project", self)
		self.new_project_action.triggered.connect(self._new_project_clicked)
		project_menu.addAction(self.new_project_action)

		self.open_project_action = QAction("Open Project", self)
		self.open_project_action.triggered.connect(self._open_project_clicked)
		project_menu.addAction(self.open_project_action)

		project_menu.addSeparator()

		self.save_project_action = QAction("Save Project", self)
		self.save_project_action.triggered.connect(self._save_project_clicked)
		project_menu.addAction(self.save_project_action)

		self.save_project_as_action = QAction("Save Project As", self)
		self.save_project_as_action.triggered.connect(self._save_project_as_clicked)
		project_menu.addAction(self.save_project_as_action)

	def _create_help_menu(self) -> None:
		help_menu = self.menuBar().addMenu("Help")

		self.show_tutorial_action = QAction("Show Tutorial", self)
		self.show_tutorial_action.triggered.connect(self._show_tutorial_clicked)
		help_menu.addAction(self.show_tutorial_action)

	def _show_tutorial_clicked(self) -> None:
		self.main_tabs.setCurrentWidget(self.tutorial_panel)

	def _start_guided_tour(self) -> None:
		self._tour_dialog = GuidedTourDialog(GUIDED_TOUR_STEPS, self)
		self._tour_dialog.next_button.clicked.connect(self._sync_guided_tour_tab)
		self._tour_dialog.previous_button.clicked.connect(self._sync_guided_tour_tab)
		self._sync_guided_tour_tab()
		self._tour_dialog.show()

	def _sync_guided_tour_tab(self) -> None:
		if self._tour_dialog is None:
			return
		tab_name = self._tour_dialog.current_step().tab
		for index in range(self.main_tabs.count()):
			if self.main_tabs.tabText(index) == tab_name:
				self.main_tabs.setCurrentIndex(index)
				return

	def _project_from_inputs(self) -> AudioGuideProject:
		return AudioGuideProject(
			target_sound_file=self.target_picker.path,
			corpus_folder=self.corpus_picker.path,
			output_folder=self.output_picker.path,
		)

	def _config_from_inputs(self) -> ProjectConfig:
		project = self._project_from_inputs()
		config = project.to_config()
		config.output_name = self.output_name_edit.text().strip() or "output"
		config.render_csound = self.csound_checkbox.isChecked()
		config.output_json = self.json_checkbox.isChecked()
		config.output_reaper = self.reaper_checkbox.isChecked()
		config.output_aaf = self.aaf_checkbox.isChecked()
		config.extra_options_text = self.advanced_options_edit.toPlainText()
		config.last_options_file_path = self._last_options_file_path
		config.preset_name = str(self.preset_combo.currentData() or "")
		config.preset_parameters = self._preset_parameters_from_inputs()
		config.random_seed = self._random_seed_from_input()
		config.take_count = self.take_count_spin.value()
		config.corpus_groups = self._corpus_groups_from_inputs()
		return config

	def _apply_config(self, config: ProjectConfig) -> None:
		self.target_picker.set_path(config.target_path)
		self.corpus_picker.set_path(config.corpus_paths[0] if config.corpus_paths else "")
		self.output_picker.set_path(config.output_dir)
		self.output_name_edit.setText(config.output_name or "output")
		self.csound_checkbox.setChecked(config.render_csound)
		self.json_checkbox.setChecked(config.output_json)
		self.reaper_checkbox.setChecked(config.output_reaper)
		self.aaf_checkbox.setChecked(config.output_aaf)
		self.advanced_options_edit.setPlainText(config.extra_options_text)
		self._last_options_file_path = config.last_options_file_path
		self._select_preset(config.preset_name)
		self._apply_preset_parameters(config.preset_parameters)
		self.random_seed_edit.setText("" if config.random_seed is None else str(config.random_seed))
		self.take_count_spin.setValue(max(1, config.take_count))
		self.drums_picker.set_path((config.corpus_groups.get("drums") or [""])[0])
		self.vocals_picker.set_path((config.corpus_groups.get("vocals") or [""])[0])
		self.noise_picker.set_path((config.corpus_groups.get("noise") or [""])[0])

	def _preset_selection_changed(self, *_args: object) -> None:
		preset = self._selected_preset()
		if preset is None:
			self.preset_description.setText("")
		else:
			self.preset_description.setText(preset.description)
			self._apply_preset_parameters(preset.parameters)

	def _apply_selected_preset(self) -> None:
		preset = self._selected_preset()
		if preset is None:
			return
		self._set_output_formats(preset.output_formats)
		self.advanced_options_edit.setPlainText(render_preset_options(preset, self._preset_parameters_from_inputs()))
		self._append_log(f"Applied preset: {preset.label}")

	def _selected_preset(self) -> CreativePreset | None:
		name = str(self.preset_combo.currentData() or "")
		if not name:
			return None
		for preset in self._presets:
			if preset.name == name:
				return preset
		return None

	def _select_preset(self, name: str) -> None:
		index = self.preset_combo.findData(name)
		self.preset_combo.setCurrentIndex(index if index >= 0 else 0)

	def _set_output_formats(self, formats: tuple[str, ...]) -> None:
		selected_formats = set(formats)
		self.csound_checkbox.setChecked("csound" in selected_formats)
		self.json_checkbox.setChecked("json" in selected_formats)
		self.reaper_checkbox.setChecked("reaper" in selected_formats)
		self.aaf_checkbox.setChecked("aaf" in selected_formats)

	def _preset_parameters_from_inputs(self) -> dict[str, float | int]:
		candidate_percent = self.candidate_percent_spin.value()
		return {
			"duration_percent": candidate_percent,
			"color_percent": candidate_percent,
			"voice_percent": candidate_percent,
			"noise_percent": candidate_percent,
			"timbre_percent": candidate_percent,
			"max_segment": self.max_segment_spin.value(),
			"max_overlap": self.max_overlap_spin.value(),
			"output_gain_db": self.output_gain_spin.value(),
			"density": self.density_spin.value(),
			"chop_size": self.chop_size_spin.value(),
			"chaos": self.chaos_spin.value(),
			"timbre_bias": self.timbre_bias_spin.value(),
			"rhythm_lock": self.rhythm_lock_spin.value(),
		}

	def _apply_preset_parameters(self, parameters: dict[str, object]) -> None:
		percent = int(
			parameters.get(
				"duration_percent",
				parameters.get("noise_percent", parameters.get("timbre_percent", self.candidate_percent_spin.value())),
			)
		)
		self.candidate_percent_spin.setValue(percent)
		self.max_segment_spin.setValue(float(parameters.get("max_segment", self.max_segment_spin.value())))
		self.max_overlap_spin.setValue(int(parameters.get("max_overlap", self.max_overlap_spin.value())))
		self.output_gain_spin.setValue(int(parameters.get("output_gain_db", self.output_gain_spin.value())))
		self.density_spin.setValue(int(parameters.get("density", self.density_spin.value())))
		self.chop_size_spin.setValue(float(parameters.get("chop_size", self.chop_size_spin.value())))
		self.chaos_spin.setValue(int(parameters.get("chaos", self.chaos_spin.value())))
		self.timbre_bias_spin.setValue(int(parameters.get("timbre_bias", self.timbre_bias_spin.value())))
		self.rhythm_lock_spin.setValue(int(parameters.get("rhythm_lock", self.rhythm_lock_spin.value())))

	def _corpus_groups_from_inputs(self) -> dict[str, list[str]]:
		groups: dict[str, list[str]] = {}
		for role, picker in (
			("drums", self.drums_picker),
			("vocals", self.vocals_picker),
			("noise", self.noise_picker),
		):
			if picker.path:
				groups[role] = [picker.path]
		return groups

	def _random_seed_from_input(self) -> int | None:
		text = self.random_seed_edit.text().strip()
		if not text:
			return None
		try:
			return int(text)
		except ValueError as exc:
			raise ValueError("seed must be a whole number") from exc

	def _new_project_clicked(self) -> None:
		self._current_project_path = None
		self._apply_config(ProjectConfig())
		self.log_output.clear()
		self.output_browser.clear()
		self.take_browser.clear()
		self._last_render_output_dir = ""
		self._append_log("Started a new project.")
		self._update_window_title()

	def _open_project_clicked(self) -> None:
		path, _ = QFileDialog.getOpenFileName(
			self,
			"Open AudioGuide project",
			"",
			f"AudioGuide projects (*{PROJECT_FILE_EXTENSION});;JSON files (*.json);;All files (*)",
		)
		if not path:
			return
		try:
			config = load_project_file(path)
		except ProjectFileError as exc:
			self._append_log(f"Cannot open project: {exc}")
			return
		self._current_project_path = Path(path)
		self._apply_config(config)
		self.output_browser.clear()
		self.take_browser.clear()
		self._last_render_output_dir = ""
		self._append_log(f"Opened project: {self._current_project_path}")
		self._update_window_title()

	def _save_project_clicked(self) -> None:
		if self._current_project_path is None:
			self._save_project_as_clicked()
			return
		self._save_project_to(self._current_project_path)

	def _save_project_as_clicked(self) -> None:
		default_path = self._current_project_path or Path.cwd() / f"audioguide-project{PROJECT_FILE_EXTENSION}"
		path, _ = QFileDialog.getSaveFileName(
			self,
			"Save AudioGuide project",
			str(default_path),
			f"AudioGuide projects (*{PROJECT_FILE_EXTENSION});;JSON files (*.json);;All files (*)",
		)
		if not path:
			return
		self._save_project_to(Path(path))

	def _save_project_to(self, path: Path) -> None:
		try:
			written_path = save_project_file(self._config_from_inputs(), path)
		except ProjectFileError as exc:
			self._append_log(f"Cannot save project: {exc}")
			return
		self._current_project_path = written_path
		self._append_log(f"Saved project: {written_path}")
		self._update_window_title()

	def _preview_options_clicked(self) -> None:
		try:
			options_text = self._option_builder.build(self._config_from_inputs())
		except (OptionBuilderError, ValueError) as exc:
			self._append_log(f"Cannot preview options file: {exc}")
			return

		dialog = QDialog(self)
		dialog.setWindowTitle("Preview Generated Options File")
		dialog.resize(700, 500)

		preview_edit = QPlainTextEdit(dialog)
		preview_edit.setReadOnly(True)
		preview_edit.setPlainText(options_text)

		buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Close, dialog)
		buttons.rejected.connect(dialog.reject)

		layout = QVBoxLayout(dialog)
		layout.addWidget(preview_edit)
		layout.addWidget(buttons)
		dialog.exec()

	def _save_options_clicked(self) -> None:
		path, _ = QFileDialog.getSaveFileName(
			self,
			"Save AudioGuide options file",
			"audioguide-options.py",
			"Python files (*.py);;All files (*)",
		)
		if not path:
			return

		try:
			written_path = self._option_builder.build_file(self._config_from_inputs(), path)
		except (OptionBuilderError, OSError, ValueError) as exc:
			self._append_log(f"Cannot save options file: {exc}")
			return
		self._last_options_file_path = str(written_path)
		self._append_log(f"Saved options file: {written_path}")

	def _load_options_clicked(self) -> None:
		path, _ = QFileDialog.getOpenFileName(
			self,
			"Load AudioGuide options file",
			"",
			"Python files (*.py);;All files (*)",
		)
		if not path:
			return

		try:
			options_text = Path(path).read_text(encoding="utf-8")
		except OSError as exc:
			self._append_log(f"Cannot load options file: {exc}")
			return

		self.advanced_options_edit.setPlainText(options_text)
		self._last_options_file_path = path
		self._append_log(f"Loaded raw options text: {path}")

	def _render_clicked(self) -> None:
		if self._runner is not None and self._runner.is_running:
			self._append_log("Render is already running.")
			return

		self.log_output.clear()
		self.output_browser.clear()
		self.take_browser.clear()
		try:
			config = self._config_from_inputs()
			self._validate_config(config)
			jobs = self._build_render_jobs(config)
		except (OptionBuilderError, OSError, PresetError, RunnerError, ValueError) as exc:
			self._append_log(f"Cannot start render: {exc}")
			return

		self._render_jobs = jobs
		self._active_render_job_index = -1
		self._last_options_file_path = str(jobs[-1][1])
		self._last_render_output_dir = config.output_dir
		self._append_log("Render requested." if len(jobs) == 1 else f"Batch render requested: {len(jobs)} takes.")
		self._append_log(f"Target sound file: {config.target_path}")
		if config.corpus_paths:
			self._append_log(f"Corpus folder: {config.corpus_paths[0]}")
		if config.corpus_groups:
			self._append_log(f"Corpus roles: {', '.join(sorted(config.corpus_groups))}")
		self._append_log(f"Output folder: {config.output_dir}")

		self._set_running_state(True)
		self._cancel_requested = False
		self._start_next_render_job()

	def _cancel_clicked(self) -> None:
		if self._runner is None or not self._runner.is_running:
			return
		self._cancel_requested = True
		self.cancel_button.setEnabled(False)
		self._append_log("Cancel requested. Stopping AudioGuide…")
		self._runner.cancel()

	def _validate_config(self, config: ProjectConfig) -> None:
		target_path = Path(config.target_path).expanduser()
		if not config.target_path:
			raise ValueError("choose a target sound file")
		if not target_path.exists() or not target_path.is_file():
			raise ValueError(f'target sound file does not exist: "{target_path}"')

		if not config.corpus_paths and not any(config.corpus_groups.values()):
			raise ValueError("choose a corpus folder or corpus role folder")
		if config.corpus_paths and config.corpus_paths[0]:
			corpus_path = Path(config.corpus_paths[0]).expanduser()
			if not corpus_path.exists() or not corpus_path.is_dir():
				raise ValueError(f'corpus folder does not exist: "{corpus_path}"')
		for role, paths in config.corpus_groups.items():
			for path_text in paths:
				group_path = Path(path_text).expanduser()
				if not group_path.exists() or not group_path.is_dir():
					raise ValueError(f'{role} corpus folder does not exist: "{group_path}"')

		if not config.output_dir:
			raise ValueError("choose an output folder")
		output_dir = Path(config.output_dir).expanduser()
		if not output_dir.exists() or not output_dir.is_dir():
			raise ValueError(f'output folder does not exist: "{output_dir}"')

	def _build_render_jobs(self, config: ProjectConfig) -> list[tuple[ProjectConfig, Path]]:
		jobs: list[tuple[ProjectConfig, Path]] = []
		for take_index in range(max(1, config.take_count)):
			take_config = self._config_for_take(config, take_index)
			options_path = self._options_path_for_config(take_config, take_index if config.take_count > 1 else None)
			self._option_builder.build_file(take_config, options_path)
			jobs.append((take_config, options_path))
		manifest_path = write_render_manifest(jobs)
		self._append_log(f"Wrote render manifest: {manifest_path}")
		return jobs

	def _config_for_take(self, config: ProjectConfig, take_index: int) -> ProjectConfig:
		if config.take_count <= 1:
			return config
		seed = None if config.random_seed is None else config.random_seed + take_index
		return replace(
			config,
			output_name=f"{config.output_name}-take-{take_index + 1:03d}",
			random_seed=seed,
		)

	def _options_path_for_config(self, config: ProjectConfig, take_index: int | None = None) -> Path:
		output_dir = Path(config.output_dir).expanduser()
		if take_index is not None:
			return output_dir / f"{config.output_name}-options.py"
		return output_dir / "audioguide-gui-options.py"

	def _start_next_render_job(self) -> None:
		self._active_render_job_index += 1
		if self._active_render_job_index >= len(self._render_jobs):
			self._set_running_state(False)
			self._append_log("Render finished successfully.")
			if self._last_render_output_dir:
				self.output_browser.scan(self._last_render_output_dir)
				self.take_browser.scan(self._last_render_output_dir)
				self._append_log(f"Scanned output folder: {self._last_render_output_dir}")
			return
		config, options_path = self._render_jobs[self._active_render_job_index]
		self._append_log(
			f"Starting take {self._active_render_job_index + 1}/{len(self._render_jobs)}: "
			f"{config.output_name}"
		)
		if config.random_seed is not None:
			self._append_log(f"RANDOM_SEED = {config.random_seed}")
		self._append_log(f"Generated options file: {options_path}")
		self._runner = AudioGuideRunner(options_path)
		self._runner.add_log_callback(self._signals.log_updated.emit)
		try:
			self._render_future = self._runner.start()
		except RunnerError as exc:
			self._append_log(f"Cannot start render: {exc}")
			self._set_running_state(False)
			return
		self._render_future.add_done_callback(self._signals.future_done.emit)

	def _set_running_state(self, is_running: bool) -> None:
		self.render_button.setEnabled(not is_running)
		self.cancel_button.setEnabled(is_running)
		self.target_picker.set_enabled(not is_running)
		self.corpus_picker.set_enabled(not is_running)
		self.drums_picker.set_enabled(not is_running)
		self.vocals_picker.set_enabled(not is_running)
		self.noise_picker.set_enabled(not is_running)
		self.output_picker.set_enabled(not is_running)
		self.output_name_edit.setEnabled(not is_running)
		self.output_formats_group.setEnabled(not is_running)
		self.preset_group.setEnabled(not is_running)
		self.batch_group.setEnabled(not is_running)
		self.advanced_options_edit.setReadOnly(is_running)
		self.preview_options_button.setEnabled(not is_running)
		self.save_options_button.setEnabled(not is_running)
		self.load_options_button.setEnabled(not is_running)
		self.new_project_action.setEnabled(not is_running)
		self.open_project_action.setEnabled(not is_running)
		self.save_project_action.setEnabled(not is_running)
		self.save_project_as_action.setEnabled(not is_running)

	def _update_window_title(self) -> None:
		if self._current_project_path is None:
			self.setWindowTitle("AudioGuide GUI - Untitled Project")
		else:
			self.setWindowTitle(f"AudioGuide GUI - {self._current_project_path.name}")

	@Slot(str)
	def _append_log(self, line: str) -> None:
		self.log_output.appendPlainText(line)

	@Slot(object)
	def _render_finished(self, future: Future[int]) -> None:
		try:
			exit_code = future.result()
		except Exception as exc:
			self._append_log(f"Render failed: {exc}")
			self._set_running_state(False)
			return

		if exit_code == 0:
			self._append_log("Take finished successfully.")
			self._start_next_render_job()
		elif self._cancel_requested:
			self._append_log(f"Render cancelled with exit code {exit_code}.")
			self._set_running_state(False)
		else:
			self._append_log(f"Render failed with exit code {exit_code}.")
			self._set_running_state(False)


def run() -> int:
	"""Create and run the PySide6 application."""
	app = QApplication(sys.argv)
	window = MainWindow()
	window.show()
	return app.exec()
