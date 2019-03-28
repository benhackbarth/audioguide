############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################


# requires librosa, to install:
# python3 -m pip install --user librosa scipy

import os, json
import audioguide.util as util



def decomposeTargetSf(type, filename, startsec, endsec, n_streams, fftsize, hopsize):
	# create directory if needed
	descomposedir = os.path.join(os.path.dirname(__file__), 'data_decomposedtargets')
	if not os.path.exists(descomposedir): os.makedirs(descomposedir)


	assert type in ['NMF']

	checksum = util.listToCheckSum([filename, util.getTimeStamp(filename), n_streams, str(startsec), str(endsec), fftsize, hopsize])[:12]
	decomposedSoundfile = os.path.join(descomposedir, '%s-%s.wav'%(os.path.splitext(os.path.split(filename)[1])[0], checksum))
	decomposedJsonfile = os.path.join(descomposedir, '%s-%s.json'%(os.path.splitext(os.path.split(filename)[1])[0], checksum))
	
	if not os.path.exists(decomposedSoundfile):
		print("Decomposing %s into %i audio streams"%(filename, n_streams))
		dur = __NMF__(filename, startsec, endsec, n_streams, decomposedSoundfile, fftsize, hopsize)
		fh = open(decomposedJsonfile, 'w')
		json.dump({'duration': dur, 'path': filename, 'n_streams': n_streams, 'type': type, 'fftsize': fftsize, 'hopsize': hopsize}, fh)
		fh.close()
		print("Resulting file written to %s (%f sec)\n"%(decomposedSoundfile, dur*n_streams))
		return decomposedSoundfile, dur
	else:
		fh = open(decomposedJsonfile, 'r')
		dicty = json.load(fh)
		fh.close()
		print("Using target sound %s (%f sec)\n"%(decomposedSoundfile, dicty['duration']*n_streams))
		return decomposedSoundfile, dicty['duration']





def __NMF__(inputsoundfile, startsec, endsec, n_components, outputsoundfile, fftsize, hopsize, sparseDictLearn=False):
	'''non-negative matrix signal decomposition
	creates an output soundfile that is the length of the inputsoundfile * n_components'''

	import numpy, scipy, librosa
	
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
	#outputsamples2 = numpy.zeros(len(x))
	for n in range(n_components):
		Y = scipy.outer(W[:,n], H[n])*numpy.exp(1j*numpy.angle(S))
		y = librosa.istft(Y, hop_length=hopsize, win_length=fftsize)
		outputsamples[n*len(x):(n*len(x))+len(y)] = y
		#outputsamples2[:len(y)] += y
	librosa.output.write_wav(outputsoundfile, outputsamples, sr, norm=False)

	return len(x)/float(sr)
