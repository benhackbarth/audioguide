"""Creative option presets for AudioGuide GUI sessions."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any

from .runner import bundled_resource_path


class PresetError(ValueError):
	"""Raised when a preset cannot be loaded or applied."""


@dataclass(frozen=True)
class CreativePreset:
	"""A named block of AudioGuide options plus default output choices."""

	name: str
	label: str
	description: str
	output_formats: tuple[str, ...]
	options_text: str


BEAT_CHOP_OPTIONS = """# TRANSMISSIONS: tight rhythmic replacement.
# The first pass keeps durations and power close enough to preserve beat logic.
# The percent passes leave room for random variation when RANDOM_SEED changes.
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=18),
	spass('closest_percent', d('centroid-seg', norm=1), percent=30),
	spass('closest', d('mfccs-seg')),
]

SUPERIMPOSE = si(maxSegment=1, peakAlign=True, searchOrder='power')
ROTATE_VOICES = False
OUTPUT_GAIN_DB = -3
"""


VOCAL_TRANSMISSION_OPTIONS = """# TRANSMISSIONS: vocal/radio cut-up.
# Looser candidate pools create broken phrase memory instead of literal matching.
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), percent=35),
	spass('parser', 'noisiness-seg >= 50%', 'closest_percent', [d('mfccs-seg')], [d('f0-seg')], percent=25),
	spass('closest_percent', d('centroid-seg', norm=1), percent=20),
]

SUPERIMPOSE = si(maxSegment=2, maxOverlap=3, peakAlign=True, searchOrder='power')
ROTATE_VOICES = True
OUTPUT_GAIN_DB = -4
"""


NOISE_BED_OPTIONS = """# TRANSMISSIONS: radio/static/noise layer.
# This favors spectral resemblance while allowing overlapping texture.
SEARCH = [
	spass('closest_percent', d('noisiness-seg', norm=1), percent=40),
	spass('closest_percent', d('centroid-seg', norm=1), percent=30),
	spass('closest', d('flatnesses-seg')),
]

SUPERIMPOSE = si(minSegment=1, maxSegment=4, maxOverlap=8, searchOrder='power')
OUTPUT_GAIN_DB = -10
"""


MEMORY_DRIFT_OPTIONS = """# TRANSMISSIONS: degraded-source memory.
# The final winner comes from a broad candidate pool, so different seeds matter.
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), percent=45),
	spass('closest_percent', d('mfccs-seg'), percent=20),
]

SUPERIMPOSE = si(maxSegment=3, maxOverlap=4, subtractScale=0.75)
ROTATE_VOICES = True
OUTPUT_GAIN_DB = -6
"""


BUILTIN_PRESETS = {
	"beat_chop": CreativePreset(
		name="beat_chop",
		label="Beat Chop",
		description="Tight rhythmic replacement for loops, drums, and sample chops.",
		output_formats=("csound", "json", "reaper"),
		options_text=BEAT_CHOP_OPTIONS,
	),
	"vocal_transmission": CreativePreset(
		name="vocal_transmission",
		label="Vocal Transmission",
		description="Loose vocal/radio cut-up with rotation and broken phrase memory.",
		output_formats=("csound", "json", "reaper"),
		options_text=VOCAL_TRANSMISSION_OPTIONS,
	),
	"noise_bed": CreativePreset(
		name="noise_bed",
		label="Noise Bed",
		description="Layered radio, vinyl, room tone, or static beds for resampling.",
		output_formats=("csound", "json"),
		options_text=NOISE_BED_OPTIONS,
	),
	"memory_drift": CreativePreset(
		name="memory_drift",
		label="Memory Drift",
		description="Less literal matching for strange, repeatable variation takes.",
		output_formats=("csound", "json", "reaper"),
		options_text=MEMORY_DRIFT_OPTIONS,
	),
}


def list_presets() -> list[CreativePreset]:
	"""Return built-in presets, with YAML presets overriding matching names."""
	presets = dict(BUILTIN_PRESETS)
	for preset in _load_yaml_presets():
		presets[preset.name] = preset
	return sorted(presets.values(), key=lambda preset: preset.label.lower())


def get_preset(name: str) -> CreativePreset:
	"""Return a preset by machine name."""
	for preset in list_presets():
		if preset.name == name:
			return preset
	raise PresetError(f'unknown preset: "{name}"')


def _load_yaml_presets() -> list[CreativePreset]:
	presets_dir = bundled_resource_path("audioguide_gui", "presets")
	if not presets_dir.exists():
		return []
	try:
		import yaml  # type: ignore[import-not-found]
	except ImportError:
		return []

	presets: list[CreativePreset] = []
	for path in sorted(presets_dir.glob("*.yaml")) + sorted(presets_dir.glob("*.yml")):
		payload = yaml.safe_load(path.read_text(encoding="utf-8"))
		if payload is None:
			continue
		if not isinstance(payload, dict):
			raise PresetError(f"preset must contain a YAML object: {path}")
		presets.append(_preset_from_mapping(payload, path))
	return presets


def _preset_from_mapping(payload: dict[str, Any], path: Path) -> CreativePreset:
	name = str(payload.get("name") or path.stem)
	label = str(payload.get("label") or name.replace("_", " ").title())
	description = str(payload.get("description") or "")
	output_formats = payload.get("output_formats", [])
	options_text = str(payload.get("options_text") or "")
	if not isinstance(output_formats, list):
		raise PresetError(f"output_formats must be a list: {path}")
	if not options_text.strip():
		raise PresetError(f"options_text is required: {path}")
	return CreativePreset(
		name=name,
		label=label,
		description=description,
		output_formats=tuple(str(format_name) for format_name in output_formats),
		options_text=options_text,
	)


__all__ = [
	"CreativePreset",
	"PresetError",
	"get_preset",
	"list_presets",
]
