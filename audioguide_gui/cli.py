"""Command-line config runner for AudioGuide GUI projects."""

from __future__ import annotations

import argparse
from dataclasses import replace
import json
from pathlib import Path
from typing import Any

from .option_builder import OptionBuilderError, build_options_file, build_options_text
from .presets import PresetError, get_preset
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
		jobs = _build_jobs(config, args.options_file)
	except (ConfigFileError, OptionBuilderError, PresetError, ProjectFileError, OSError) as exc:
		parser.error(str(exc))
		return 2

	if args.print_options:
		for index, (job_config, _) in enumerate(jobs):
			if len(jobs) > 1:
				print(f"# ===== Take {index + 1}: {job_config.output_name} =====")
			print(build_options_text(job_config), end="")
	else:
		for _, options_path in jobs:
			print(f"Wrote options file: {options_path}")

	if not args.render:
		return 0

	for job_config, options_path in jobs:
		try:
			print(f"Rendering {job_config.output_name}")
			runner = AudioGuideRunner(
				options_path,
				ag_concatenate_path=args.ag_concatenate,
			)
			runner.add_log_callback(print)
			exit_code = runner.start().result()
		except (RunnerError, OSError) as exc:
			print(f"Render failed: {exc}")
			return 1
		if exit_code != 0:
			return exit_code
	return 0


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

	config = ProjectConfig(
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
		preset_name=str(payload.get("preset", payload.get("preset_name", ""))),
		random_seed=_optional_int(payload.get("random_seed")),
		take_count=max(1, int(payload.get("take_count", 1) or 1)),
	)
	if config.preset_name:
		_apply_preset(config, config.preset_name, formats_provided)
	return config


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


def _optional_int(value: Any) -> int | None:
	if value in (None, ""):
		return None
	return int(value)


def _apply_preset(config: ProjectConfig, preset_name: str, keep_explicit_formats: bool) -> None:
	preset = get_preset(preset_name)
	if not keep_explicit_formats:
		config.render_csound = "csound" in preset.output_formats
		config.output_json = "json" in preset.output_formats
		config.output_reaper = "reaper" in preset.output_formats
		config.output_aaf = "aaf" in preset.output_formats
	config.extra_options_text = _join_options(preset.options_text, config.extra_options_text)


def _join_options(*blocks: str) -> str:
	return "\n\n".join(block.strip() for block in blocks if block.strip()) + "\n"


def _default_options_path(config: ProjectConfig) -> Path:
	if not config.output_dir:
		raise ConfigFileError("output_dir/output_folder is required when --options-file is omitted")
	return Path(config.output_dir).expanduser() / "audioguide-cli-options.py"


def _build_jobs(config: ProjectConfig, options_file: str | None) -> list[tuple[ProjectConfig, Path]]:
	jobs: list[tuple[ProjectConfig, Path]] = []
	take_count = max(1, config.take_count)
	for take_index in range(take_count):
		job_config = _config_for_take(config, take_index)
		if options_file:
			options_path = _options_path_for_take(Path(options_file).expanduser(), take_index if take_count > 1 else None)
		elif take_count > 1:
			options_path = Path(job_config.output_dir).expanduser() / f"{job_config.output_name}-options.py"
		else:
			options_path = _default_options_path(job_config)
		build_options_file(job_config, options_path)
		jobs.append((job_config, options_path))
	return jobs


def _config_for_take(config: ProjectConfig, take_index: int) -> ProjectConfig:
	if config.take_count <= 1:
		return config
	seed = None if config.random_seed is None else config.random_seed + take_index
	return replace(
		config,
		output_name=f"{config.output_name}-take-{take_index + 1:03d}",
		random_seed=seed,
	)


def _options_path_for_take(path: Path, take_index: int | None) -> Path:
	if take_index is None:
		return path
	return path.with_name(f"{path.stem}-take-{take_index + 1:03d}{path.suffix}")


if __name__ == "__main__":
	raise SystemExit(main())
