#!/usr/bin/env python
import sys, os, random

from optparse import OptionParser
parser = OptionParser(usage="usage: %prog [options] soundfile")
parser.set_defaults(TRIGGER_THRESHOLD=-40)
parser.set_defaults(RISERATIO=1.3)
parser.set_defaults(MINIMUM_DB_OFFSET_BOOST=+12)
parser.set_defaults(MINIMUM_SEG=0.1)
parser.set_defaults(MAXIMUM_SEG=1000)
parser.set_defaults(OUTPUT_FILE='')
parser.add_option("-t", "--triggerthreshold", action="store", dest="TRIGGER_THRESHOLD", type="float", help="set the threshold for detecting segment onsets.  a value from -100 to 0 where a lower value make onsets happen more frequently.  default=-40")
parser.add_option("-r", "--riseratio", action="store", dest="RISERATIO", type="float", help="set the rise-ratio used in determining segment offsets.  the rise-ratio is the ratio of a frame's amplitude to the next frame's amplitude.  in an active segment, if the observed ratio is greater than user-supplied rise-ratio, it will cause an offset.  it must be greater than 1.  default=1.3")
parser.add_option("-d", "--minoffsetdbboost", action="store", dest="MINIMUM_DB_OFFSET_BOOST", type="float", help="set the minimum-db-offset-boost.  this value in dB is added to the soundfile's minimum amplitude.  in an active segment, if a frame's amplitude is below this threshold, it causes a segment offset.  default=+12")
parser.add_option("-s", "--minimum", action="store", dest="MINIMUM_SEG", type="float", help="set the minimum segment length in seconds.  segments will be forced to be this duration in seconds or greater.  default=0.1")
parser.add_option("-l", "--maximum", action="store", dest="MAXIMUM_SEG", type="float", help="set the maximum segment length in seconds.  segments will be forced to be this duration in seconds or shorter.  default=1000")
parser.add_option("-f", "--file", action="store", dest="OUTPUT_FILE", type="str", help="set the name of the output file.  by default it is the soundfile name + '.txt'")
parser.add_option("-p", "--plot", action="store_true", dest="PLOT_OUTPUT", default=False, help="If added, this flag will create a plot of this file's segmentation saved to output/corpussegmentation.jpg")
(options, args) = parser.parse_args()


TARGET_SEGMENTATION_GRAPH_FILEPATH = None #'output/targetlabels.jpg'



###########################################
## LOAD OPTIONS AND SETUP SDIF-INTERFACE ##
###########################################
import audioguide
defaultpath, libpath = audioguide.setup(os.path.dirname(__file__))
sys.path.append(libpath)
# import the rest of audioguide's submodules
from audioguide import sfSegment, concatenativeClasses, userinterface, util, sdiflinkage
# import all other modules
import numpy as np
try:
	import json as json
except ImportError:
	import simplejson as json
from UserClasses import TargetOptionsEntry as tsf
from UserClasses import SingleDescriptor as d


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
		plotMe = 'output/corpussegmentation.jpg'
	else:
		plotMe = None
		
	agopts = {
	'TARGET': eval("tsf('%s', thresh=%f, offsetRise=%f, offsetThreshAdd=%f, minSegLen=%f, maxSegLen=%f)"%(file, options.TRIGGER_THRESHOLD, options.RISERATIO, options.MINIMUM_DB_OFFSET_BOOST, options.MINIMUM_SEG, options.MAXIMUM_SEG)),
	'VERBOSITY': 0,
	'TARGET_SEGMENT_OFFSET_DB_ABS_THRESH': -200.0,

	'LOG_FILEPATH': None,
	'CSOUND_CSD_FILEPATH': None,
	'CSOUND_RENDER_FILEPATH': None,
	'MIDI_FILEPATH': None,
	'LISP_OUTPUT_FILEPATH': None,
	'DICT_OUTPUT_FILEPATH': None,
	'ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH': None,
	'DICT_OUTPUT_FILEPATH': None,
	'TARGET_SEGMENT_LABELS_FILEPATH': None,
	'SUPERIMPOSITION_LABEL_FILEPATH': None,
	'TARGET_DESCRIPTORS_FILEPATH': None,
	'TARGET_PLOT_DESCRIPTORS_FILEPATH': None,
	'TARGET_SEGMENTATION_GRAPH_FILEPATH': plotMe
	
	}


	ops = concatenativeClasses.parseOptions(optsDict=agopts, defaults=defaultpath, scriptpath=os.path.dirname(__file__))
	p = userinterface.printer(ops.VERBOSITY, os.path.dirname(__file__), "/tmp/agsegmentationlog.txt")
	p.printProgramInfo(audioguide.__version__, force=True)
	SdifInterface = ops.createSdifInterface(p)
	############
	## TARGET ##
	############
	p.middleprint('AUDIOGUIDE SEGMENT SOUNDFILE', force=True)
	filetosegment = sfSegment.target(ops.TARGET)
	filetosegment.initAnal(SdifInterface, ops, p)
	minamp = util.ampToDb(min(filetosegment.whole.desc['power']))
	
	p.pprint("%s"%filetosegment.filename)
	p.pprint("\nAN ONSET HAPPENS when", colour="BOLD")
	print("The amplitude crosses the Relative Onset Trigger Threshold: %.2f\n"%(options.TRIGGER_THRESHOLD))
	
	#print("\tpeak amplitude (absolute): %.2f"%util.ampToDb(max(filetosegment.whole.desc['power'])))
	#print("\tminimum amplitude (absolute): %.2f"%minamp)
	p.pprint("\nAN OFFSET HAPPENS when", colour="BOLD")
	print("1. Offset Rise Ratio: when next-frame's-amplitude/this-frame's-amplitude >= %.2f"%(options.RISERATIO))
	print("...or...")
	print("2. Offset dB above minimum: when this frame's absolute amplitude <= %.2f (minimum found amplitude of %.2f plus the offset dB boost of %.2f)\n"%(util.ampToDb(filetosegment.powerOffsetValue), minamp, options.MINIMUM_DB_OFFSET_BOOST))
	
	if options.OUTPUT_FILE == '':
		segFile = file+'.txt'
	else:
		segFile = os.path.abspath(options.OUTPUT_FILE)
	filetosegment.writeSegmentationFile(segFile)
	print( "\nFound %i segments"%(len(filetosegment.segs)) )
	print( "Wrote file %s\n"%(segFile) )
