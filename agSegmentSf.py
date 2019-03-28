#!/usr/bin/env python
############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os, random

from optparse import OptionParser
parser = OptionParser(usage="usage: %prog [options] soundfile")
parser.set_defaults(TRIGGER_THRESHOLD=-40)
parser.set_defaults(RISERATIO=1.3)
parser.set_defaults(MULTIRISE=False)
parser.set_defaults(MINIMUM_DB_OFFSET_BOOST=+12)
parser.set_defaults(DB_OFFSET_ABSOLUTE=-80)
parser.set_defaults(MINIMUM_SEG=0.1)
parser.set_defaults(MAXIMUM_SEG=1000)
parser.set_defaults(SEGMENTATION_INFO='logic')
parser.set_defaults(OUTPUT_FILE='')
parser.add_option("-t", "--triggerthreshold", action="store", dest="TRIGGER_THRESHOLD", type="float", help="set the threshold for detecting segment onsets.  a value from -100 to 0 where a lower value make onsets happen more frequently.  default=-40")
parser.add_option("-r", "--riseratio", action="store", dest="RISERATIO", type="float", help="set the rise-ratio used in determining segment offsets.  the rise-ratio is the ratio of a frame's amplitude to the next frame's amplitude.  in an active segment, if this ratio is greater than user-supplied rise-ratio, it will cause an offset.  it must be greater than 1.  default=1.3")
parser.add_option("-m", "--multirise", action="store_true", dest="MULTIRISE", help="If True, corpus soundfile segmentation will be done in several passes where the rise ratio will vary from -20% to +20% of the user supplied riseratio.  This results in more segments which will likely overlap each other at times.  A good optipon to use for long corpus files.")
parser.add_option("-d", "--minoffsetdbboost", action="store", dest="MINIMUM_DB_OFFSET_BOOST", type="float", help="set the minimum-db-offset-boost.  this value in dB is added to the soundfile's minimum amplitude.  in an active segment, if a frame's amplitude is below this threshold, it causes a segment offset.  default=+12")
parser.add_option("-a", "--offsetabsolute", action="store", dest="DB_OFFSET_ABSOLUTE", type="float", help="set the minimum-db-offset-boost.  this value in dB is added to the soundfile's minimum amplitude.  in an active segment, if a frame's amplitude is below this threshold, it causes a segment offset.  default=-80")
parser.add_option("-s", "--minimum", action="store", dest="MINIMUM_SEG", type="float", help="set the minimum segment length in seconds.  segments will be forced to be this duration in seconds or greater.  default=0.1")
parser.add_option("-l", "--maximum", action="store", dest="MAXIMUM_SEG", type="float", help="set the maximum segment length in seconds.  segments will be forced to be this duration in seconds or shorter.  default=1000")
parser.add_option("-f", "--file", action="store", dest="OUTPUT_FILE", type="str", help="set the name of the output file.  by default it is the soundfile name + '.txt'")
parser.add_option("-p", "--plot", action="store_true", dest="PLOT_OUTPUT", default=False, help="If added, this flag will create a plot of this file's segmentation saved to the file name plus '.jpg'")
parser.add_option("-i", "--info", action="store", dest="SEGMENTATION_INFO", default='logic', help="If logic, will add some info to the segmentation file about segmentation.  If a segmented descriptor name, will add that for each segment")
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

	if options.PLOT_OUTPUT:
		plotMe = file+'.jpg'
	else:
		plotMe = None
		
	agopts = {
	'TARGET': eval("tsf('%s', thresh=%f, offsetRise=%f, offsetThreshAdd=%f, offsetThreshAbs=%f, minSegLen=%f, maxSegLen=%f, multiriseBool=%s)"%(file, options.TRIGGER_THRESHOLD, options.RISERATIO, options.MINIMUM_DB_OFFSET_BOOST, options.DB_OFFSET_ABSOLUTE, options.MINIMUM_SEG, options.MAXIMUM_SEG, options.MULTIRISE)),
	'VERBOSITY': 1,
	'HTML_LOG_FILEPATH': None,
	'CSOUND_CSD_FILEPATH': None,
	'CSOUND_RENDER_FILEPATH': None,
	'MIDI_FILEPATH': None,
	'LISP_OUTPUT_FILEPATH': None,
	'DICT_OUTPUT_FILEPATH': None,
	'DICT_OUTPUT_FILEPATH': None,
	'TARGET_SEGMENT_LABELS_FILEPATH': None,
	'OUTPUT_LABEL_FILEPATH': None,
	'TARGET_DESCRIPTORS_FILEPATH': None,
	'TARGET_PLOT_DESCRIPTORS_FILEPATH': None,
	'TARGET_SEGMENTATION_GRAPH_FILEPATH': plotMe,
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
	filetosegment.stageSegments(AnalInterface, ops, p)

	minamp = util.ampToDb(min(filetosegment.whole.desc['power']))
	p.pprint("Evaluating %s from %.2f-%.2f"%(filetosegment.filename, filetosegment.whole.segmentStartSec, filetosegment.whole.segmentEndSec), colour="BOLD")
	p.pprint("\nAN ONSET HAPPENS when", colour="BOLD")
	p.pprint("The amplitude crosses the Relative Onset Trigger Threshold: ${YELLOW}"+"%.2f"%options.TRIGGER_THRESHOLD+" ${NORMAL}(-t option)\n", colour="NORMAL")
	p.pprint("\nAN OFFSET HAPPENS when", colour="BOLD")
	p.pprint("1. Offset Rise Ratio: when next-frame's-amplitude/this-frame's-amplitude >= ${YELLOW}"+"%.2f"%options.RISERATIO+" ${NORMAL}(-r option)", colour="NORMAL")
	p.pprint("\t...or...", colour="BOLD")
	p.pprint("2. Offset dB above minimum: when this frame's absolute amplitude <= "+"%.2f"%util.ampToDb(filetosegment.powerOffsetValue)+" (minimum found amplitude of "+"%.2f"%minamp+" plus the offset dB boost of ${YELLOW}"+"%.2f"%options.MINIMUM_DB_OFFSET_BOOST+"${NORMAL} (-d option))\n", colour="NORMAL")
	if options.OUTPUT_FILE == '': segFile = file+'.txt'
	else: segFile = os.path.abspath(options.OUTPUT_FILE)
	filetosegment.writeSegmentationFile(segFile)
	p.pprint("\nFound ${RED}"+str(len(filetosegment.segs))+"${NORMAL} segments", colour="NORMAL")
	print( "Wrote file %s\n"%(segFile) )
	createdSegFiles += 1
	
if (createdSegFiles == 0):
	print("\n\nError: I didn't create any segmentation textfiles because you didn't give me any soundfiles in your input arguments!  You wrote: %s\n\n"%(' '.join(sys.argv)))
