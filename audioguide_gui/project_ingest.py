"""Project ingest helpers for TRANSMISSIONS sessions."""

from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
import json
import re
import shutil

from .project import ProjectConfig, save_project_file


INGEST_MANIFEST_FILENAME = "transmissions-project-ingest.json"
INGEST_README_FILENAME = "README-PREP.txt"
AUDIO_EXTENSIONS = {".aif", ".aifc", ".aiff", ".flac", ".m4a", ".mp3", ".wav", ".wave"}
DEFAULT_ROLE_ORDER = ("main", "drums", "vocals", "bass", "texture", "noise")


@dataclass(frozen=True)
class CorpusSource:
	"""A source path to ingest for one corpus role."""

	role: str
	path: str


@dataclass(frozen=True)
class ProjectIngestRequest:
	"""User choices for creating a TRANSMISSIONS project folder."""

	project_dir: str
	project_name: str
	target_path: str
	corpus_sources: tuple[CorpusSource, ...] = ()
	copy_files: bool = True
	preset_name: str = "dusty_drum_chop"
	take_count: int = 8
	output_name: str = ""


@dataclass(frozen=True)
class ProjectIngestResult:
	"""Result of a TRANSMISSIONS project ingest."""

	project_dir: Path
	config: ProjectConfig
	project_file: Path
	manifest_path: Path
	readme_path: Path
	copied_files: tuple[Path, ...] = ()
	warnings: tuple[str, ...] = ()


def create_transmissions_project(request: ProjectIngestRequest) -> ProjectIngestResult:
	"""Create a clean project folder and return the GUI config for it."""
	project_dir = Path(request.project_dir).expanduser()
	if not str(project_dir):
		raise ValueError("project folder is required")
	project_name = request.project_name.strip() or project_dir.name or "TRANSMISSIONS Project"
	output_name = request.output_name.strip() or _slug(project_name)
	project_dir.mkdir(parents=True, exist_ok=True)

	target_source = Path(request.target_path).expanduser()
	if not target_source.exists() or not target_source.is_file():
		raise ValueError(f'target sound file does not exist: "{target_source}"')
	if target_source.suffix.lower() not in AUDIO_EXTENSIONS:
		raise ValueError(f'target sound file should be WAV, AIFF, FLAC, MP3, or M4A: "{target_source}"')

	corpus_sources = _normalized_sources(request.corpus_sources)
	if not corpus_sources:
		raise ValueError("choose at least one corpus file or folder")

	target_path = _copy_target(target_source, project_dir) if request.copy_files else target_source
	corpus_paths: list[str] = []
	corpus_groups: dict[str, list[str]] = {}
	copied_files: list[Path] = [target_path] if request.copy_files else []
	source_manifest: list[dict[str, object]] = []
	warnings: list[str] = []

	for source in corpus_sources:
		source_path = Path(source.path).expanduser()
		if not source_path.exists():
			warnings.append(f'{source.role}: source does not exist: "{source_path}"')
			continue
		audio_files = collect_audio_files(source_path)
		if not audio_files:
			warnings.append(f'{source.role}: no supported audio files found in "{source_path}"')
			continue
		if request.copy_files:
			role_dir = project_dir / "source" / "corpus" / source.role
			role_files = _copy_corpus_files(audio_files, source_path, role_dir)
			copied_files.extend(role_files)
			config_path = str(role_dir)
		else:
			config_path = str(source_path)
			role_files = audio_files
		if source.role == "main":
			corpus_paths.append(config_path)
		else:
			corpus_groups[source.role] = [config_path]
		source_manifest.append(
			{
				"role": source.role,
				"source": str(source_path),
				"audio_file_count": len(audio_files),
				"project_path": config_path,
				"files": [str(path) for path in role_files],
			}
		)

	output_dir = project_dir / "renders"
	output_dir.mkdir(parents=True, exist_ok=True)
	config = ProjectConfig(
		target_path=str(target_path),
		corpus_paths=corpus_paths,
		output_dir=str(output_dir),
		output_name=output_name,
		render_csound=True,
		output_json=True,
		output_reaper=True,
		output_aaf=False,
		preset_name=request.preset_name,
		take_count=max(1, request.take_count),
		corpus_groups=corpus_groups,
	)
	project_file = save_project_file(config, project_dir / f"{output_name}.agui")
	manifest_path = _write_ingest_manifest(
		project_dir,
		project_name,
		request,
		config,
		source_manifest,
		warnings,
	)
	readme_path = _write_ingest_readme(project_dir, project_name, config)
	return ProjectIngestResult(
		project_dir=project_dir,
		config=config,
		project_file=project_file,
		manifest_path=manifest_path,
		readme_path=readme_path,
		copied_files=tuple(copied_files),
		warnings=tuple(warnings),
	)


