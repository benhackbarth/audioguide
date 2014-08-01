#!/usr/bin/env python
import sys, os, audioguide
defaultpath, libpath = audioguide.setup(os.path.dirname(__file__))
sys.path.append(libpath)
# import the rest of audioguide's submodules
from audioguide import sfSegment, concatenativeClasses, simcalc, userinterface, util, csoundInterface, sdiflinkage
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
	print('\nPlease specify an options file as the first argument (an example can be found in examples/08-corpusOrdering.py)\n')
	sys.exit(1)
opspath = os.path.realpath(sys.argv[1])
if not os.path.exists(opspath):
	print('\nCouldn\'t find an options called "%s"\n'%sys.argv[1])
	sys.exit(1)


###########################################
## LOAD OPTIONS AND SETUP SDIF-INTERFACE ##
###########################################
ops = concatenativeClasses.parseOptions(opsfile=opspath, defaults=defaultpath, scriptpath=os.path.dirname(__file__))
p = userinterface.printer(ops.VERBOSITY, os.path.dirname(__file__), ops.LOG_FILEPATH)
SdifInterface = ops.createSdifInterface(p)

cps = concatenativeClasses.corpus(ops.CORPUS, ops.CORPUS_GLOBAL_ATTRIBUTES, SdifInterface, p)
cps.evaluatePreConcateLimitations()

assert ops.ORDER_CORPUS_BY_DESCRIPTOR.find('-seg') != -1 # must be an averaged descriptor!
ordered = []
for handle in cps.postLimitSegmentNormList:
	ordered.append( (handle.desc[ops.ORDER_CORPUS_BY_DESCRIPTOR].get(0, None), handle) )
ordered.sort()

csdScoreText = ''
timekeeper = 0.
for value, handle in ordered:
	print "%s@%.2f-%.2f - %s == %.3f"%(handle.printName, handle.segmentStartSec, handle.segmentEndSec, ops.ORDER_CORPUS_BY_DESCRIPTOR, value)
	csdScoreText += 'i2  %f  %f  "%s"  %f\n'%(timekeeper, handle.segmentDurationSec, handle.filename, handle.segmentStartSec)
	timekeeper += handle.segmentDurationSec+0.2

outputCsdPath = os.path.splitext(ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH)[0]+'.csd'
csoundInterface.makeConcatenationCsdFile(outputCsdPath, ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH, None, ops.CSOUND_SR, ops.CSOUND_KR, csdScoreText, 0)

csoundInterface.render(ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH, len(ordered))

if ops.CSOUND_RENDER_FILEPATH != None and ops.CSOUND_PLAY_RENDERED_FILE:
	csoundInterface.playFile( ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH, ops.CSOUND_PLAYERS )
		
	