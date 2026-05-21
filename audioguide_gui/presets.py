"""Creative option presets for AudioGuide GUI sessions."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any
from collections import defaultdict

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
	parameters: dict[str, float | int | str]


BEAT_CHOP_OPTIONS = """# TRANSMISSIONS: tight rhythmic replacement.
# The first pass keeps durations and power close enough to preserve beat logic.
# The percent passes leave room for random variation when RANDOM_SEED changes.
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent={duration_percent}),
	spass('closest_percent', d('centroid-seg', norm=1), percent={color_percent}),
	spass('closest', d('mfccs-seg')),
]

SUPERIMPOSE = si(maxSegment={max_segment}, peakAlign=True, searchOrder='power')
ROTATE_VOICES = False
OUTPUT_GAIN_DB = {output_gain_db}
"""


VOCAL_TRANSMISSION_OPTIONS = """# TRANSMISSIONS: vocal/radio cut-up.
# Looser candidate pools create broken phrase memory instead of literal matching.
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), percent={duration_percent}),
	spass('parser', 'noisiness-seg >= 50%', 'closest_percent', [d('mfccs-seg')], [d('f0-seg')], percent={voice_percent}),
	spass('closest_percent', d('centroid-seg', norm=1), percent={color_percent}),
]

SUPERIMPOSE = si(maxSegment={max_segment}, maxOverlap={max_overlap}, peakAlign=True, searchOrder='power')
ROTATE_VOICES = True
OUTPUT_GAIN_DB = {output_gain_db}
"""


NOISE_BED_OPTIONS = """# TRANSMISSIONS: radio/static/noise layer.
# This favors spectral resemblance while allowing overlapping texture.
SEARCH = [
	spass('closest_percent', d('noisiness-seg', norm=1), percent={noise_percent}),
	spass('closest_percent', d('centroid-seg', norm=1), percent={color_percent}),
	spass('closest', d('flatnesses-seg')),
]

SUPERIMPOSE = si(minSegment=1, maxSegment={max_segment}, maxOverlap={max_overlap}, searchOrder='power')
OUTPUT_GAIN_DB = {output_gain_db}
"""


MEMORY_DRIFT_OPTIONS = """# TRANSMISSIONS: degraded-source memory.
# The final winner comes from a broad candidate pool, so different seeds matter.
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), percent={duration_percent}),
	spass('closest_percent', d('mfccs-seg'), percent={timbre_percent}),
]

SUPERIMPOSE = si(maxSegment={max_segment}, maxOverlap={max_overlap}, subtractScale={subtract_scale})
ROTATE_VOICES = True
OUTPUT_GAIN_DB = {output_gain_db}
"""


DUSTY_DRUM_CHOP_OPTIONS = """# TRANSMISSIONS macro preset: dusty drum chop.
# density={density}, chop_size={chop_size}, chaos={chaos}, timbre_bias={timbre_bias}, rhythm_lock={rhythm_lock}
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent={rhythm_lock}),
	spass('closest_percent', d('centroid-seg', norm=1), percent={timbre_bias}),
	spass('closest_percent', d('mfccs-seg'), percent={chaos}),
]

SUPERIMPOSE = si(maxSegment={chop_size}, maxOverlap={density}, peakAlign=True, searchOrder='power')
ROTATE_VOICES = False
OUTPUT_GAIN_DB = {output_gain_db}
"""


VOCAL_GHOSTS_OPTIONS = """# TRANSMISSIONS macro preset: vocal ghosts.
# density={density}, chop_size={chop_size}, chaos={chaos}, timbre_bias={timbre_bias}, rhythm_lock={rhythm_lock}
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), percent={rhythm_lock}),
	spass('parser', 'noisiness-seg >= 35%', 'closest_percent', [d('mfccs-seg')], [d('f0-seg')], percent={chaos}),
	spass('closest_percent', d('centroid-seg', norm=1), percent={timbre_bias}),
]

