"""Tests for AudioGuide GUI project preset persistence."""

from pathlib import Path
from tempfile import TemporaryDirectory
import json
import unittest

from audioguide_gui.project import ProjectConfig, load_project_file, save_project_file


class ProjectFileTest(unittest.TestCase):
	def test_save_and_load_project_file_round_trips_settings(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			project_path = root / "session.agui"
			config = ProjectConfig(
				target_path=str(root / "sounds" / "target.aiff"),
				corpus_paths=[str(root / "corpus"), "/external/corpus"],
				output_dir=str(root / "renders"),
				output_name="demo",
				render_csound=False,
				output_json=True,
				output_reaper=True,
				output_aaf=False,
				extra_options_text="VERBOSITY = 0\n",
				last_options_file_path=str(root / "renders" / "options.py"),
				preset_name="beat_chop",
				random_seed=77,
				take_count=4,
			)

			written_path = save_project_file(config, project_path)
			self.assertEqual(written_path, project_path)

			payload = json.loads(project_path.read_text(encoding="utf-8"))
			self.assertEqual(payload["target_path"], "sounds/target.aiff")
			self.assertEqual(payload["corpus_paths"], ["corpus", "/external/corpus"])
			self.assertEqual(payload["output_folder"], "renders")
			self.assertEqual(payload["output_name"], "demo")
			self.assertEqual(payload["selected_output_formats"], ["json", "reaper"])
			self.assertEqual(payload["advanced_options_text"], "VERBOSITY = 0\n")
			self.assertEqual(payload["last_generated_options_file_path"], "renders/options.py")
			self.assertEqual(payload["preset_name"], "beat_chop")
			self.assertEqual(payload["random_seed"], 77)
			self.assertEqual(payload["take_count"], 4)

			loaded = load_project_file(project_path)
			self.assertEqual(loaded.target_path, str(root / "sounds" / "target.aiff"))
			self.assertEqual(loaded.corpus_paths, [str(root / "corpus"), "/external/corpus"])
			self.assertEqual(loaded.output_dir, str(root / "renders"))
			self.assertEqual(loaded.output_name, "demo")
			self.assertFalse(loaded.render_csound)
			self.assertTrue(loaded.output_json)
			self.assertTrue(loaded.output_reaper)
			self.assertFalse(loaded.output_aaf)
			self.assertEqual(loaded.extra_options_text, "VERBOSITY = 0\n")
			self.assertEqual(loaded.last_options_file_path, str(root / "renders" / "options.py"))
			self.assertEqual(loaded.preset_name, "beat_chop")
			self.assertEqual(loaded.random_seed, 77)
			self.assertEqual(loaded.take_count, 4)

	def test_save_project_file_adds_agui_extension(self):
		with TemporaryDirectory() as tmp:
			path = save_project_file(ProjectConfig(), Path(tmp) / "session")
			self.assertEqual(path.suffix, ".agui")
			self.assertTrue(path.exists())


if __name__ == "__main__":
	unittest.main()
