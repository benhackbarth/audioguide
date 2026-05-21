"""Project state and ``.agui`` persistence for the AudioGuide GUI."""

from __future__ import annotations

from dataclasses import dataclass, field
import json
from pathlib import Path
from typing import Any


PROJECT_FILE_VERSION = 1
PROJECT_FILE_EXTENSION = ".agui"
OUTPUT_FORMATS = ("csound", "json", "reaper", "aaf")


class ProjectFileError(ValueError):
	"""Raised when a project preset file cannot be read or written."""


@dataclass
class ProjectConfig:
	"""Structured project settings used to generate AudioGuide options."""

	target_path: str = ""
	corpus_paths: list[str] = field(default_factory=list)
	output_dir: str = ""
	output_name: str = "output"
	render_csound: bool = True
	output_json: bool = True
	output_reaper: bool = False
	output_aaf: bool = False
	extra_options_text: str = ""
	last_options_file_path: str = ""

	@property
	def selected_output_formats(self) -> list[str]:
		"""Return the output-format names enabled in this config."""
		formats: list[str] = []
		if self.render_csound:
			formats.append("csound")
		if self.output_json:
			formats.append("json")
		if self.output_reaper:
			formats.append("reaper")
		if self.output_aaf:
			formats.append("aaf")
		return formats


@dataclass
class AudioGuideProject:
	"""Legacy project settings collected by the first GUI version."""

	target_sound_file: str = ""
	corpus_folder: str = ""
	output_folder: str = ""

	def to_config(self) -> ProjectConfig:
		"""Return this legacy project shape as a structured project config."""
		return ProjectConfig(
			target_path=self.target_sound_file,
			corpus_paths=[self.corpus_folder] if self.corpus_folder else [],
			output_dir=self.output_folder,
		)


def load_project_file(project_path: str | Path) -> ProjectConfig:
	"""Load an ``.agui`` project preset from JSON."""
	path = Path(project_path).expanduser()
	try:
		payload = json.loads(path.read_text(encoding="utf-8"))
	except json.JSONDecodeError as exc:
		raise ProjectFileError(f"project file is not valid JSON: {path}") from exc
	except OSError as exc:
		raise ProjectFileError(f"cannot read project file: {path}") from exc
	if not isinstance(payload, dict):
		raise ProjectFileError("project file must contain a JSON object")
	return _config_from_payload(payload, path.parent)


def save_project_file(config: ProjectConfig, project_path: str | Path) -> Path:
	"""Save *config* as an ``.agui`` project preset and return its path."""
	path = _ensure_project_extension(Path(project_path).expanduser())
	payload = _payload_from_config(config, path.parent)
	try:
		path.parent.mkdir(parents=True, exist_ok=True)
		path.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
	except OSError as exc:
		raise ProjectFileError(f"cannot write project file: {path}") from exc
	return path


def _config_from_payload(payload: dict[str, Any], base_dir: Path) -> ProjectConfig:
	formats = payload.get("selected_output_formats")
	if formats is None:
		formats = _formats_from_legacy_booleans(payload)
	if not isinstance(formats, list):
		raise ProjectFileError("selected_output_formats must be a list")
	selected_formats = {str(format_name) for format_name in formats}

	corpus_paths = payload.get("corpus_paths", [])
	if not isinstance(corpus_paths, list):
		raise ProjectFileError("corpus_paths must be a list")

	return ProjectConfig(
		target_path=_path_from_project(payload.get("target_path", ""), base_dir),
		corpus_paths=[_path_from_project(path, base_dir) for path in corpus_paths if str(path)],
		output_dir=_path_from_project(payload.get("output_folder", payload.get("output_dir", "")), base_dir),
		output_name=str(payload.get("output_name", "output") or "output"),
		render_csound="csound" in selected_formats,
		output_json="json" in selected_formats,
		output_reaper="reaper" in selected_formats,
		output_aaf="aaf" in selected_formats,
		extra_options_text=str(payload.get("advanced_options_text", "")),
		last_options_file_path=_path_from_project(
			payload.get("last_generated_options_file_path", ""), base_dir
		),
	)


def _payload_from_config(config: ProjectConfig, base_dir: Path) -> dict[str, Any]:
	return {
		"version": PROJECT_FILE_VERSION,
		"target_path": _path_for_project(config.target_path, base_dir),
		"corpus_paths": [_path_for_project(path, base_dir) for path in config.corpus_paths if path],
		"output_folder": _path_for_project(config.output_dir, base_dir),
		"output_name": config.output_name,
		"selected_output_formats": config.selected_output_formats,
		"advanced_options_text": config.extra_options_text,
		"last_generated_options_file_path": _path_for_project(config.last_options_file_path, base_dir),
	}


def _formats_from_legacy_booleans(payload: dict[str, Any]) -> list[str]:
	formats: list[str] = []
	if payload.get("render_csound", True):
		formats.append("csound")
	if payload.get("output_json", True):
		formats.append("json")
	if payload.get("output_reaper", False):
		formats.append("reaper")
	if payload.get("output_aaf", False):
		formats.append("aaf")
	return formats


def _path_for_project(value: str, base_dir: Path) -> str:
	if not value:
		return ""
	path = Path(value).expanduser()
	if not path.is_absolute():
		return path.as_posix()
	try:
		return path.resolve().relative_to(base_dir.resolve()).as_posix()
	except ValueError:
		return str(path)


def _path_from_project(value: Any, base_dir: Path) -> str:
	path_text = str(value or "")
	if not path_text:
		return ""
	path = Path(path_text).expanduser()
	if path.is_absolute():
		return str(path)
	return str(base_dir / path)


def _ensure_project_extension(path: Path) -> Path:
	if path.suffix.lower() == PROJECT_FILE_EXTENSION:
		return path
	return path.with_suffix(PROJECT_FILE_EXTENSION)


__all__ = [
	"AudioGuideProject",
	"OUTPUT_FORMATS",
	"PROJECT_FILE_EXTENSION",
	"PROJECT_FILE_VERSION",
	"ProjectConfig",
	"ProjectFileError",
	"load_project_file",
	"save_project_file",
]
