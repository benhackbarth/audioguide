"""Load and annotate TRANSMISSIONS render take manifests."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any
import json


MANIFEST_FILENAME = "transmissions-render-manifest.json"
ANNOTATIONS_FILENAME = "transmissions-take-notes.json"
AUDIO_SUFFIXES = (".aiff", ".aif", ".wav", ".flac", ".mp3", ".m4a")


@dataclass(frozen=True)
class TakeEntry:
	"""One rendered take described by a TRANSMISSIONS manifest."""

	take: int
	output_name: str
	random_seed: int | None
	options_file: Path
	audio_file: Path | None
	json_file: Path | None
	rpp_file: Path | None
	rating: int = 0
	keeper: bool = False
	notes: str = ""


def load_take_entries(manifest_path: str | Path) -> list[TakeEntry]:
	"""Load take entries and merge any saved ratings/notes sidecar."""
	path = Path(manifest_path).expanduser()
	payload = json.loads(path.read_text(encoding="utf-8"))
	output_dir = Path(payload.get("output_dir") or path.parent).expanduser()
	if not output_dir.is_absolute():
		output_dir = (path.parent / output_dir).resolve()
	annotations = load_take_annotations(path)

	entries: list[TakeEntry] = []
	for take_payload in payload.get("takes", []):
		output_name = str(take_payload.get("output_name") or "")
		take_number = int(take_payload.get("take") or len(entries) + 1)
		note_payload = annotations.get(output_name, {})
		entries.append(
			TakeEntry(
				take=take_number,
				output_name=output_name,
				random_seed=take_payload.get("random_seed"),
				options_file=Path(str(take_payload.get("options_file") or "")).expanduser(),
				audio_file=_first_existing(output_dir, output_name, AUDIO_SUFFIXES),
				json_file=_existing(output_dir / f"{output_name}.json"),
				rpp_file=_existing(output_dir / f"{output_name}.rpp"),
				rating=int(note_payload.get("rating", 0) or 0),
				keeper=bool(note_payload.get("keeper", False)),
				notes=str(note_payload.get("notes", "")),
			)
		)
	return entries


def load_take_annotations(manifest_path: str | Path) -> dict[str, dict[str, Any]]:
	"""Load saved annotations for the manifest folder."""
	path = annotations_path_for_manifest(manifest_path)
	if not path.exists():
		return {}
	payload = json.loads(path.read_text(encoding="utf-8"))
	if not isinstance(payload, dict):
		return {}
	annotations = payload.get("takes", {})
	return annotations if isinstance(annotations, dict) else {}


def save_take_annotation(
	manifest_path: str | Path,
	output_name: str,
	*,
	rating: int,
	keeper: bool,
	notes: str,
) -> Path:
	"""Persist rating, keeper, and notes for one take."""
	path = annotations_path_for_manifest(manifest_path)
	annotations = load_take_annotations(manifest_path)
	annotations[output_name] = {
		"rating": max(0, min(5, int(rating))),
		"keeper": bool(keeper),
		"notes": notes,
	}
	path.write_text(json.dumps({"takes": annotations}, indent=2) + "\n", encoding="utf-8")
	return path


def annotations_path_for_manifest(manifest_path: str | Path) -> Path:
	"""Return the notes sidecar path for a manifest."""
	return Path(manifest_path).expanduser().with_name(ANNOTATIONS_FILENAME)


def default_manifest_path(output_dir: str | Path) -> Path:
	"""Return the default manifest path in an output directory."""
	return Path(output_dir).expanduser() / MANIFEST_FILENAME


def _first_existing(output_dir: Path, output_name: str, suffixes: tuple[str, ...]) -> Path | None:
	for suffix in suffixes:
		path = output_dir / f"{output_name}{suffix}"
		if path.exists():
			return path
	return None


def _existing(path: Path) -> Path | None:
	return path if path.exists() else None


__all__ = [
	"ANNOTATIONS_FILENAME",
	"MANIFEST_FILENAME",
	"TakeEntry",
	"annotations_path_for_manifest",
	"default_manifest_path",
	"load_take_annotations",
	"load_take_entries",
	"save_take_annotation",
]
