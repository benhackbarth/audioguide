#!/usr/bin/env python
import sys, os, audioguide
defaultpath, libpath = audioguide.setup(os.path.dirname(__file__))
sys.path.append(libpath)
# import the rest of audioguide's submodules
from audioguide import sfSegment, concatenativeClasses, simcalc, userinterface, util, sdiflinkage
# import all other modules
import numpy as np
try:
	import json as json
except ImportError:
	import simplejson as json


#######################
## find options file ##
#######################
if len(sys.argv) == 1:
	print('\nPlease specify a soundfile as the first argument\n')
	sys.exit(1)
	
	
for file in sys.argv[1:]:

	opspath = os.path.realpath(file)
	if not os.path.exists(opspath):
		print('\nCouldn\'t find a soundfile called "%s"\n'%file)
		sys.exit(1)
	
	
	ops = concatenativeClasses.parseOptions(defaults=defaultpath, scriptpath=os.path.dirname(__file__))
	
	SdifInterface = sdiflinkage.SdifInterface(pm2_bin=ops.PM2_BIN, supervp_bin=ops.SUPERVP_BIN, userWinLengthSec=ops.DESCRIPTOR_WIN_SIZE_SEC, userHopLengthSec=ops.DESCRIPTOR_HOP_SIZE_SEC, resampleRate=ops.IRCAMDESCRIPTOR_RESAMPLE_RATE, windowType=ops.IRCAMDESCRIPTOR_WINDOW_TYPE, numbMfccs=ops.IRCAMDESCRIPTOR_NUMB_MFCCS, F0MaxAnalysisFreq=ops.IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ, F0MinFrequency=ops.IRCAMDESCRIPTOR_F0_MIN_FREQUENCY, F0MaxFrequency=ops.IRCAMDESCRIPTOR_F0_MAX_FREQUENCY, F0AmpThreshold=ops.IRCAMDESCRIPTOR_F0_AMP_THRESHOLD, F0Quality=ops.IRCAMDESCRIPTOR_F0_QUALITY, forceAnal=ops.DESCRIPTOR_FORCE_ANALYSIS, searchPaths=ops.SEARCH_PATHS)
	
	
	handle = sfSegment.SfSegment(file, None, None, SdifInterface.allDescriptors, SdifInterface)
	
	descriptorData = handle.desc.getdict()
	frame2second = SdifInterface.f2s(1)
	lengthOfData = len(descriptorData['f0'])
	distillRateSeconds = 0.2
	
	numberOfSlices = round(lengthOfData/float(distillRateSeconds/frame2second), 0)
	sliceSizeInFloatFrames = lengthOfData/numberOfSlices
	
	import matplotlib.pyplot as plt
	f = 0
	result = []
	while True:
		if f >= lengthOfData: break
		start = int(round(f, 0))
		end = min(int(round(f+sliceSizeInFloatFrames, 0)), lengthOfData)
		if end==start: break
		avgPitchHz = np.average(descriptorData['f0'][start:end], weights=descriptorData['power'][start:end])
		resultFrame = util.frq2Midi(avgPitchHz)
		print start, resultFrame
		result.append(resultFrame)
		f += sliceSizeInFloatFrames
	
	
	fig = plt.figure(figsize=(100, 10.))
	proot, pext = os.path.splitext(os.path.abspath(file))
	savepath = proot + '.png'
	plt.plot(range(int(numberOfSlices)), result, lw=1, label=['f0'])
	plt.savefig(savepath)
	plt.close()
	
	
	
	
	
	
	# or you can save to a json file:
	#json.dump(descriptorData, open('mydict.json'))