def collect_audio_files(path: str | Path) -> list[Path]:
	"""Return supported audio files from a file or recursively from a folder."""
	source = Path(path).expanduser()
	if source.is_file():
		return [source] if source.suffix.lower() in AUDIO_EXTENSIONS else []
	if not source.is_dir():
		return []
	return sorted(
		child
		for child in source.rglob("*")
		if child.is_file() and child.suffix.lower() in AUDIO_EXTENSIONS and not _is_hidden_path(child, source)
	)


def _normalized_sources(sources: tuple[CorpusSource, ...]) -> list[CorpusSource]:
	normalized: list[CorpusSource] = []
	seen: set[tuple[str, str]] = set()
	for source in sources:
		role = _slug(source.role or "main")
		if role == "vocal":
			role = "vocals"
		path = source.path.strip()
		if not path:
			continue
		key = (role, path)
		if key in seen:
			continue
		seen.add(key)
		normalized.append(CorpusSource(role=role, path=path))
	return normalized


def _copy_target(source: Path, project_dir: Path) -> Path:
	target_dir = project_dir / "source" / "target"
	target_dir.mkdir(parents=True, exist_ok=True)
	destination = _unique_destination(target_dir, source.name)
	shutil.copy2(source, destination)
	return destination


def _copy_corpus_files(files: list[Path], source_root: Path, role_dir: Path) -> list[Path]:
	role_dir.mkdir(parents=True, exist_ok=True)
	copied: list[Path] = []
	for source in files:
		if source_root.is_dir():
			relative = source.relative_to(source_root)
			destination = role_dir / relative
			destination.parent.mkdir(parents=True, exist_ok=True)
			if destination.exists():
				destination = _unique_destination(destination.parent, destination.name)
		else:
			destination = _unique_destination(role_dir, source.name)
		shutil.copy2(source, destination)
		copied.append(destination)
	return copied


def _write_ingest_manifest(
	project_dir: Path,
	project_name: str,
	request: ProjectIngestRequest,
	config: ProjectConfig,
	source_manifest: list[dict[str, object]],
	warnings: list[str],
) -> Path:
	path = project_dir / INGEST_MANIFEST_FILENAME
	payload = {
		"project": "TRANSMISSIONS",
		"project_name": project_name,
		"copy_files": request.copy_files,
		"target_path": config.target_path,
		"output_dir": config.output_dir,
		"output_name": config.output_name,
		"preset_name": config.preset_name,
		"take_count": config.take_count,
		"corpus_sources": source_manifest,
		"warnings": warnings,
	}
	path.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
	return path


def _write_ingest_readme(project_dir: Path, project_name: str, config: ProjectConfig) -> Path:
	path = project_dir / INGEST_README_FILENAME
	path.write_text(
		f"{project_name}\n"
		"\n"
		"TRANSMISSIONS project folder\n"
		"\n"
		"Start here:\n"
		f"1. Open {Path(config.output_name).with_suffix('.agui').name} in the AudioGuide GUI.\n"
		"2. Check the Render tab paths and preset.\n"
		"3. Preview the generated options if you want to inspect AudioGuide syntax.\n"
		"4. Click Render, then use Takes to rate, tag, export keepers, and export DAW folders.\n"
		"\n"
		"Prep notes:\n"
		"- AudioGuide analyzes and segments files during render, so manual prep is usually optional.\n"
		"- Use Tools > Segment when you want to inspect segmentation before rendering.\n"
		"- Use Tools > Descriptors when you want to inspect analysis data.\n"
		"- Use Tools > Granulate to create extra corpus material.\n",
		encoding="utf-8",
	)
	return path


def _unique_destination(directory: Path, filename: str) -> Path:
	path = directory / filename
	if not path.exists():
		return path
	stem = path.stem
	suffix = path.suffix
	index = 2
	while True:
		candidate = directory / f"{stem}-{index}{suffix}"
		if not candidate.exists():
			return candidate
		index += 1


def _is_hidden_path(path: Path, root: Path) -> bool:
	try:
		relative_parts = path.relative_to(root).parts
	except ValueError:
		relative_parts = path.parts
	return any(part.startswith(".") for part in relative_parts)


def _slug(value: str) -> str:
	slug = re.sub(r"[^A-Za-z0-9]+", "-", value.strip().lower()).strip("-")
	return slug or "transmissions-project"


__all__ = [
	"AUDIO_EXTENSIONS",
	"DEFAULT_ROLE_ORDER",
	"INGEST_MANIFEST_FILENAME",
	"INGEST_README_FILENAME",
	"CorpusSource",
	"ProjectIngestRequest",
	"ProjectIngestResult",
	"collect_audio_files",
	"create_transmissions_project",
]
