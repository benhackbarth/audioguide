"""Render manifest helpers for TRANSMISSIONS batch runs."""

from __future__ import annotations

from pathlib import Path
import json

from .project import ProjectConfig


def write_render_manifest(jobs: list[tuple[ProjectConfig, Path]], destination: str | Path | None = None) -> Path:
	"""Write a JSON manifest describing generated take option files."""
	if not jobs:
		raise ValueError("cannot write a render manifest without jobs")
	if destination is None:
		output_dir = Path(jobs[0][0].output_dir).expanduser()
		destination_path = output_dir / "transmissions-render-manifest.json"
	else:
		destination_path = Path(destination).expanduser()

	payload = {
		"project": "TRANSMISSIONS",
		"take_count": len(jobs),
		"preset": jobs[0][0].preset_name,
		"preset_parameters": jobs[0][0].preset_parameters,
		"target_path": jobs[0][0].target_path,
		"corpus_paths": jobs[0][0].corpus_paths,
		"corpus_groups": jobs[0][0].corpus_groups,
		"output_dir": jobs[0][0].output_dir,
		"takes": [
			{
				"take": index + 1,
				"output_name": config.output_name,
				"random_seed": config.random_seed,
				"options_file": str(options_path),
				"selected_output_formats": config.selected_output_formats,
			}
			for index, (config, options_path) in enumerate(jobs)
		],
	}
	destination_path.parent.mkdir(parents=True, exist_ok=True)
	destination_path.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
	return destination_path


__all__ = ["write_render_manifest"]
