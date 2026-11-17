import numpy as np
import librosa
import audioguide.util as util


def is_valid_audiofile(path):
    try:
        duration = librosa.get_duration(path=path)
        return duration > 0
    except Exception:
        return False



def spectral_skewness_and_kurtosis(magSpec):
	# Exclude DC bin
	S = magSpec[1:, :]
	# Calculate moments across frequency bins
	mean = np.mean(S, axis=0, keepdims=True)
	variance = np.mean((S - mean) ** 2, axis=0, keepdims=True)
	third_moment = np.mean((S - mean) ** 3, axis=0)
	fourth_moment = np.mean((S - mean) ** 4, axis=0)
	# Fisher excess kurtosis
	kurtosis = fourth_moment / (variance.squeeze() ** 2 + 1e-12) - 3
	 # Standardised third central moment
	skewness = third_moment / (variance.squeeze() ** 1.5 + 1e-12)
	return skewness, kurtosis

    



def get_feature_list(n_mels_feature, n_mfcc):
	cnt = 0
	cols = []
	column_dict = {}
	for feat, num in [('rms', 1), ('zeroCross', 1), ('power', 1), ('centroid', 1), ('bandwidth', 1), ('contrast', 7), ('flatness', 1), ('rolloff', 1), ('skewness', 1), ('kurtosis', 1), ('noisiness', 1), ('pfeatures', 2), ('tonnetz', 6), ('f0', 1), ('f0flag', 1), ('f0prob', 1), ('mfcc', n_mfcc), ('mel', n_mels_feature), ('chroma', 12), ('partialfrq', 5), ('partialdb', 5)]:
		if num == 1:
			column_dict[feat] = cnt
			cols.append(feat)
			cnt += 1
		else:
			for n in range(num):
				column_dict['%s%i'%(feat, n)] = cnt
				cols.append('%s%i'%(feat, n))
				cnt += 1
	return cols, column_dict








