"""Tests for AudioGuide GUI option-file generation."""

from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from audioguide_gui.option_builder import OptionBuilderError, ProjectConfig, build_options_file


class _FakeAudioGuideObject:
	def __init__(self, *args, **kwargs):
		self.args = args
		self.kwargs = kwargs


class OptionBuilderTest(unittest.TestCase):
	def test_build_options_file_writes_parseable_audioguide_python(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			options_path = root / "options" / "generated.py"
			config = ProjectConfig(
				target_path=str(root / "target sound.aiff"),
				corpus_paths=[str(root / "corpus one"), str(root / "corpus two")],
				output_dir=str(root / "render output"),
				output_name="demo-render",
				render_csound=True,
				output_json=True,
				output_reaper=True,
				output_aaf=False,
				random_seed=123,
				extra_options_text="VERBOSITY = 0\nOUTPUT_GAIN_DB = -3",
			)

			written_path = build_options_file(config, options_path)
			self.assertEqual(written_path, options_path)
			generated = options_path.read_text(encoding="utf-8")
			self.assertIn("EXTRA RAW AUDIOGUIDE OPTIONS", generated)
			self.assertIn("VERBOSITY = 0", generated)

			namespace = self._exec_like_audioguide_options_file(generated)
			self.assertEqual(namespace["TARGET"].args, (config.target_path,))
			self.assertEqual([c.args[0] for c in namespace["CORPUS"]], config.corpus_paths)
			self.assertEqual(namespace["CSOUND_RENDER_FILEPATH"], str(root / "render output" / "demo-render.aiff"))
			self.assertEqual(namespace["DICT_OUTPUT_FILEPATH"], str(root / "render output" / "demo-render.json"))
			self.assertEqual(namespace["RPP_FILEPATH"], str(root / "render output" / "demo-render.rpp"))
			self.assertIsNone(namespace["AAF_FILEPATH"])
			self.assertEqual(namespace["RANDOM_SEED"], 123)
			self.assertEqual(namespace["VERBOSITY"], 0)
			self.assertEqual(namespace["OUTPUT_GAIN_DB"], -3)

	def test_build_options_file_preserves_raw_options_text_verbatim(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			raw_options = "# custom\nTARGET = tsf('override.wav')\n\nOUTPUT_GAIN_DB = -3  \n"
			config = ProjectConfig(
				target_path="target.wav",
				corpus_paths=["corpus"],
				output_dir=str(root),
				extra_options_text=raw_options,
			)

			options_path = root / "generated.py"
			build_options_file(config, options_path)
			generated = options_path.read_text(encoding="utf-8")
			marker = "# Values here run after the generated settings above, so they may override them.\n"
			raw_start = generated.index(marker) + len(marker)
			self.assertTrue(generated[raw_start:].startswith(raw_options))

	def test_build_options_file_can_disable_outputs(self):
		with TemporaryDirectory() as tmp:
			root = Path(tmp)
			options_path = root / "generated.py"
			config = ProjectConfig(
				target_path="target.wav",
				corpus_paths=["corpus"],
				output_dir=str(root),
				output_name="silent",
				render_csound=False,
				output_json=False,
			)

			build_options_file(config, options_path)
			namespace = self._exec_like_audioguide_options_file(options_path.read_text(encoding="utf-8"))
			self.assertIsNone(namespace["CSOUND_CSD_FILEPATH"])
			self.assertIsNone(namespace["CSOUND_RENDER_FILEPATH"])
			self.assertIsNone(namespace["DICT_OUTPUT_FILEPATH"])

	def test_build_options_file_requires_core_fields(self):
		with TemporaryDirectory() as tmp:
			with self.assertRaises(OptionBuilderError):
				build_options_file(ProjectConfig(), Path(tmp) / "generated.py")

	def _exec_like_audioguide_options_file(self, generated: str) -> dict:
		namespace = {
			"tsf": _FakeAudioGuideObject,
			"csf": _FakeAudioGuideObject,
			"spass": _FakeAudioGuideObject,
			"si": _FakeAudioGuideObject,
			"d": _FakeAudioGuideObject,
		}
		exec(generated, {}, namespace)
		return namespace


if __name__ == "__main__":
	unittest.main()