SUPERIMPOSE = si(maxSegment={chop_size}, maxOverlap={density}, peakAlign=True, searchOrder='power')
ROTATE_VOICES = True
OUTPUT_GAIN_DB = {output_gain_db}
"""


RADIO_MEMORY_OPTIONS = """# TRANSMISSIONS macro preset: radio memory.
# density={density}, chop_size={chop_size}, chaos={chaos}, timbre_bias={timbre_bias}, rhythm_lock={rhythm_lock}
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), percent={rhythm_lock}),
	spass('closest_percent', d('noisiness-seg', norm=1), percent={chaos}),
	spass('closest_percent', d('mfccs-seg'), percent={timbre_bias}),
]

SUPERIMPOSE = si(maxSegment={chop_size}, maxOverlap={density}, subtractScale=0.65, searchOrder='power')
ROTATE_VOICES = True
OUTPUT_GAIN_DB = {output_gain_db}
"""


BREAKBEAT_SHATTER_OPTIONS = """# TRANSMISSIONS macro preset: breakbeat shatter.
# density={density}, chop_size={chop_size}, chaos={chaos}, timbre_bias={timbre_bias}, rhythm_lock={rhythm_lock}
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent={rhythm_lock}),
	spass('closest_percent', d('centroid-seg', norm=1), percent={timbre_bias}),
	spass('closest_percent', d('flatnesses-seg'), percent={chaos}),
]

SUPERIMPOSE = si(maxSegment={chop_size}, maxOverlap={density}, peakAlign=True, searchOrder='power')
ROTATE_VOICES = True
OUTPUT_GAIN_DB = {output_gain_db}
"""


AMBIENT_BED_GLUE_OPTIONS = """# TRANSMISSIONS macro preset: ambient bed glue.
# density={density}, chop_size={chop_size}, chaos={chaos}, timbre_bias={timbre_bias}, rhythm_lock={rhythm_lock}
SEARCH = [
	spass('closest_percent', d('effDur-seg', norm=1), percent={rhythm_lock}),
	spass('closest_percent', d('centroid-seg', norm=1), percent={timbre_bias}),
	spass('closest_percent', d('noisiness-seg', norm=1), percent={chaos}),
]

