"""Tests for TRANSMISSIONS render manifests."""

from pathlib import Path
from tempfile import TemporaryDirectory
import json
import unittest

from audioguide_gui.project import ProjectConfig
from audioguide_gui.render_manifest import write_render_manifest


class RenderManifestTest(unittest.TestCase):
	def test_write_render_manifest_records_takes_and_roles(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			config = ProjectConfig(
				target_path="target.wav",
				corpus_paths=["corpus"],
				corpus_groups={"drums": ["drums"]},
				output_dir=str(root),
				output_name="take-001",
				preset_name="beat_chop",
				preset_parameters={"duration_percent": 12},
				random_seed=4,
				render_csound=True,
				output_json=True,
				output_reaper=True,
				output_aaf=True,
			)

			manifest_path = write_render_manifest([(config, root / "take-001-options.py")])

			payload = json.loads(manifest_path.read_text(encoding="utf-8"))
			self.assertEqual(payload["preset"], "beat_chop")
			self.assertEqual(payload["preset_parameters"], {"duration_percent": 12})
			self.assertEqual(payload["corpus_groups"], {"drums": ["drums"]})
			self.assertEqual(payload["takes"][0]["random_seed"], 4)
			self.assertEqual(payload["takes"][0]["audio_file"], str(root / "take-001.aiff"))
			self.assertEqual(payload["takes"][0]["json_file"], str(root / "take-001.json"))
			self.assertEqual(payload["takes"][0]["rpp_file"], str(root / "take-001.rpp"))
			self.assertEqual(payload["takes"][0]["aaf_file"], str(root / "take-001.aaf"))
			self.assertEqual(payload["takes"][0]["html_log_file"], str(root / "take-001-log.html"))


if __name__ == "__main__":
	unittest.main()
