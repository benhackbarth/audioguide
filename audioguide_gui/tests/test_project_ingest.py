"""Tests for TRANSMISSIONS project ingest helpers."""

from pathlib import Path
from tempfile import TemporaryDirectory
import json
import unittest

from audioguide_gui.project import load_project_file
from audioguide_gui.project_ingest import (
	CorpusSource,
	ProjectIngestRequest,
	collect_audio_files,
	create_transmissions_project,
)


class ProjectIngestTest(unittest.TestCase):
	def test_collect_audio_files_finds_supported_files_recursively(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			(root / "loop.wav").write_bytes(b"wav")
			(root / "nested").mkdir()
			(root / "nested" / "voice.aiff").write_bytes(b"aiff")
			(root / ".hidden").mkdir()
			(root / ".hidden" / "skip.wav").write_bytes(b"skip")
			(root / "notes.txt").write_text("ignore", encoding="utf-8")

			files = collect_audio_files(root)

			self.assertEqual([path.name for path in files], ["loop.wav", "voice.aiff"])

	def test_create_transmissions_project_copies_sources_and_writes_project(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			source = root / "source"
			source.mkdir()
			target = source / "target.wav"
			target.write_bytes(b"target")
			corpus = source / "corpus"
			corpus.mkdir()
			(corpus / "break.wav").write_bytes(b"break")
			drums = source / "drums"
			drums.mkdir()
			(drums / "kick.aiff").write_bytes(b"kick")
			project_dir = root / "session"

			result = create_transmissions_project(
				ProjectIngestRequest(
					project_dir=str(project_dir),
					project_name="My Beat Session",
					target_path=str(target),
					corpus_sources=(
						CorpusSource("main", str(corpus)),
						CorpusSource("drums", str(drums)),
					),
					take_count=6,
				)
			)

			self.assertTrue((project_dir / "source" / "target" / "target.wav").exists())
			self.assertTrue((project_dir / "source" / "corpus" / "main" / "break.wav").exists())
			self.assertTrue((project_dir / "source" / "corpus" / "drums" / "kick.aiff").exists())
			self.assertTrue((project_dir / "renders").is_dir())
			self.assertTrue(result.project_file.exists())
			self.assertTrue(result.manifest_path.exists())
			self.assertTrue(result.readme_path.exists())
			self.assertEqual(result.config.output_name, "my-beat-session")
			self.assertEqual(result.config.take_count, 6)
			self.assertEqual(result.config.preset_name, "dusty_drum_chop")
			self.assertEqual(result.config.corpus_paths, [str(project_dir / "source" / "corpus" / "main")])
			self.assertEqual(result.config.corpus_groups["drums"], [str(project_dir / "source" / "corpus" / "drums")])
			loaded = load_project_file(result.project_file)
			self.assertEqual(loaded.target_path, result.config.target_path)
			manifest = json.loads(result.manifest_path.read_text(encoding="utf-8"))
			self.assertEqual(manifest["project_name"], "My Beat Session")
			self.assertEqual(manifest["corpus_sources"][0]["audio_file_count"], 1)

	def test_create_transmissions_project_warns_for_empty_source(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			target = root / "target.wav"
			target.write_bytes(b"target")
			empty = root / "empty"
			empty.mkdir()
			main = root / "main"
			main.mkdir()
			(main / "texture.wav").write_bytes(b"texture")

			result = create_transmissions_project(
				ProjectIngestRequest(
					project_dir=str(root / "session"),
					project_name="Warnings",
					target_path=str(target),
					corpus_sources=(CorpusSource("main", str(main)), CorpusSource("noise", str(empty))),
				)
			)

			self.assertEqual(len(result.warnings), 1)
			self.assertIn("noise: no supported audio files", result.warnings[0])
			self.assertNotIn("noise", result.config.corpus_groups)


if __name__ == "__main__":
	unittest.main()