SUPERIMPOSE = si(minSegment=1, maxSegment={chop_size}, maxOverlap={density}, subtractScale=0.8, searchOrder='power')
ROTATE_VOICES = True
OUTPUT_GAIN_DB = {output_gain_db}
"""


BUILTIN_PRESETS = {
	"beat_chop": CreativePreset(
		name="beat_chop",
		label="Beat Chop",
		description="Tight rhythmic replacement for loops, drums, and sample chops.",
		output_formats=("csound", "json", "reaper"),
		options_text=BEAT_CHOP_OPTIONS,
		parameters={"duration_percent": 18, "color_percent": 30, "max_segment": 1, "output_gain_db": -3},
	),
	"vocal_transmission": CreativePreset(
		name="vocal_transmission",
		label="Vocal Transmission",
		description="Loose vocal/radio cut-up with rotation and broken phrase memory.",
		output_formats=("csound", "json", "reaper"),
		options_text=VOCAL_TRANSMISSION_OPTIONS,
		parameters={
			"duration_percent": 35,
			"voice_percent": 25,
			"color_percent": 20,
			"max_segment": 2,
			"max_overlap": 3,
			"output_gain_db": -4,
		},
	),
	"noise_bed": CreativePreset(
		name="noise_bed",
		label="Noise Bed",
		description="Layered radio, vinyl, room tone, or static beds for resampling.",
		output_formats=("csound", "json"),
		options_text=NOISE_BED_OPTIONS,
		parameters={"noise_percent": 40, "color_percent": 30, "max_segment": 4, "max_overlap": 8, "output_gain_db": -10},
	),
	"memory_drift": CreativePreset(
		name="memory_drift",
		label="Memory Drift",
		description="Less literal matching for strange, repeatable variation takes.",
		output_formats=("csound", "json", "reaper"),
		options_text=MEMORY_DRIFT_OPTIONS,
		parameters={
			"duration_percent": 45,
			"timbre_percent": 20,
			"max_segment": 3,
			"max_overlap": 4,
			"subtract_scale": 0.75,
			"output_gain_db": -6,
		},
	),
	"dusty_drum_chop": CreativePreset(
		name="dusty_drum_chop",
		label="Dusty Drum Chop",
		description="Short, punchy drum replacement for cut-up hip hop loops and break fragments.",
		output_formats=("csound", "json", "reaper"),
		options_text=DUSTY_DRUM_CHOP_OPTIONS,
		parameters={"density": 4, "chop_size": 0.35, "chaos": 18, "timbre_bias": 24, "rhythm_lock": 12, "output_gain_db": -3},
	),
	"vocal_ghosts": CreativePreset(
		name="vocal_ghosts",
		label="Vocal Ghosts",
		description="Airy vocal and radio phrase fragments for haunted hooks and ad-lib beds.",
		output_formats=("csound", "json", "reaper"),
		options_text=VOCAL_GHOSTS_OPTIONS,
		parameters={"density": 5, "chop_size": 1.2, "chaos": 32, "timbre_bias": 18, "rhythm_lock": 35, "output_gain_db": -5},
	),
	"radio_memory": CreativePreset(
		name="radio_memory",
		label="Radio Memory",
		description="Broken radio scan collage with noisy timbral jumps and repeatable drift.",
		output_formats=("csound", "json", "reaper"),
		options_text=RADIO_MEMORY_OPTIONS,
		parameters={"density": 6, "chop_size": 0.8, "chaos": 45, "timbre_bias": 22, "rhythm_lock": 42, "output_gain_db": -6},
	),
	"breakbeat_shatter": CreativePreset(
		name="breakbeat_shatter",
		label="Breakbeat Shatter",
		description="Aggressive micro-chop preset for splintered drums, stutters, and beat fills.",
		output_formats=("csound", "json", "reaper"),
		options_text=BREAKBEAT_SHATTER_OPTIONS,
		parameters={"density": 8, "chop_size": 0.18, "chaos": 28, "timbre_bias": 35, "rhythm_lock": 8, "output_gain_db": -4},
	),
	"ambient_bed_glue": CreativePreset(
		name="ambient_bed_glue",
		label="Ambient Bed Glue",
		description="Longer overlapping texture bed for smoothing edits and resampling transitions.",
		output_formats=("csound", "json"),
		options_text=AMBIENT_BED_GLUE_OPTIONS,
		parameters={"density": 10, "chop_size": 5.0, "chaos": 38, "timbre_bias": 26, "rhythm_lock": 55, "output_gain_db": -12},
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


def render_preset_options(preset: CreativePreset, parameters: dict[str, Any] | None = None) -> str:
	"""Return preset option text with validated parameter substitution."""
	values = dict(preset.parameters)
	if parameters:
		values.update({key: value for key, value in parameters.items() if value not in (None, "")})
	return preset.options_text.format_map(defaultdict(str, values))


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
	parameters = payload.get("parameters", {})
	if not isinstance(output_formats, list):
		raise PresetError(f"output_formats must be a list: {path}")
	if not isinstance(parameters, dict):
		raise PresetError(f"parameters must be an object: {path}")
	if not options_text.strip():
		raise PresetError(f"options_text is required: {path}")
	return CreativePreset(
		name=name,
		label=label,
		description=description,
		output_formats=tuple(str(format_name) for format_name in output_formats),
		options_text=options_text,
		parameters=dict(parameters),
	)


__all__ = [
	"CreativePreset",
	"PresetError",
	"get_preset",
	"list_presets",
	"render_preset_options",
]
