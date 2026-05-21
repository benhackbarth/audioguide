"""Tests for TRANSMISSIONS take manifest loading and annotations."""

from pathlib import Path
from tempfile import TemporaryDirectory
import json
import unittest

from audioguide_gui.take_manifest import load_take_entries, save_take_annotation


class TakeManifestTest(unittest.TestCase):
	def test_load_take_entries_finds_outputs_and_annotations(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			(root / "demo-take-001.aiff").write_text("audio", encoding="utf-8")
			(root / "demo-take-001.json").write_text("{}", encoding="utf-8")
			options_path = root / "demo-take-001-options.py"
			options_path.write_text("# options", encoding="utf-8")
			manifest_path = root / "transmissions-render-manifest.json"
			manifest_path.write_text(
				json.dumps(
					{
						"output_dir": str(root),
						"takes": [
							{
								"take": 1,
								"output_name": "demo-take-001",
								"random_seed": 99,
								"options_file": str(options_path),
							}
						],
					}
				),
				encoding="utf-8",
			)

			save_take_annotation(manifest_path, "demo-take-001", rating=4, keeper=True, notes="use bar 3")
			entries = load_take_entries(manifest_path)

			self.assertEqual(len(entries), 1)
			self.assertEqual(entries[0].audio_file, root / "demo-take-001.aiff")
			self.assertEqual(entries[0].json_file, root / "demo-take-001.json")
			self.assertEqual(entries[0].rating, 4)
			self.assertTrue(entries[0].keeper)
			self.assertEqual(entries[0].notes, "use bar 3")


if __name__ == "__main__":
	unittest.main()
