#!/usr/bin/env python
############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os, random

from optparse import OptionParser
parser = OptionParser(usage="usage: %prog [options] soundfile")
parser.set_defaults(TRIGGER_THRESHOLD=-40)
parser.set_defaults(MINIMUM_DB_OFFSET_BOOST=+12)
parser.set_defaults(DB_OFFSET_ABSOLUTE=-60)
parser.set_defaults(OUTPUT_FILE='')
parser.set_defaults(SEGMENTATION_INFO='logic')
parser.set_defaults(GRAINLENGTH=0.1)
parser.set_defaults(GRAINHOP=0.05)
parser.add_option("-g", "--grainlength", action="store", dest="GRAINLENGTH", type="float", help="sets the length of generated grains in seconds.  All segments generated with agGranulate will be this length.  default=0.3")
parser.add_option("-o", "--grainoverlap", action="store", dest="GRAINHOP", type="float", help="sets the distance between sucessive grain overlaps in seconds.  If this value is 0.1 a new grain will begin every 0.1 seconds.  If -g is 0.3, the overlap of grains will be 3.  default=0.1")


parser.add_option("-t", "--triggerthreshold", action="store", dest="TRIGGER_THRESHOLD", type="float", help="set the threshold for detecting segment onsets.  a value from -100 to 0 where a lower value make onsets happen more frequently.  default=-40")
parser.add_option("-d", "--minoffsetdbboost", action="store", dest="MINIMUM_DB_OFFSET_BOOST", type="float", help="set the minimum-db-offset-boost.  this value in dB is added to the soundfile's minimum amplitude.  in an active segment, if a frame's amplitude is below this threshold, it causes a segment offset.  default=+12")
parser.add_option("-a", "--offsetabsolute", action="store", dest="DB_OFFSET_ABSOLUTE", type="float", help="set the minimum-db-offset-boost.  this value in dB is added to the soundfile's minimum amplitude.  in an active segment, if a frame's amplitude is below this threshold, it causes a segment offset.  default=-60")
parser.add_option("-f", "--file", action="store", dest="OUTPUT_FILE", type="str", help="set the name of the output file.  by default it is the soundfile name + '.txt'")
(options, args) = parser.parse_args()





###########################################
## LOAD OPTIONS AND SETUP SDIF-INTERFACE ##
###########################################
import audioguide
defaultpath, libpath = audioguide.setup(os.path.dirname(__file__))
sys.path.append(libpath)
# import the rest of audioguide's submodules
from audioguide import sfsegment, concatenativeclasses, userinterface, util, userclasses
# import all other modules
import numpy as np
import json
from audioguide.userclasses import TargetOptionsEntry as tsf
from audioguide.userclasses import SingleDescriptor as d

createdSegFiles = 0
for file in args:
	# test if its an audio file
	file = os.path.abspath(file)
	fileExtension = os.path.splitext(file)[1]
	isValidSoundfile = False
	for ext in ['.wav', '.aiff', '.aif', '.au']:
		if ext.lower() == fileExtension.lower():
			isValidSoundfile = True
			break
	if not isValidSoundfile:
		continue
	
	agopts = {
	'TARGET': eval("tsf('%s', thresh=%f, offsetRise=%f, offsetThreshAdd=%f, offsetThreshAbs=%f, minSegLen=%f, maxSegLen=%f)"%(file, options.TRIGGER_THRESHOLD, sys.maxsize, options.MINIMUM_DB_OFFSET_BOOST, options.DB_OFFSET_ABSOLUTE, options.GRAINLENGTH, sys.maxsize)),
	'VERBOSITY': 1,
	'HTML_LOG_FILEPATH': None,
	'CSOUND_CSD_FILEPATH': None,
	'CSOUND_RENDER_FILEPATH': None,
	'MIDI_FILEPATH': None,
	'LISP_OUTPUT_FILEPATH': None,
	'DICT_OUTPUT_FILEPATH': None,
	'TARGET_SEGMENT_LABELS_FILEPATH': None,
	'OUTPUT_LABEL_FILEPATH': None,
	'TARGET_DESCRIPTORS_FILEPATH': None,
	'TARGET_PLOT_DESCRIPTORS_FILEPATH': None,
	'SEGMENTATION_FILE_INFO': options.SEGMENTATION_INFO
	}

	ops = concatenativeclasses.parseOptions(optsDict=agopts, defaults=defaultpath, scriptpath=os.path.dirname(__file__))
	p = userinterface.printer(ops.VERBOSITY, os.path.dirname(__file__), "/tmp/agsegmentationlog.txt")
	p.printProgramInfo(audioguide.__version__, force=True)
	AnalInterface = ops.createAnalInterface(p)
	############
	## TARGET ##
	############
	p.middleprint('AUDIOGUIDE SEGMENT SOUNDFILE', force=True)
	filetosegment = sfsegment.target(ops.TARGET, AnalInterface)
	filetosegment.initAnal(AnalInterface, ops, p)
	minamp = util.ampToDb(min(filetosegment.whole.desc.get('power')))
	p.pprint("Evaluating %s from %.2f-%.2f"%(filetosegment.filename, filetosegment.whole.segmentStartSec, filetosegment.whole.segmentEndSec), colour="BOLD")

	if options.OUTPUT_FILE == '': segFile = file+'.txt'
	else: segFile = os.path.abspath(options.OUTPUT_FILE)
	
	grainLengthFrames = round(options.GRAINLENGTH/AnalInterface.f2s(1), 0)
	grainHopFrames = round(options.GRAINHOP/AnalInterface.f2s(1), 0)
	newSegmentationInOnsetFrames = []
	newExtraSegmentationData = []
	for sidx, (start, stop) in enumerate(filetosegment.segmentationInOnsetFrames):
		while stop-grainLengthFrames > start:
			newSegmentationInOnsetFrames.append( (start, start+grainLengthFrames) )
			newExtraSegmentationData.append(filetosegment.extraSegmentationData[sidx])
			start += grainHopFrames
	# overwrite old segmentation
	filetosegment.segmentationInOnsetFrames = newSegmentationInOnsetFrames
	filetosegment.extraSegmentationData = newExtraSegmentationData
	filetosegment.stageSegments(AnalInterface, ops, p)

	filetosegment.writeSegmentationFile(segFile)
	
	p.pprint("\nFound ${RED}"+str(len(filetosegment.segs))+"${NORMAL} segments", colour="NORMAL")
	print( "Wrote file %s\n"%(segFile) )
	createdSegFiles += 1
	
if (createdSegFiles == 0):
	print("\n\nError: I didn't create any segmentation textfiles because you didn't give me any soundfiles in your input arguments!  You wrote: %s\n\n"%(' '.join(sys.argv)))
