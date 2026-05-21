"""Tests for lightweight audio preview helpers."""

from pathlib import Path
from tempfile import TemporaryDirectory
import math
import struct
import unittest
import wave

from audioguide_gui.audio_preview import extract_audio_peaks


class AudioPreviewTest(unittest.TestCase):
	def test_extract_audio_peaks_reads_wave_file(self):
		with TemporaryDirectory() as tmp:
			path = Path(tmp) / "tone.wav"
			with wave.open(str(path), "wb") as handle:
				handle.setnchannels(1)
				handle.setsampwidth(2)
				handle.setframerate(8000)
				frames = []
				for index in range(800):
					value = int(math.sin(index / 10) * 20000)
					frames.append(struct.pack("<h", value))
				handle.writeframes(b"".join(frames))

			peaks = extract_audio_peaks(path, bins=16)

			self.assertEqual(len(peaks), 16)
			self.assertGreater(max(peaks), 0.9)
			self.assertGreaterEqual(min(peaks), 0.0)

	def test_extract_audio_peaks_handles_missing_file(self):
		self.assertEqual(extract_audio_peaks("/missing/audio.wav"), [])


if __name__ == "__main__":
	unittest.main()
