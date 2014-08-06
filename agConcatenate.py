#!/usr/bin/env python
import sys, os, audioguide
defaultpath, libpath = audioguide.setup(os.path.dirname(__file__))
sys.path.append(libpath)
# import the rest of audioguide's submodules
from audioguide import sfSegment, concatenativeClasses, simcalc, userinterface, util, descriptordata, sdiflinkage
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
	print('\nPlease specify an options file as the first argument\n')
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
p.printProgramInfo(audioguide.__version__)
SdifInterface = ops.createSdifInterface(p)
p.middleprint('CONCATENATE SOUNDFILE')


############
## TARGET ##
############
p.logsection( "TARGET" )
tgt = sfSegment.target(ops.TARGET)
tgt.initAnal(SdifInterface, ops, p)

############
## CORPUS ##
############
p.logsection( "CORPUS" )
cps = concatenativeClasses.corpus(ops.CORPUS, ops.CORPUS_GLOBAL_ATTRIBUTES, SdifInterface, p)

###################
## NORMALIZATION ##
###################
p.logsection( "NORMALISATION" )
for dobj in SdifInterface.normalizeDescriptors:
	if dobj.norm == 1:
		# normalize both together
		allsegs = tgt.segs + cps.postLimitSegmentNormList
		tgtStatistics = cpsStatistics = sfSegment.getDescriptorStatistics(allsegs, dobj)
		sfSegment.applyDescriptorNormalisation(allsegs, dobj, tgtStatistics)
	elif dobj.norm == 2:
		# normalize target
		tgtStatistics = sfSegment.getDescriptorStatistics(tgt.segs, dobj)
		sfSegment.applyDescriptorNormalisation(tgt.segs, dobj, tgtStatistics)
		# normalize corpus
		cpsStatistics = sfSegment.getDescriptorStatistics(cps.postLimitSegmentNormList, dobj)
		sfSegment.applyDescriptorNormalisation(cps.postLimitSegmentNormList, dobj, cpsStatistics)
	p.log( "%s (%i):"%(dobj.name, dobj.norm) )
	p.log( "\ttarget: mean=%.2f  std=%.2f  corpus: mean=%.2f  std=%.2f"%(tgtStatistics['mean'], tgtStatistics['stddev'], cpsStatistics['mean'], cpsStatistics['stddev']) )
	
##############################
## initialise concatenation ##
##############################
p.logsection( "CONCATENATION" )
tgt.setupConcate(SdifInterface)
distanceCalculations = simcalc.distanceCalculations(ops.SUPERIMPOSE, ops.RANDOM_SEED, SdifInterface, p)
#p.barOpen('Concatenating Based on %s'%ops.SUPERIMPOSE.searchOrder, len(tgt.segFrames)+1)
superimp = concatenativeClasses.SuperimposeTracker(tgt.lengthInFrames, len(tgt.segs), ops.SUPERIMPOSE.overlapAmpThresh, ops.SUPERIMPOSE.peakAlign, ops.SUPERIMPOSE.peakAlignEnvelope, len(ops.CORPUS), p)
cps.setupCorpusConcatenationLimitations(tgt, SdifInterface)
outputEvents = []

#######################################
### sort segments by power if needed ##
#######################################
if ops.SUPERIMPOSE.searchOrder == 'power':
	import operator
	tgt.segs = sorted(tgt.segs, key=operator.attrgetter("power"), reverse=True)

