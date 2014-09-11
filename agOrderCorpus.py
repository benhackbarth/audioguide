#!/usr/bin/env python
import sys, os, audioguide
defaultpath, libpath = audioguide.setup(os.path.dirname(__file__))
sys.path.append(libpath)
from audioguide import sfSegment, concatenativeClasses, simcalc, userinterface, util, csoundinterface, sdiflinkage
from UserClasses import CorpusOptionsEntry as csf


#####################
## START USER VARS ##
#####################

# here you list the corpus you want ordered.  the CORPUS variable is a list of csf() objects, just like in concatenation options files.
CORPUS = [
csf('examples/lachenmann.aiff'),
csf('examples/heat sink.aiff'),
csf('examples/dream.aiff'),
]

# here you select which escriptor to order the sounds.  averaged (-seg) descriptors only
ORDER_CORPUS_BY_DESCRIPTOR = 'zeroCross-seg'

# here is where the csd csound file will go...
ORDER_CORPUS_BY_DESCRIPTOR_CSDFILE = 'output/orderedcorpus.csd'

# here is where the rendered soundfile will go...
ORDER_CORPUS_BY_DESCRIPTOR_SOUNDFILE = 'output/orderedcorpus.aiff'

###################
## END USER VARS ##
###################





ops = concatenativeClasses.parseOptions(optsDict={'CORPUS': CORPUS, 'ORDER_CORPUS_BY_DESCRIPTOR': ORDER_CORPUS_BY_DESCRIPTOR}, defaults=defaultpath, scriptpath=os.path.dirname(__file__))
p = userinterface.printer(ops.VERBOSITY, os.path.dirname(__file__), ops.LOG_FILEPATH)
SdifInterface = ops.createSdifInterface(p)
p.middleprint('AUDIOGUIDE ORDER CORPUS SOUNDS BY DESCRIPTOR')

cps = concatenativeClasses.corpus(ops.CORPUS, ops.CORPUS_GLOBAL_ATTRIBUTES, SdifInterface, p)

assert ops.ORDER_CORPUS_BY_DESCRIPTOR.find('-seg') != -1 # must be an averaged descriptor!

ordered = []
for handle in cps.postLimitSegmentNormList:
	ordered.append( (handle.desc[ops.ORDER_CORPUS_BY_DESCRIPTOR].get(0, None), handle) )
ordered.sort()


csdScoreText = ''
timekeeper = 0.
for cidx, (value, handle) in enumerate(ordered):
	print "%s@%.2f-%.2f - %s == %.3f"%(handle.printName, handle.segmentStartSec, handle.segmentEndSec, ops.ORDER_CORPUS_BY_DESCRIPTOR, value)
	csdScoreText += 'i2  %f  %f  "%s"  %f\n'%(timekeeper, handle.segmentDurationSec, handle.filename, handle.segmentStartSec)
	timekeeper += handle.segmentDurationSec+0.25



outputCsdPath = os.path.splitext(ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH)[0]+'.csd'
csoundinterface.makeSimpleCsdFile(outputCsdPath, ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH, ops.CSOUND_SR, ops.CSOUND_KR, csdScoreText)


print ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH, len(ordered)
csoundinterface.render(ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH, len(ordered))

print ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH

if ops.CSOUND_PLAY_RENDERED_FILE:
	csoundinterface.playFile( ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH )
		
	