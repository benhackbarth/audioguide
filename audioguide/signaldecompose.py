############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################


# requires librosa, to install:
# python3 -m pip install --user librosa scipy

import os, json
import audioguide.util as util



def decomposeTargetSf(filename, startsec, endsec, params):
	# create directory if needed
	descomposedir = os.path.join(os.path.dirname(__file__), 'data_decomposedtargets')
	if not os.path.exists(descomposedir): os.makedirs(descomposedir)

	assert 'type' in params and params['type'] in ['NMF', 'HPSS']

	checksum = util.listToCheckSum([filename, util.getTimeStamp(filename), str(startsec), str(endsec)] + list(params.values()))[:12]
	filehead = '%s-%s-%s'%(os.path.splitext(os.path.split(filename)[1])[0], params['type'], checksum)
	decomposedSoundfile = os.path.join(descomposedir, filehead+'.wav')
	decomposedJsonfile = os.path.join(descomposedir, filehead+'.json')
	
	if not os.path.exists(decomposedSoundfile):
		if params['type'] == 'NMF':
			dur = __NMF__(filename, startsec, endsec, params['streams'], decomposedSoundfile, params['fftsize'], params['hopsize'])
		if params['type'] == 'HPSS':
			dur = __HPSS__(filename, startsec, endsec, decomposedSoundfile, params['fftsize'], params['hopsize'])

		fh = open(decomposedJsonfile, 'w')
		data = {'duration': dur, 'path': filename}
		data.update(params)
		json.dump(data, fh)
		fh.close()
		print("Resulting file written to %s (%f sec)\n"%(decomposedSoundfile, data['duration']))
		return decomposedSoundfile, dur
	else:
		fh = open(decomposedJsonfile, 'r')
		data = json.load(fh)
		fh.close()
		print("Using target sound %s (%f sec)\n"%(decomposedSoundfile, data['duration']))
		return decomposedSoundfile, data['duration']






def __HPSS__(inputsoundfile, startsec, endsec, outputsoundfile, fftsize, hopsize):
	'''pitch/noise separation
		creates an output soundfile that is the length of the inputsoundfile * 2'''
	import numpy, scipy, librosa
	import soundfile as sf
	print("Decomposing %s into pitch/noise audio streams"%(inputsoundfile))
	if endsec == None: durationsec = None
	else: durationsec = endsec-startsec
	x, sr = librosa.load(inputsoundfile, offset=startsec, duration=durationsec, sr=None)
	x_harmonic, x_percussive = librosa.effects.hpss(x)
	outputsamples = numpy.append(x_harmonic, x_percussive)
	#librosa.output.write_wav(outputsoundfile, outputsamples, sr, norm=False)
	# Write out audio as 24bit PCM WAV
	sf.write(outputsoundfile, outputsamples, sr)
	return len(x)/float(sr)






def __NMF__(inputsoundfile, startsec, endsec, n_components, outputsoundfile, fftsize, hopsize, sparseDictLearn=False):
	'''non-negative matrix signal decomposition
	creates an output soundfile that is the length of the inputsoundfile * n_components'''
	import numpy, scipy, librosa
	import soundfile as sf
	print("Decomposing %s into %i audio streams"%(inputsoundfile, n_components))
	
	# To preserve the native sampling rate of the file, use sr=None
	if endsec == None: durationsec = None
	else: durationsec = endsec-startsec
	
	x, sr = librosa.load(inputsoundfile, offset=startsec, duration=durationsec, sr=None)
	S = librosa.stft(x, n_fft=fftsize, hop_length=hopsize, win_length=fftsize)
	X = numpy.absolute(S) # use spectral magnitudes, not complex spectrum
	
	if sparseDictLearn:
		import sklearn
		T = sklearn.decomposition.MiniBatchDictionaryLearning(n_components=n_components)
		W, H = librosa.decompose.decompose(X, transformer=T, sort=True)
	else:
		W, H = librosa.decompose.decompose(X, n_components=n_components, sort=True)
	
	# ifft for each decomposed signals, write to disk
	outputsamples = numpy.zeros(len(x)*n_components)
	for n in range(n_components):
		Y = scipy.outer(W[:,n], H[n])*numpy.exp(1j*numpy.angle(S))
		y = librosa.istft(Y, hop_length=hopsize, win_length=fftsize)
		outputsamples[n*len(x):(n*len(x))+len(y)] = y
	#librosa.output.write_wav(outputsoundfile, outputsamples, sr, norm=False)
	sf.write(outputsoundfile, outputsamples, sr)
	return len(x)/float(sr)