#########################
## TARGET SEGMENT LOOP ##
#########################
p.startPercentageBar(upperLabel="CONCATINATING", total=len(tgt.segs)+1)
for segidx, tgtseg in enumerate(tgt.segs):
	segSeek = 0
	p.percentageBarNext()
	while True:
		##############################################################
		## check to see if we are done with this particular segment ##
		##############################################################
		if segSeek >= tgtseg.lengthInFrames: break 
		########################################
		## run selection superimposition test ##
		########################################
		tif = tgtseg.segmentStartFrame + segSeek
		timeInSec = SdifInterface.f2s(tif)
		tgtsegdur =  tgtseg.segmentDurationSec - SdifInterface.f2s(segSeek)
		segidxt = superimp.test('segidx', segidx, ops.SUPERIMPOSE.minSegment, ops.SUPERIMPOSE.maxSegment)
		overt = superimp.test('overlap', tif, ops.SUPERIMPOSE.minOverlap, ops.SUPERIMPOSE.maxOverlap)
		onsett = superimp.test('onset', tif, ops.SUPERIMPOSE.minOnset, ops.SUPERIMPOSE.maxOnset)
		trigVal = tgtseg.thresholdTest(segSeek, ops.TARGET_ONSET_DESCRIPTORS)
		trig = trigVal >= tgt.segmentationThresh
		####################################################
		# skip selecting if some criteria doesn't match!!! #
		####################################################
		if 'notok' in [onsett, overt, segidxt]:
			if segidxt == 'notok':
				superimp.skip('maximum selections this segment', superimp.cnt['segidx'][segidx], timeInSec)
			if onsett == 'notok':
				superimp.skip('maximum onsets at this time', superimp.cnt['onset'][tif], timeInSec)
			if overt == 'notok':
				superimp.skip('maximum overlapping selections', superimp.cnt['overlap'][tif], timeInSec)
			segSeek += ops.SUPERIMPOSE.incr
			continue # next frame
		##############################################################
		## see if a selection should be forced without thresholding ##
		##############################################################
		if 'force' not in [onsett, overt, segidxt]: # test for amplitude threshold
			if not trig:
				superimp.skip('target too soft', trigVal, timeInSec)
				segSeek += ops.SUPERIMPOSE.incr
				continue # not loud enough, next frame
		##############################
		## get valid corpus handles ##
		##############################
		validSegments = cps.evaluateValidSamples(tif, timeInSec, ops.ROTATE_VOICES, ops.VOICE_PATTERN, superimp)
		if len(validSegments) == 0:
			superimp.skip('no corpus sounds made it past restrictions and limitations', None, timeInSec)
			segSeek += ops.SUPERIMPOSE.incr
			continue		
		distanceCalculations.setCorpus(validSegments)
		################################################
		## search and see if we find a winning sample ##
		################################################
		returnBool = distanceCalculations.executeSearch(tgtseg, segSeek, ops.SEARCH, ops.SUPERIMPOSE, ops.RANDOMIZE_AMPLITUDE_FOR_SIM_SELECTION)
		if not returnBool: # nothing valid, so skip to new frame...
			superimp.skip('no corpus sounds made it through the search passes', None, timeInSec)
			segSeek += ops.SUPERIMPOSE.incr
			continue
		###################################################
		## if passing this point, picking a corpus sound ##
		###################################################
		superimp.pick(trig, trigVal, onsett, overt, segidxt, timeInSec)
		selectCpsseg = distanceCalculations.returnSearch()
		######################################
		## MODIFY CHOSEN SAMPLES AMPLITUDE? ##
		######################################
		minLen = min(tgtseg.lengthInFrames-segSeek, selectCpsseg.lengthInFrames)		
		if selectCpsseg.postSelectAmpBool:
			if selectCpsseg.postSelectAmpMethod == "lstsqr":
				try:
					leastSqrWholeLine = (np.linalg.lstsq(np.vstack([selectCpsseg.desc['power'][:minLen]]).T, np.vstack([tgtseg.desc['power'][:minLen]]).T)[0][0][0])
				except np.linalg.linalg.LinAlgError: # in case of incompatible dimensions
					leastSqrWholeLine = 0
					pass
			elif selectCpsseg.postSelectAmpMethod in ["power-seg", "power-mean-seg"]:
				tgtPower = tgtseg.desc[selectCpsseg.postSelectAmpMethod].get(segSeek, None)
				cpsPower = selectCpsseg.desc[selectCpsseg.postSelectAmpMethod].get(0, None)
				sourceAmpScale = tgtPower/cpsPower			
			###################
			## fit to limits ##
			###################
			if sourceAmpScale < util.dbToAmp(selectCpsseg.postSelectAmpMin):
				sourceAmpScale = util.dbToAmp(selectCpsseg.postSelectAmpMin)
			elif sourceAmpScale > util.dbToAmp(selectCpsseg.postSelectAmpMax):
				sourceAmpScale = util.dbToAmp(selectCpsseg.postSelectAmpMax)
		else: # nothing
			sourceAmpScale = 1
		# apply amp scaling
		sourceAmpScale *= util.dbToAmp(ops.OUTPUT_GAIN_DB)
		###################$###########################
		## subtract power and update onset detection ##
		###################$###########################
		if ops.SUPERIMPOSE.calcMethod != None:
			samplePowers = selectCpsseg.desc['power'][:minLen]
			rawSubtraction = tgtseg.desc['power'][segSeek:segSeek+minLen]-(samplePowers*sourceAmpScale*ops.SUPERIMPOSE.subtractScale)
			# clip it so its above zero
			tgtseg.desc['power'][segSeek:segSeek+minLen] = np.clip(rawSubtraction, 0, sys.maxint)
			# recalculate onset envelope
			SdifDescList, ComputedDescList, AveragedDescList = tgtseg.desc.getDescriptorOrigins() 
			for dobj in ComputedDescList:
				if dobj.describes_energy and dobj.name != 'power':
					tgtseg.desc[dobj.name] = descriptordata.DescriptorComputation(dobj, tgtseg, None, None)
			for d in AveragedDescList:
				tgtseg.desc[d.name].clear()			
		#####################################
		## mix chosen sample's descriptors ##
		#####################################
		if ops.SUPERIMPOSE.calcMethod == "mixture":
			tgtseg.mixSelectedSamplesDescriptors(selectCpsseg, sourceAmpScale, segSeek, SdifInterface)
		#################################
		## append selected corpus unit ##
		#################################
		transposition = util.getTransposition(tgtseg, selectCpsseg)
		cps.updateWithSelection(selectCpsseg, timeInSec)
		cpsEffDur = selectCpsseg.desc['effDur-seg'].get(0, None)
		maxoverlaps = np.max(superimp.cnt['overlap'][tif:tif+minLen])
		eventTime = (timeInSec*ops.OUTPUT_TIME_STRETCH)+ops.OUTPUT_TIME_ADD

		outputEvents.append( concatenativeClasses.outputEvent(selectCpsseg, eventTime, util.ampToDb(sourceAmpScale), transposition, tgtseg, maxoverlaps, tgtsegdur, segidx, ops.CSOUND_STRETCH_CORPUS_TO_TARGET_DUR) )
		
		corpusname = os.path.split(cps.data['vcToCorpusName'][selectCpsseg.voiceID])[1]
		superimp.increment(tif, tgtseg.desc['effDur-seg'].get(segSeek, None), segidx, selectCpsseg.voiceID, selectCpsseg.desc['power'], distanceCalculations.returnSearchPassText(), corpusname)

		printLabel = "searching @ %.2f x %i"%(timeInSec, maxoverlaps+1)
		printLabel += ' '*(24-len(printLabel))
		printLabel += "search pass lengths: %s"%('  '.join(distanceCalculations.lengthAtPasses))
		p.percentageBarNext(lowerLabel=printLabel, incr=0)

