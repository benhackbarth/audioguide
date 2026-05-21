"""Audio preview helpers for lightweight take waveforms."""

from __future__ import annotations

from pathlib import Path
import struct
import wave


def extract_audio_peaks(path: str | Path, bins: int = 160) -> list[float]:
	"""Return normalized peak amplitudes for a WAV/AIFF-family file."""
	audio_path = Path(path).expanduser()
	if bins <= 0 or not audio_path.exists():
		return []
	suffix = audio_path.suffix.lower()
	try:
		if suffix in {".wav", ".wave"}:
			samples = _read_wave_samples(audio_path)
		elif suffix in {".aif", ".aiff"}:
			samples = _read_aiff_samples(audio_path)
		else:
			return []
	except (OSError, EOFError, struct.error, wave.Error):
		return []
	return _samples_to_peaks(samples, bins)


def _read_wave_samples(path: Path) -> list[float]:
	with wave.open(str(path), "rb") as handle:
		channels = handle.getnchannels()
		sample_width = handle.getsampwidth()
		data = handle.readframes(handle.getnframes())
	return _pcm_bytes_to_samples(data, sample_width, channels, "little", unsigned_8_bit=True)


def _read_aiff_samples(path: Path) -> list[float]:
	data = path.read_bytes()
	if len(data) < 12 or data[:4] != b"FORM" or data[8:12] not in {b"AIFF", b"AIFC"}:
		return []
	channels = 1
	sample_width = 2
	sound_data = b""
	offset = 12
	while offset + 8 <= len(data):
		chunk_id = data[offset : offset + 4]
		chunk_size = int.from_bytes(data[offset + 4 : offset + 8], "big")
		chunk_start = offset + 8
		chunk_end = chunk_start + chunk_size
		if chunk_end > len(data):
			break
		chunk = data[chunk_start:chunk_end]
		if chunk_id == b"COMM" and len(chunk) >= 18:
			channels = int.from_bytes(chunk[0:2], "big")
			sample_size = int.from_bytes(chunk[6:8], "big")
			sample_width = max(1, (sample_size + 7) // 8)
			if data[8:12] == b"AIFC" and len(chunk) >= 22 and chunk[18:22] != b"NONE":
				return []
		elif chunk_id == b"SSND" and len(chunk) >= 8:
			data_offset = int.from_bytes(chunk[0:4], "big")
			sound_data = chunk[8 + data_offset :]
		offset = chunk_end + (chunk_size % 2)
	return _pcm_bytes_to_samples(sound_data, sample_width, channels, "big", unsigned_8_bit=False)


def _pcm_bytes_to_samples(
	data: bytes,
	sample_width: int,
	channels: int,
	byteorder: str,
	*,
	unsigned_8_bit: bool,
) -> list[float]:
	if sample_width not in {1, 2, 3, 4} or channels <= 0:
		return []
	frame_width = sample_width * channels
	if frame_width <= 0:
		return []
	limit = len(data) - (len(data) % frame_width)
	samples: list[float] = []
	for frame_start in range(0, limit, frame_width):
		frame_peak = 0.0
		for channel_start in range(frame_start, frame_start + frame_width, sample_width):
			raw = data[channel_start : channel_start + sample_width]
			value = _decode_pcm_sample(raw, sample_width, byteorder, unsigned_8_bit)
			frame_peak = max(frame_peak, abs(value))
		samples.append(frame_peak)
	return samples


def _decode_pcm_sample(raw: bytes, sample_width: int, byteorder: str, unsigned_8_bit: bool) -> float:
	if sample_width == 1:
		value = raw[0] - 128 if unsigned_8_bit else int.from_bytes(raw, byteorder, signed=True)
		return value / 128.0
	value = int.from_bytes(raw, byteorder, signed=True)
	scale = float(1 << ((sample_width * 8) - 1))
	return value / scale


def _samples_to_peaks(samples: list[float], bins: int) -> list[float]:
	if not samples:
		return []
	bins = min(bins, len(samples))
	step = len(samples) / bins
	peaks: list[float] = []
	for index in range(bins):
		start = int(index * step)
		end = max(start + 1, int((index + 1) * step))
		peaks.append(min(1.0, max(samples[start:end])))
	max_peak = max(peaks) or 1.0
	return [peak / max_peak for peak in peaks]


__all__ = ["extract_audio_peaks"]