def extract_all_descriptors(audio_file, resampled_sr=22050, n_fft_features=512, hop_length_features=128, n_win_rms=256, n_hop_rms=64, n_mels_for_mfccs=128, n_mfcc=13, n_mels_feature=14, funda_min_hz=20, funda_max_hz=10000, partial_store_len=5):
	info_dict = {}

	original_y, original_sr = librosa.load(audio_file, sr=None, mono=False)
	info_dict['sr'] = original_sr
	info_dict['lengthsamples'] = len(original_y)
	info_dict['channels'] = 1 if original_y.ndim == 1 else original_y.shape[0]
	
	if info_dict['channels'] > 1:
		original_y = librosa.to_mono(original_y)

	y = librosa.resample(original_y, orig_sr=original_sr, target_sr=resampled_sr)

	info_dict['lengthsec'] = len(original_y)/float(original_sr)
	cols, info_dict['librosad_columns'] = get_feature_list(n_mels_feature, n_mfcc)

	# do FFT
	D = librosa.stft(y, n_fft=n_fft_features, hop_length=hop_length_features)
	info_dict['librosad'] = {'framelength': D.shape[1]}
	feature_array = np.zeros((D.shape[1], len(info_dict['librosad_columns'])))
	
	S = np.abs(D)
	P = S ** 2

	# time-domain descriptors
	#powers = librosa.feature.rms(S=S, frame_length=n_win_rms, hop_length=n_hop_rms)
	powers = librosa.feature.rms(y=y, frame_length=n_win_rms, hop_length=n_hop_rms)[0]
	# we need to compress power list into a shorter length for the features
	groups = np.array_split(powers, D.shape[1])
	# calculate the rms within each group
	powers = np.array([np.sqrt(np.mean(group ** 2)) for group in groups])
	rmses_db = librosa.amplitude_to_db(powers, ref=1.0)
	feature_array[:, info_dict['librosad_columns']['rms']] = rmses_db.flatten()
	feature_array[:, info_dict['librosad_columns']['power']] = (powers*1.666).flatten() # scalar is to make the librosa version the same as ircam's binary output

	zeroCrosses = librosa.feature.zero_crossing_rate(y, frame_length=n_fft_features, hop_length=hop_length_features)
	feature_array[:, info_dict['librosad_columns']['zeroCross']] = zeroCrosses.flatten()

	# Spectral descriptors
	centroids = librosa.feature.spectral_centroid(S=S, sr=resampled_sr)
	centroids_in_midi = librosa.hz_to_midi(np.maximum(centroids, 1e-6))
	feature_array[:, info_dict['librosad_columns']['centroid']] = centroids_in_midi.flatten()

	bandwidths = librosa.feature.spectral_bandwidth(S=S, sr=resampled_sr)
	feature_array[:, info_dict['librosad_columns']['bandwidth']] = bandwidths.flatten()

	feature_array[:, info_dict['librosad_columns']['contrast0']:info_dict['librosad_columns']['contrast0']+7] = librosa.feature.spectral_contrast(S=S, sr=resampled_sr, fmin=100).T

	flatnesses = librosa.feature.spectral_flatness(S=S)
	feature_array[:, info_dict['librosad_columns']['flatness']] = flatnesses.flatten()

	rolloffes = librosa.feature.spectral_rolloff(S=S, sr=resampled_sr)
	feature_array[:, info_dict['librosad_columns']['rolloff']] = rolloffes.flatten()

	feature_array[:, info_dict['librosad_columns']['pfeatures0']:info_dict['librosad_columns']['pfeatures0']+2] = librosa.feature.poly_features(S=S, sr=resampled_sr).T

	skewnesses, kurtosises = spectral_skewness_and_kurtosis(S)
	feature_array[:, info_dict['librosad_columns']['skewness']] = skewnesses.flatten()
	feature_array[:, info_dict['librosad_columns']['kurtosis']] = kurtosises.flatten()

	# HPSS
	kernel_size=31
	margin=1.0
	H, P = librosa.decompose.hpss(S, kernel_size=kernel_size, margin=margin)

	# noisiness
	harmonic_energy = np.sum(H * H, axis=0)
	percussive_energy = np.sum(P * P, axis=0)
	noisinesses = percussive_energy / (harmonic_energy + percussive_energy + 1e-10)
	feature_array[:, info_dict['librosad_columns']['noisiness']] = noisinesses.flatten()

	# partials
	partial_midis = np.zeros((S.shape[1], partial_store_len))
	partial_dbs = np.zeros((S.shape[1], partial_store_len))
	pitches, magnitudes = librosa.piptrack(S=H, sr=resampled_sr, n_fft=n_fft_features, hop_length=hop_length_features, fmin=20, fmax=resampled_sr / 2, threshold=0.1)

	for frame in range(S.shape[1]):
		valid = pitches[:, frame] > 0
		freqs = pitches[valid, frame]
		mags = magnitudes[valid, frame]
		# Sort by frequency
		order = np.argsort(freqs)
		frame_partials = []
		for freq, mag in zip(freqs[order], mags[order]):
			frame_partials.append((librosa.amplitude_to_db(mag), librosa.hz_to_midi(freq)))
		frame_partials.sort(reverse=True)
		for pidx, (db, midi) in enumerate(frame_partials):
			if pidx == partial_store_len: break
			partial_midis[frame,pidx] = midi
			partial_dbs[frame,pidx] = db
	feature_array[:, info_dict['librosad_columns']['partialfrq0']:info_dict['librosad_columns']['partialfrq0']+partial_store_len] = partial_midis
	feature_array[:, info_dict['librosad_columns']['partialdb0']:info_dict['librosad_columns']['partialdb0']+partial_store_len] = partial_dbs

	# MFCCs
	mel = librosa.feature.melspectrogram(S=S, sr=resampled_sr, n_fft=n_fft_features, n_mels=n_mels_for_mfccs, hop_length=hop_length_features)

	log_mel = librosa.power_to_db(mel, ref=np.max)

	# 14 mels as feature
	feature_array[:, info_dict['librosad_columns']['mel0']:info_dict['librosad_columns']['mel0']+n_mels_feature] = librosa.feature.melspectrogram(S=S, sr=resampled_sr, n_fft=n_fft_features, n_mels=n_mels_feature, hop_length=hop_length_features).T

	feature_array[:, info_dict['librosad_columns']['mfcc0']:info_dict['librosad_columns']['mfcc0']+n_mfcc] = librosa.feature.mfcc(S=log_mel, sr=resampled_sr, n_mfcc=n_mfcc).T

	# Chroma
	chroma_stft = librosa.feature.chroma_stft(S=S, sr=resampled_sr, tuning=0.0) # don't estimate tuning!
	
	feature_array[:, info_dict['librosad_columns']['chroma0']:info_dict['librosad_columns']['chroma0']+12] = chroma_stft.T
	# tonnetz
	feature_array[:, info_dict['librosad_columns']['tonnetz0']:info_dict['librosad_columns']['tonnetz0']+6] = librosa.feature.tonnetz(chroma=chroma_stft, sr=resampled_sr).T

	# Pitch descriptors
	# Fundamental frequency estimation
	f0, voiced_flag, voiced_probs = librosa.pyin(y, fmin=funda_min_hz, fmax=funda_max_hz, sr=resampled_sr, frame_length=n_fft_features, hop_length=hop_length_features)

	feature_array[:, info_dict['librosad_columns']['f0']] = np.nan_to_num(f0, nan=1.0).flatten()
	feature_array[:, info_dict['librosad_columns']['f0flag']] = voiced_flag.flatten()
	feature_array[:, info_dict['librosad_columns']['f0prob']] = voiced_probs.flatten()

	return feature_array, info_dict