p.percentageBarClose(txt='Selected %i events'%len(outputEvents))
p.logsection( "CONCATENATION SUMMARY" )
if ops.PRINT_SIM_SELECTION_HISTO:
	p.printListLikeHistogram('Simultaneous Selection Histogram', ["%i notes"%(v) for v in superimp.cnt['segidx']])
if ops.PRINT_SELECTION_HISTO:
	p.printListLikeHistogram('Corpus Selection Histogram', superimp.cnt['cpsnames'])

p.logsection( "OUTPUT FILES" )
#####################################
## sort outputEvents by start time ##
#####################################
outputEvents.sort(key=lambda x: x.timeInScore)

######################
## dict output file ##
######################
if ops.DICT_OUTPUT_FILEPATH != None:
	output = {}
	output['target'] = None
	output['corpus'] = None
	output['selectedEvents'] = [oe.makeDictOutput() for oe in outputEvents]
	fh = open(ops.DICT_OUTPUT_FILEPATH, 'w')
	json.dump(output, fh)
	fh.close()
	p.log( "Wrote JSON dict file %s\n"%ops.DICT_OUTPUT_FILEPATH )

######################
## midi output file ##
######################
if ops.MIDI_FILEPATH != None:
	import midifile
	MyMIDI = midifile.MIDIFile(1)
	MyMIDI.addTrackName(0, 0., "AudioGuide Track")
	MyMIDI.addTempo(0, 0., 60.)
	for oe in outputEvents:
		MyMIDI.addNote(0, 0, oe.midiPitch, oe.timeInScore, oe.duration, oe.midiVelocity)
	binfile = open(ops.MIDI_FILEPATH, 'wb')
	MyMIDI.writeFile(binfile)
	binfile.close()
	p.log( "Wrote MIDIfile %s\n"%ops.MIDI_FILEPATH )

