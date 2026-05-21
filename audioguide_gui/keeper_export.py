"""Keeper pack and REAPER assembly exports for TRANSMISSIONS takes."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any
import csv
import json
import shutil
import wave

from .take_manifest import TakeEntry, load_take_entries

try:
	import aifc
except ImportError:  # pragma: no cover - Python 3.13+ removed aifc.
	aifc = None


KEEPERS_MANIFEST_FILENAME = "keepers-manifest.json"
DEFAULT_ASSEMBLY_FILENAME = "transmissions-assembly.rpp"
DEFAULT_ABLETON_PROJECT_DIRNAME = "TRANSMISSIONS Ableton Project"
ABLETON_IMPORT_GUIDE_JSON = "ableton-import-guide.json"
ABLETON_IMPORT_GUIDE_CSV = "ableton-import-guide.csv"
DEFAULT_ASSEMBLY_GAP_SECONDS = 0.25
DEFAULT_ITEM_LENGTH_SECONDS = 4.0


@dataclass(frozen=True)
class KeeperExportResult:
	"""Result summary for a keeper export."""

	destination: Path
	manifest_path: Path
	exported_count: int
	warnings: tuple[str, ...] = ()


def export_keepers(
	manifest_path: str | Path,
	destination: str | Path | None = None,
	*,
	min_rating: int = 4,
	keepers: bool = True,
	rated: bool = True,
) -> KeeperExportResult:
	"""Copy selected take files into a keeper pack and write a manifest."""
	source_manifest = Path(manifest_path).expanduser()
	source_payload = _load_manifest_payload(source_manifest)
	entries = load_take_entries(source_manifest)
	selected = [
		entry
		for entry in entries
		if (keepers and entry.keeper) or (rated and entry.rating >= min_rating)
	]
	export_dir = Path(destination).expanduser() if destination else source_manifest.parent / "keepers"
	export_dir.mkdir(parents=True, exist_ok=True)

	warnings: list[str] = []
	exported_takes: list[dict[str, Any]] = []
	for entry in selected:
		files, file_warnings = _copy_take_files(entry, export_dir)
		warnings.extend(file_warnings)
		exported_takes.append(
			{
				"take": entry.take,
				"output_name": entry.output_name,
				"random_seed": entry.random_seed,
				"rating": entry.rating,
				"keeper": entry.keeper,
				"notes": entry.notes,
				"tags": list(entry.tags),
				"files": files,
			}
		)

	keeper_manifest = export_dir / KEEPERS_MANIFEST_FILENAME
	payload = {
		"project": "TRANSMISSIONS",
		"source_manifest": str(source_manifest),
		"preset": source_payload.get("preset", ""),
		"preset_parameters": source_payload.get("preset_parameters", {}),
		"selection": {
			"keepers": keepers,
			"rated": rated,
			"min_rating": min_rating,
		},
		"exported_count": len(exported_takes),
		"takes": exported_takes,
		"warnings": warnings,
	}
	keeper_manifest.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
	return KeeperExportResult(
		destination=export_dir,
		manifest_path=keeper_manifest,
		exported_count=len(exported_takes),
		warnings=tuple(warnings),
	)


def export_reaper_assembly(
	keepers_manifest_path: str | Path,
	destination: str | Path | None = None,
	*,
	gap_seconds: float = DEFAULT_ASSEMBLY_GAP_SECONDS,
) -> Path:
	"""Create a combined REAPER session from a keeper manifest."""
	manifest_path = Path(keepers_manifest_path).expanduser()
	payload = json.loads(manifest_path.read_text(encoding="utf-8"))
	takes = payload.get("takes", [])
	if not isinstance(takes, list):
		takes = []
	assembly_path = Path(destination).expanduser() if destination else manifest_path.with_name(DEFAULT_ASSEMBLY_FILENAME)
	assembly_path.parent.mkdir(parents=True, exist_ok=True)

	tracks: dict[str, list[str]] = {}
	positions: dict[str, float] = {}
	for take in takes:
		if not isinstance(take, dict):
			continue
		audio_path = _audio_path_from_exported_take(take, manifest_path.parent)
		if audio_path is None:
			continue
		tags = [str(tag) for tag in take.get("tags", []) if str(tag)]
		track_name = tags[0] if tags else "TRANSMISSIONS Takes"
		position = positions.get(track_name, 0.0)
		length = _audio_duration_seconds(audio_path) or DEFAULT_ITEM_LENGTH_SECONDS
		item_name = _rpp_quote(
			f"take {int(take.get('take') or 0):03d} r{int(take.get('rating') or 0)} {take.get('output_name', '')}".strip()
		)
		item = (
			"    <ITEM\n"
			f"      POSITION {position:.6f}\n"
			f"      NAME {item_name}\n"
			f"      LENGTH {length:.6f}\n"
			"      SOFFS 0.000000\n"
			"      VOLPAN 1.000000 0.0 1.0 -1.0\n"
			"      FADEIN 1 0.005000 0.0\n"
			"      FADEOUT 1 0.005000 0.0\n"
			"      PLAYRATE 1.000000 1 0.000000 -1\n"
			"      <SOURCE WAVE\n"
			f"        FILE {_rpp_quote(str(audio_path))}\n"
			"      >\n"
			"    >\n"
		)
		tracks.setdefault(track_name, []).append(item)
		positions[track_name] = position + length + max(0.0, gap_seconds)

	track_chunks = []
	for track_name in sorted(tracks):
		track_chunks.append(
			"  <TRACK\n"
			f"    NAME {_rpp_quote(track_name)}\n"
			+ "".join(tracks[track_name])
			+ "  >\n"
		)
	assembly_path.write_text(
		'<REAPER_PROJECT 0.1 "6.11/x64" 1591355987\n' + "".join(track_chunks) + ">\n",
		encoding="utf-8",
	)
	return assembly_path


def export_ableton_project(
	keepers_manifest_path: str | Path,
	destination: str | Path | None = None,
	*,
	gap_seconds: float = DEFAULT_ASSEMBLY_GAP_SECONDS,
) -> Path:
	"""Create an Ableton-friendly project folder from a keeper manifest."""
	manifest_path = Path(keepers_manifest_path).expanduser()
	payload = json.loads(manifest_path.read_text(encoding="utf-8"))
	takes = payload.get("takes", [])
	if not isinstance(takes, list):
		takes = []
	project_dir = Path(destination).expanduser() if destination else manifest_path.with_name(DEFAULT_ABLETON_PROJECT_DIRNAME)
	imported_dir = project_dir / "Samples" / "Imported"
	imported_dir.mkdir(parents=True, exist_ok=True)

	rows: list[dict[str, Any]] = []
	positions: dict[str, float] = {}
	for take in takes:
		if not isinstance(take, dict):
			continue
		audio_path = _audio_path_from_exported_take(take, manifest_path.parent)
		if audio_path is None:
			continue
		tags = [str(tag) for tag in take.get("tags", []) if str(tag)]
		track_name = tags[0] if tags else "TRANSMISSIONS Takes"
		position = positions.get(track_name, 0.0)
		length = _audio_duration_seconds(audio_path) or DEFAULT_ITEM_LENGTH_SECONDS
		destination_audio = _unique_destination(imported_dir, audio_path.name)
		shutil.copy2(audio_path, destination_audio)
		row = {
			"take": int(take.get("take") or 0),
			"output_name": str(take.get("output_name") or ""),
			"track": track_name,
			"start_seconds": round(position, 6),
			"duration_seconds": round(length, 6),
			"rating": int(take.get("rating") or 0),
			"keeper": bool(take.get("keeper", False)),
			"tags": tags,
			"notes": str(take.get("notes") or ""),
			"audio_file": str(destination_audio),
			"audio_file_relative": str(destination_audio.relative_to(project_dir)),
		}
		rows.append(row)
		positions[track_name] = position + length + max(0.0, gap_seconds)

	guide_payload = {
		"project": "TRANSMISSIONS",
		"format": "ableton-import-guide",
		"source_keepers_manifest": str(manifest_path),
		"notes": (
			"This is an Ableton-friendly collected project folder, not a native .als/.alp file. "
			"Drag the files from Samples/Imported into Ableton Live and use the guide rows for track names, order, and start times."
		),
		"takes": rows,
	}
	(project_dir / ABLETON_IMPORT_GUIDE_JSON).write_text(json.dumps(guide_payload, indent=2) + "\n", encoding="utf-8")
	_write_ableton_csv(project_dir / ABLETON_IMPORT_GUIDE_CSV, rows)
	_write_ableton_readme(project_dir)
	return project_dir


def _copy_take_files(entry: TakeEntry, export_dir: Path) -> tuple[dict[str, str], list[str]]:
	candidates = {
		"audio_file": entry.audio_file,
		"json_file": entry.json_file,
		"rpp_file": entry.rpp_file,
		"aaf_file": entry.aaf_file,
		"options_file": entry.options_file,
		"html_log_file": entry.html_log_file,
		"target_labels_file": entry.target_labels_file,
		"output_labels_file": entry.output_labels_file,
	}
	files: dict[str, str] = {}
	warnings: list[str] = []
	for key, source in candidates.items():
		if source is None:
			continue
		if not source.exists():
			warnings.append(f"{entry.output_name}: missing {key}: {source}")
			continue
		destination = _unique_destination(export_dir, source.name)
		shutil.copy2(source, destination)
		files[key] = str(destination)
	if "audio_file" not in files:
		warnings.append(f"{entry.output_name}: no audio file exported")
	return files, warnings


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


def _load_manifest_payload(path: Path) -> dict[str, Any]:
	try:
		payload = json.loads(path.read_text(encoding="utf-8"))
	except json.JSONDecodeError:
		return {}
	return payload if isinstance(payload, dict) else {}


def _audio_path_from_exported_take(take: dict[str, Any], base_dir: Path) -> Path | None:
	files = take.get("files", {})
	if not isinstance(files, dict):
		return None
	audio = files.get("audio_file")
	if not audio:
		return None
	path = Path(str(audio)).expanduser()
	if not path.is_absolute():
		path = base_dir / path
	return path if path.exists() else None


def _audio_duration_seconds(path: Path) -> float | None:
	try:
		if path.suffix.lower() in {".wav", ".wave"}:
			with wave.open(str(path), "rb") as audio:
				rate = audio.getframerate()
				return audio.getnframes() / rate if rate else None
		if aifc is not None and path.suffix.lower() in {".aif", ".aiff", ".aifc"}:
			with aifc.open(str(path), "rb") as audio:
				rate = audio.getframerate()
				return audio.getnframes() / rate if rate else None
	except (EOFError, OSError, wave.Error):
		return None
	except Exception as exc:
		if aifc is not None and isinstance(exc, aifc.Error):
			return None
		raise
	return None


def _rpp_quote(value: str) -> str:
	return '"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"'


def _write_ableton_csv(path: Path, rows: list[dict[str, Any]]) -> None:
	fieldnames = [
		"take",
		"output_name",
		"track",
		"start_seconds",
		"duration_seconds",
		"rating",
		"keeper",
		"tags",
		"notes",
		"audio_file_relative",
	]
	with path.open("w", encoding="utf-8", newline="") as file:
		writer = csv.DictWriter(file, fieldnames=fieldnames)
		writer.writeheader()
		for row in rows:
			writer.writerow(
				{
					field: (" ".join(row.get("tags", [])) if field == "tags" else row.get(field, ""))
					for field in fieldnames
				}
			)


def _write_ableton_readme(project_dir: Path) -> None:
	(project_dir / "README-Ableton.txt").write_text(
		"TRANSMISSIONS Ableton Import\n"
		"\n"
		"This folder is ready to drag into Ableton Live, but it is not a native .als/.alp file.\n"
		"Audio files are collected in Samples/Imported.\n"
		"Use ableton-import-guide.csv or ableton-import-guide.json for suggested track names,\n"
		"start times, ratings, tags, and notes.\n"
		"\n"
		"Suggested workflow:\n"
		"1. Open Ableton Live and create a new set.\n"
		"2. Create tracks matching the guide's track column.\n"
		"3. Drag samples from Samples/Imported onto the matching tracks.\n"
		"4. Place clips at the guide's start_seconds values if you want the generated order.\n",
		encoding="utf-8",
	)


__all__ = [
	"DEFAULT_ASSEMBLY_FILENAME",
	"DEFAULT_ABLETON_PROJECT_DIRNAME",
	"KEEPERS_MANIFEST_FILENAME",
	"KeeperExportResult",
	"export_ableton_project",
	"export_keepers",
	"export_reaper_assembly",
]
