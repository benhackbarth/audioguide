"""Tests for creative preset loading."""

import unittest

from audioguide_gui.presets import get_preset, list_presets, render_preset_options


class PresetTest(unittest.TestCase):
	def test_builtin_presets_include_transmissions_modes(self):
		names = {preset.name for preset in list_presets()}

		self.assertIn("beat_chop", names)
		self.assertIn("vocal_transmission", names)
		self.assertIn("noise_bed", names)
		self.assertIn("memory_drift", names)

	def test_get_preset_returns_options_text(self):
		preset = get_preset("beat_chop")

		self.assertEqual(preset.label, "Beat Chop")
		self.assertIn("closest_percent", preset.options_text)
		self.assertIn("reaper", preset.output_formats)

	def test_render_preset_options_applies_parameters(self):
		preset = get_preset("beat_chop")

		options_text = render_preset_options(preset, {"duration_percent": 12, "max_segment": 0.5})

		self.assertIn("percent=12", options_text)
		self.assertIn("maxSegment=0.5", options_text)


if __name__ == "__main__":
	unittest.main()
