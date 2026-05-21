"""Tests for TRANSMISSIONS keeper pack and assembly exports."""

from pathlib import Path
from tempfile import TemporaryDirectory
import json
import unittest
import wave

from audioguide_gui.keeper_export import export_keepers, export_reaper_assembly
from audioguide_gui.take_manifest import save_take_annotation


class KeeperExportTest(unittest.TestCase):
	def test_export_keepers_copies_selected_files_and_writes_manifest(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			manifest_path = _write_manifest(root)
			save_take_annotation(
				manifest_path,
				"demo-take-001",
				rating=5,
				keeper=False,
				notes="hard drums",
				tags=["drums", "hook"],
			)
			save_take_annotation(manifest_path, "demo-take-002", rating=2, keeper=True, notes="strange", tags=["weird"])
			save_take_annotation(manifest_path, "demo-take-003", rating=1, keeper=False, notes="skip")

			result = export_keepers(manifest_path)

			self.assertEqual(result.exported_count, 2)
			self.assertTrue((result.destination / "demo-take-001.wav").exists())
			self.assertTrue((result.destination / "demo-take-002.wav").exists())
			self.assertTrue((root / "demo-take-001.wav").exists())
			payload = json.loads(result.manifest_path.read_text(encoding="utf-8"))
			self.assertEqual(payload["preset"], "dusty_drum_chop")
			self.assertEqual([take["output_name"] for take in payload["takes"]], ["demo-take-001", "demo-take-002"])
			self.assertEqual(payload["takes"][0]["tags"], ["drums", "hook"])

	def test_export_keepers_warns_for_missing_audio(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			options_path = root / "missing-options.py"
			options_path.write_text("# options", encoding="utf-8")
			manifest_path = root / "transmissions-render-manifest.json"
			manifest_path.write_text(
				json.dumps(
					{
						"output_dir": str(root),
						"takes": [{"take": 1, "output_name": "missing", "options_file": str(options_path)}],
					}
				),
				encoding="utf-8",
			)
			save_take_annotation(manifest_path, "missing", rating=5, keeper=False, notes="")

			result = export_keepers(manifest_path)

			self.assertEqual(result.exported_count, 1)
			self.assertIn("missing: no audio file exported", result.warnings)

	def test_export_reaper_assembly_groups_tracks_by_first_tag(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			manifest_path = _write_manifest(root)
			save_take_annotation(manifest_path, "demo-take-001", rating=5, keeper=True, notes="", tags=["drums"])
			save_take_annotation(manifest_path, "demo-take-002", rating=4, keeper=False, notes="", tags=["vocal"])
			result = export_keepers(manifest_path)

			assembly_path = export_reaper_assembly(result.manifest_path)

			text = assembly_path.read_text(encoding="utf-8")
			self.assertIn("<REAPER_PROJECT", text)
			self.assertIn('NAME "drums"', text)
			self.assertIn('NAME "vocal"', text)
			self.assertIn("demo-take-001.wav", text)
			self.assertIn('NAME "take 001 r5 demo-take-001"', text)


def _write_manifest(root: Path) -> Path:
	takes = []
	for index in range(1, 4):
		output_name = f"demo-take-{index:03d}"
		audio_path = root / f"{output_name}.wav"
		_write_wav(audio_path)
		json_path = root / f"{output_name}.json"
		json_path.write_text("{}", encoding="utf-8")
		options_path = root / f"{output_name}-options.py"
		options_path.write_text("# options", encoding="utf-8")
		takes.append(
			{
				"take": index,
				"output_name": output_name,
				"random_seed": 100 + index,
				"options_file": str(options_path),
				"audio_file": str(audio_path),
				"json_file": str(json_path),
			}
		)
	manifest_path = root / "transmissions-render-manifest.json"
	manifest_path.write_text(
		json.dumps(
			{
				"preset": "dusty_drum_chop",
				"preset_parameters": {"density": 4},
				"output_dir": str(root),
				"takes": takes,
			}
		),
		encoding="utf-8",
	)
	return manifest_path


def _write_wav(path: Path) -> None:
	with wave.open(str(path), "wb") as audio:
		audio.setnchannels(1)
		audio.setsampwidth(2)
		audio.setframerate(44100)
		audio.writeframes(b"\x00\x00" * 4410)


if __name__ == "__main__":
	unittest.main()
