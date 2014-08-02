#!/usr/bin/env python
import sys, os, audioguide
defaultpath, libpath = audioguide.setup(os.path.dirname(__file__))
sys.path.append(libpath)
# import the rest of audioguide's submodules
from audioguide import sfSegment, concatenativeClasses, simcalc, userinterface, util, metrics, sdiflinkage
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
opspath = os.path.realpath(sys.argv[1])
if not os.path.exists(opspath):
	print('\nCouldn\'t find a soundfile called "%s"\n'%sys.argv[1])
	sys.exit(1)


ops = concatenativeClasses.parseOptions(defaults=defaultpath, scriptpath=os.path.dirname(__file__))

SdifInterface = sdiflinkage.SdifInterface(winLengthSec=ops.DESCRIPTOR_WIN_SIZE_SEC, hopLengthSec=ops.DESCRIPTOR_HOP_SIZE_SEC, resampleRate=ops.IRCAMDESCRIPTOR_RESAMPLE_RATE, windowType=ops.IRCAMDESCRIPTOR_WINDOW_TYPE, numbMfccs=ops.IRCAMDESCRIPTOR_NUMB_MFCCS, F0MaxAnalysisFreq=ops.IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ, F0MinFrequency=ops.IRCAMDESCRIPTOR_F0_MIN_FREQUENCY, F0MaxFrequency=ops.IRCAMDESCRIPTOR_F0_MAX_FREQUENCY, F0AmpThreshold=ops.IRCAMDESCRIPTOR_F0_AMP_THRESHOLD, F0Quality=ops.IRCAMDESCRIPTOR_F0_QUALITY, numbPeaks=ops.SUPERVP_NUMB_PEAKS, numbClust=ops.CLUSTERANAL_NUMB_CLUSTS, clustDescriptDict=ops.CLUSTERANAL_DESCRIPTOR_DIM, forceAnal=ops.DESCRIPTOR_FORCE_ANALYSIS, validSfExtensions=ops.SOUNDFILE_EXTENSIONS, searchPaths=ops.SEARCH_PATHS)

handle = sfSegment.SfSegment(sys.argv[1], None, None, SdifInterface.allDescriptors, SdifInterface)

print handle.desc.getdict()

# or you can same to a json dict:
#json.dump(handle.desc.getdict(), open('mydict.json'))
