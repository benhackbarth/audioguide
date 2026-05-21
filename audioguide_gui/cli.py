"""Command-line config runner for AudioGuide GUI projects."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any

from .option_builder import OptionBuilderError, build_options_file, build_options_text
from .project import PROJECT_FILE_EXTENSION, ProjectConfig, ProjectFileError, load_project_file
from .runner import AudioGuideRunner, RunnerError


class ConfigFileError(ValueError):
	"""Raised when a JSON/YAML command-line config cannot be loaded."""


def main(argv: list[str] | None = None) -> int:
	"""Generate an options file from JSON/YAML and optionally render it."""
	parser = argparse.ArgumentParser(
		prog="audioguide-gui-render",
		description="Generate and optionally render an AudioGuide options file from a JSON/YAML config.",
	)
	parser.add_argument("config", help="Path to a .json, .yaml/.yml, or .agui project config")
	parser.add_argument(
		"-o",
		"--options-file",
		help="Where to write the generated AudioGuide options .py file "
		"(default: <output_dir>/audioguide-cli-options.py)",
	)
	parser.add_argument("--render", action="store_true", help="Run agConcatenate.py after writing the options file")
	parser.add_argument("--print-options", action="store_true", help="Print generated options text to stdout")
	parser.add_argument(
		"--ag-concatenate",
		help="Path to agConcatenate.py when rendering outside the repository layout",
	)
	args = parser.parse_args(argv)

	try:
		config = load_cli_config(args.config)
		options_path = Path(args.options_file).expanduser() if args.options_file else _default_options_path(config)
		written_path = build_options_file(config, options_path)
	except (ConfigFileError, OptionBuilderError, ProjectFileError, OSError) as exc:
		parser.error(str(exc))
		return 2

	if args.print_options:
		print(build_options_text(config), end="")
	else:
		print(f"Wrote options file: {written_path}")

	if not args.render:
		return 0

	try:
		runner = AudioGuideRunner(
			written_path,
			ag_concatenate_path=args.ag_concatenate,
		)
		runner.add_log_callback(print)
		return runner.start().result()
	except (RunnerError, OSError) as exc:
		print(f"Render failed: {exc}")
		return 1


def load_cli_config(config_path: str | Path) -> ProjectConfig:
	"""Load a JSON, YAML, or .agui project config into ``ProjectConfig``."""
	path = Path(config_path).expanduser()
	if path.suffix.lower() == PROJECT_FILE_EXTENSION:
		return load_project_file(path)

	payload = _load_mapping(path)
	return _config_from_mapping(payload, path.parent)


def _load_mapping(path: Path) -> dict[str, Any]:
	try:
		text = path.read_text(encoding="utf-8")
	except OSError as exc:
		raise ConfigFileError(f"cannot read config file: {path}") from exc

	suffix = path.suffix.lower()
	if suffix == ".json":
		try:
			payload = json.loads(text)
		except json.JSONDecodeError as exc:
			raise ConfigFileError(f"config file is not valid JSON: {path}") from exc
	elif suffix in {".yaml", ".yml"}:
		payload = _load_yaml(text, path)
	else:
		raise ConfigFileError("config file must end in .json, .yaml, .yml, or .agui")

	if not isinstance(payload, dict):
		raise ConfigFileError("config file must contain an object at the top level")
	return payload


def _load_yaml(text: str, path: Path) -> Any:
	try:
		import yaml  # type: ignore[import-not-found]
	except ImportError as exc:
		raise ConfigFileError(
			"YAML configs require PyYAML. Install it with: python -m pip install PyYAML"
		) from exc
	try:
		return yaml.safe_load(text)
	except Exception as exc:
		raise ConfigFileError(f"config file is not valid YAML: {path}") from exc


def _config_from_mapping(payload: dict[str, Any], base_dir: Path) -> ProjectConfig:
	formats = payload.get("selected_output_formats", payload.get("output_formats"))
	formats_provided = formats is not None
	if formats is None:
		formats = []
	if not isinstance(formats, list):
		raise ConfigFileError("selected_output_formats/output_formats must be a list")
	selected_formats = {str(format_name) for format_name in formats}

	corpus_paths = payload.get("corpus_paths", payload.get("corpus", []))
	if isinstance(corpus_paths, str):
		corpus_paths = [corpus_paths]
	if not isinstance(corpus_paths, list):
		raise ConfigFileError("corpus_paths/corpus must be a list or string")

	return ProjectConfig(
		target_path=_path_from_config(payload.get("target_path", payload.get("target", "")), base_dir),
		corpus_paths=[_path_from_config(path, base_dir) for path in corpus_paths if str(path)],
		output_dir=_path_from_config(payload.get("output_dir", payload.get("output_folder", "")), base_dir),
		output_name=str(payload.get("output_name", "output") or "output"),
		render_csound=_format_enabled(payload, selected_formats, formats_provided, "render_csound", "csound", True),
		output_json=_format_enabled(payload, selected_formats, formats_provided, "output_json", "json", True),
		output_reaper=_format_enabled(payload, selected_formats, formats_provided, "output_reaper", "reaper", False),
		output_aaf=_format_enabled(payload, selected_formats, formats_provided, "output_aaf", "aaf", False),
		extra_options_text=str(payload.get("extra_options_text", payload.get("advanced_options_text", ""))),
		last_options_file_path=_path_from_config(
			payload.get("last_options_file_path", payload.get("last_generated_options_file_path", "")),
			base_dir,
		),
	)


def _format_enabled(
	payload: dict[str, Any],
	selected_formats: set[str],
	formats_provided: bool,
	boolean_key: str,
	format_name: str,
	default: bool,
) -> bool:
	if formats_provided:
		return format_name in selected_formats
	return bool(payload.get(boolean_key, default))


def _path_from_config(value: Any, base_dir: Path) -> str:
	path_text = str(value or "")
	if not path_text:
		return ""
	path = Path(path_text).expanduser()
	if path.is_absolute():
		return str(path)
	return str(base_dir / path)


def _default_options_path(config: ProjectConfig) -> Path:
	if not config.output_dir:
		raise ConfigFileError("output_dir/output_folder is required when --options-file is omitted")
	return Path(config.output_dir).expanduser() / "audioguide-cli-options.py"


if __name__ == "__main__":
	raise SystemExit(main())
