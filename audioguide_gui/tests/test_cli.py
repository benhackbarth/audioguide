"""Tests for the AudioGuide GUI command-line config loader."""

from pathlib import Path
from tempfile import TemporaryDirectory
import json
import unittest

from audioguide_gui.cli import load_cli_config, main


class CliConfigTest(unittest.TestCase):
	def test_load_json_config_resolves_relative_paths(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			config_path = root / "config.json"
			config_path.write_text(
				json.dumps(
					{
						"target": "target.aiff",
						"corpus": ["corpus"],
						"output_dir": "renders",
						"output_name": "demo",
						"preset": "beat_chop",
						"preset_parameters": {"duration_percent": 22, "max_segment": 1.5},
						"random_seed": 99,
						"take_count": 3,
						"corpus_groups": {"drums": "drums", "noise": ["radio"]},
						"output_formats": ["json", "reaper"],
						"extra_options_text": "VERBOSITY = 0\n",
					}
				),
				encoding="utf-8",
			)

			config = load_cli_config(config_path)

			self.assertEqual(config.target_path, str(root / "target.aiff"))
			self.assertEqual(config.corpus_paths, [str(root / "corpus")])
			self.assertEqual(config.output_dir, str(root / "renders"))
			self.assertEqual(config.output_name, "demo")
			self.assertFalse(config.render_csound)
			self.assertTrue(config.output_json)
			self.assertTrue(config.output_reaper)
			self.assertFalse(config.output_aaf)
			self.assertEqual(config.preset_name, "beat_chop")
			self.assertEqual(config.preset_parameters, {"duration_percent": 22, "max_segment": 1.5})
			self.assertEqual(config.random_seed, 99)
			self.assertEqual(config.take_count, 3)
			self.assertEqual(config.corpus_groups, {"drums": [str(root / "drums")], "noise": [str(root / "radio")]})
			self.assertIn("closest_percent", config.extra_options_text)
			self.assertIn("percent=22", config.extra_options_text)
			self.assertIn("maxSegment=1.5", config.extra_options_text)
			self.assertIn("VERBOSITY = 0", config.extra_options_text)

	def test_main_writes_options_file_without_rendering(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			config_path = root / "config.json"
			options_path = root / "generated.py"
			config_path.write_text(
				json.dumps(
					{
						"target_path": "target.aiff",
						"corpus_paths": ["corpus"],
						"output_folder": "renders",
						"output_name": "demo",
						"selected_output_formats": [],
					}
				),
				encoding="utf-8",
			)

			exit_code = main([str(config_path), "--options-file", str(options_path)])

			self.assertEqual(exit_code, 0)
			generated = options_path.read_text(encoding="utf-8")
			self.assertIn("TARGET = tsf", generated)
			self.assertIn("CSOUND_RENDER_FILEPATH = None", generated)
			self.assertIn("DICT_OUTPUT_FILEPATH = None", generated)

	def test_main_writes_batch_options_files(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			config_path = root / "config.json"
			config_path.write_text(
				json.dumps(
					{
						"target_path": "target.aiff",
						"corpus_paths": ["corpus"],
						"output_folder": "renders",
						"output_name": "demo",
						"selected_output_formats": [],
						"random_seed": 10,
						"take_count": 2,
					}
				),
				encoding="utf-8",
			)

			exit_code = main([str(config_path)])

			self.assertEqual(exit_code, 0)
			take_one = root / "renders" / "demo-take-001-options.py"
			take_two = root / "renders" / "demo-take-002-options.py"
			self.assertTrue(take_one.exists())
			self.assertTrue(take_two.exists())
			self.assertTrue((root / "renders" / "transmissions-render-manifest.json").exists())
			self.assertIn("RANDOM_SEED = 10", take_one.read_text(encoding="utf-8"))
			self.assertIn("RANDOM_SEED = 11", take_two.read_text(encoding="utf-8"))


if __name__ == "__main__":
	unittest.main()
