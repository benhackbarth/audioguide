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
if len(sys.argv) < 3:
	print('\nPlease specify a soundfile as the first argument, and a json dict to create as a second argument\n')
	sys.exit(1)
	
	

file = os.path.realpath(sys.argv[1])
outputfile = os.path.realpath(sys.argv[2])
if not os.path.exists(file):
	print('\nCouldn\'t find a soundfile called "%s"\n'%file)
	sys.exit(1)

# setup analysis parameters
ops = concatenativeClasses.parseOptions(defaults=defaultpath, scriptpath=os.path.dirname(__file__))
SdifInterface = sdiflinkage.SdifInterface(pm2_bin=ops.PM2_BIN, supervp_bin=ops.SUPERVP_BIN, userWinLengthSec=ops.DESCRIPTOR_WIN_SIZE_SEC, userHopLengthSec=ops.DESCRIPTOR_HOP_SIZE_SEC, resampleRate=ops.IRCAMDESCRIPTOR_RESAMPLE_RATE, windowType=ops.IRCAMDESCRIPTOR_WINDOW_TYPE, numbMfccs=ops.IRCAMDESCRIPTOR_NUMB_MFCCS, F0MaxAnalysisFreq=ops.IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ, F0MinFrequency=ops.IRCAMDESCRIPTOR_F0_MIN_FREQUENCY, F0MaxFrequency=ops.IRCAMDESCRIPTOR_F0_MAX_FREQUENCY, F0AmpThreshold=ops.IRCAMDESCRIPTOR_F0_AMP_THRESHOLD, F0Quality=ops.IRCAMDESCRIPTOR_F0_QUALITY, forceAnal=ops.DESCRIPTOR_FORCE_ANALYSIS, searchPaths=ops.SEARCH_PATHS)

# load soundfile
handle = sfSegment.SfSegment(file, None, None, SdifInterface.allDescriptors, SdifInterface)

descriptorData = handle.desc.getdict()
descriptorData['f2s'] = SdifInterface.f2s(1)
fh = open(outputfile, 'w')
json.dump(descriptorData, fh)
fh.close()