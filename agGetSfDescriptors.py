#!/usr/bin/env python
############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os, json, audioguide
defaultpath, libpath = audioguide.setup(os.path.dirname(__file__))
sys.path.append(libpath)
# import other audioguide submodules
from audioguide import sfsegment, concatenativeclasses, anallinkage


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
ops = concatenativeclasses.parseOptions(defaults=defaultpath, scriptpath=os.path.dirname(__file__))
AnalInterface = anallinkage.AnalInterface(pm2_bin=ops.PM2_BIN, supervp_bin=ops.SUPERVP_BIN, userWinLengthSec=ops.DESCRIPTOR_WIN_SIZE_SEC, userHopLengthSec=ops.DESCRIPTOR_HOP_SIZE_SEC, resampleRate=ops.IRCAMDESCRIPTOR_RESAMPLE_RATE, windowType=ops.IRCAMDESCRIPTOR_WINDOW_TYPE, F0MaxAnalysisFreq=ops.IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ, F0MinFrequency=ops.IRCAMDESCRIPTOR_F0_MIN_FREQUENCY, F0MaxFrequency=ops.IRCAMDESCRIPTOR_F0_MAX_FREQUENCY, F0AmpThreshold=ops.IRCAMDESCRIPTOR_F0_AMP_THRESHOLD, forceAnal=ops.DESCRIPTOR_FORCE_ANALYSIS, searchPaths=ops.SEARCH_PATHS)

# load soundfile
handle = sfsegment.sfsegment(file, None, None, AnalInterface.allDescriptors, AnalInterface)
handle.midiPitchMethod = 'f0-seg'


descriptorData = handle.desc.getdict()
descriptorData['f2s'] = AnalInterface.f2s(1)
fh = open(outputfile, 'w')
json.dump(descriptorData, fh)
fh.close()