#################################
## target segment label output ##
#################################
if ops.TARGET_SEGMENT_LABELS_FILEPATH != None:
	tgt.writeSegmentationFile(ops.TARGET_SEGMENT_LABELS_FILEPATH)
	p.log( "Wrote target label file %s\n"%ops.TARGET_SEGMENT_LABELS_FILEPATH )

###################################
## superimpose label output file ##
###################################
if ops.SUPERIMPOSITION_LABEL_FILEPATH != None:
	fh = open(ops.SUPERIMPOSITION_LABEL_FILEPATH, 'w')
	fh.write( ''.join([ oe.makeLabelText() for oe in outputEvents ]) )
	fh.close()
	p.log( "Wrote superimposition label file %s\n"%ops.SUPERIMPOSITION_LABEL_FILEPATH )

######################
## lisp output file ##
######################
if ops.LISP_OUTPUT_FILEPATH != None:
	fh = open(ops.LISP_OUTPUT_FILEPATH, 'w')
	fh.write('(' + ''.join([ oe.makeLispText() for oe in outputEvents ]) +')')
	fh.close()
	p.log( "Wrote lisp output file %s\n"%ops.LISP_OUTPUT_FILEPATH )

########################################
## data from segmentation file output ##
########################################
if ops.DATA_FROM_SEGMENTATION_FILEPATH != None:
	fh = open(ops.DATA_FROM_SEGMENTATION_FILEPATH, 'w')
	for line in [oe.makeSegmentationDataText() for oe in outputEvents]:
		fh.write(line)
	fh.close()
	p.log( "Wrote data from segmentation file to textfile %s\n"%ops.DATA_FROM_SEGMENTATION_FILEPATH )

########################
## csound output file ##
########################
if ops.CSOUND_CSD_FILEPATH != None:
	import csoundinterface as csd
	csSco = ''.join([ oe.makeCsoundOutputText(ops.CSOUND_CHANNEL_RENDER_METHOD) for oe in outputEvents ])
	csd.makeConcatenationCsdFile(ops.CSOUND_CSD_FILEPATH, ops.CSOUND_RENDER_FILEPATH, ops.CSOUND_CHANNEL_RENDER_METHOD, ops.CSOUND_SR, ops.CSOUND_KR, csSco, cps.len)
	p.log( "Wrote csound csd file %s\n"%ops.CSOUND_CSD_FILEPATH )
	if ops.CSOUND_RENDER_FILEPATH != None:
		csd.render(ops.CSOUND_CSD_FILEPATH, len(outputEvents), printerobj=p)
		p.log( "Wrote csound soundfile output %s\n"%ops.CSOUND_RENDER_FILEPATH )


####################
## close log file ##
####################
p.close()
	
if ops.CSOUND_RENDER_FILEPATH != None and ops.CSOUND_PLAY_RENDERED_FILE:
	csd.playFile( ops.CSOUND_RENDER_FILEPATH )
		
	
