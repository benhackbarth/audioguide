#!/usr/bin/env python
############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################


import sys, os, audioguide
defaultpath, libpath = audioguide.setup(os.path.dirname(__file__))
opspath = audioguide.optionsfiletest(sys.argv)
sys.path.append(libpath)
# import audioguide's submodules
from audioguide import sfsegment, concatenativeclasses, simcalc, userinterface, util, descriptordata, anallinkage
# import other modules
import numpy as np
import json




###########################################
## LOAD OPTIONS AND SETUP SDIF-INTERFACE ##
###########################################
ops = concatenativeclasses.parseOptions(opsfile=opspath, defaults=defaultpath, scriptpath=os.path.dirname(__file__))
if 'concateMethod' in ops.EXPERIMENTAL and ops.EXPERIMENTAL['concateMethod'] == 'framebyframe':
	util.error("CONFIG", "Frame by frame concatenation is only possible with the agConcatenateFrames.py script.")


p = userinterface.printer(ops.VERBOSITY, os.path.dirname(__file__), ops.HTML_LOG_FILEPATH)
p.printProgramInfo(audioguide.__version__)
AnalInterface = ops.createAnalInterface(p)
p.middleprint('SOUNDFILE CONCATENATION')


############
## TARGET ##
############
p.logsection( "TARGET" )
tgt = sfsegment.target(ops.TARGET, AnalInterface)
tgt.initAnal(AnalInterface, ops, p)
tgt.stageSegments(AnalInterface, ops, p)

if len(tgt.segs) == 0:
	util.error("TARGET FILE", "no segments found!  this is rather strange.  could your target file %s be digital silence??"%(tgt.filename))
p.log("TARGET SEGMENTATION: found %i segments with an average length of %.3f seconds"%(len(tgt.segs), np.average(tgt.seglengths)))
#######################
## target label file ##
#######################
if ops.TARGET_SEGMENT_LABELS_FILEPATH != None:
	tgt.writeSegmentationFile(ops.TARGET_SEGMENT_LABELS_FILEPATH)
	p.log( "TARGET: wrote segmentation label file %s"%ops.TARGET_SEGMENT_LABELS_FILEPATH )
#############################
## target descriptors file ##
#############################
if ops.TARGET_DESCRIPTORS_FILEPATH != None:
	outputdict = tgt.whole.desc.getdict()
	outputdict['frame2second'] = AnalInterface.f2s(1)
	fh = open(ops.TARGET_DESCRIPTORS_FILEPATH, 'w')
	json.dump(outputdict, fh)
	fh.close()
	p.log("TARGET: wrote descriptors to %s"%(ops.TARGET_DESCRIPTORS_FILEPATH))
##############################
## target descriptor graphs ##
##############################
if ops.TARGET_PLOT_DESCRIPTORS_FILEPATH != None:
	tgt.plotMetrics(ops.TARGET_PLOT_DESCRIPTORS_FILEPATH, AnalInterface, p)
###############################
## target segmentation graph ##
###############################
if ops.TARGET_SEGMENTATION_GRAPH_FILEPATH != None:
	tgt.plotSegmentation(ops.TARGET_SEGMENTATION_GRAPH_FILEPATH, AnalInterface, p)

descriptors = []
dnames = []
for dobj in AnalInterface.requiredDescriptors:
	if dobj.seg or dobj.name in ['power']: continue
	d = np.array(tgt.whole.desc[dobj.name][:])
	d -= np.min(d)
	d /= np.max(d)
	d = np.around(d, 2)
	
	descriptors.append(d)
	dnames.append(dobj.name)
p.html.jschart_timeseries(yarray=np.array([AnalInterface.f2s(i) for i in range(tgt.whole.lengthInFrames)]), xarrays=descriptors, ylabel='time in seconds', xlabels=dnames)


############
## CORPUS ##
############
p.logsection( "CORPUS" )
cps = concatenativeclasses.corpus(ops.CORPUS, ops.CORPUS_GLOBAL_ATTRIBUTES, ops.RESTRICT_CORPUS_SELECT_PERCENTAGE_BY_STRING, AnalInterface, p)

htmlCorpusTable = [['', 'minimum', 'maximum', 'average']]
segmentLength = [c.segmentDurationSec for c in cps.postLimitSegmentNormList]
htmlCorpusTable.append(['segment length', min(segmentLength), max(segmentLength), np.mean(segmentLength)])
power = [c.desc['power-seg'].get(None, None) for c in cps.postLimitSegmentNormList]
htmlCorpusTable.append(['power', min(power), max(power), np.mean(power)])
p.maketable(htmlCorpusTable)




###################
## NORMALIZATION ##
###################
p.logsection( "NORMALIZATION" )


if ops.NORMALIZATION_METHOD == 'standard':
	normalizationTable = [['descriptor', 'norm method', 'target mean', 'target stddev', 'corpus mean', 'corpus stddev', 'freedom']]
	for dobj in AnalInterface.normalizeDescriptors:
		if dobj.norm == 1:
			# normalize both together
			allsegs = tgt.segs + cps.postLimitSegmentNormList
			tgtStatistics = cpsStatistics = sfsegment.getDescriptorStatistics(allsegs, dobj, stdDeltaDegreesOfFreedom=ops.NORMALIZATION_DELTA_FREEDOM)
			sfsegment.applyDescriptorNormalisation(allsegs, dobj, tgtStatistics)
		elif dobj.norm == 2:
			# normalize target
			tgtStatistics = sfsegment.getDescriptorStatistics(tgt.segs, dobj, stdDeltaDegreesOfFreedom=ops.NORMALIZATION_DELTA_FREEDOM)
			sfsegment.applyDescriptorNormalisation(tgt.segs, dobj, tgtStatistics)
			# normalize corpus
			cpsStatistics = sfsegment.getDescriptorStatistics(cps.postLimitSegmentNormList, dobj, stdDeltaDegreesOfFreedom=ops.NORMALIZATION_DELTA_FREEDOM)
			sfsegment.applyDescriptorNormalisation(cps.postLimitSegmentNormList, dobj, cpsStatistics)
		normalizationTable.append([dobj.name, dobj.normmethod, tgtStatistics['mean'], tgtStatistics['stddev'], cpsStatistics['mean'], cpsStatistics['stddev'], ops.NORMALIZATION_DELTA_FREEDOM])
	p.maketable(normalizationTable)

# BROKEN IN PYTHON 3	
#elif ops.NORMALIZATION_METHOD == 'cluster':
#	clusterObj = descriptordata.clusterAnalysis(ops.CLUSTER_MAPPING, tgt.segs, cps.postLimitSegmentNormList, os.path.dirname(__file__))
#	tgtClusts, cpsClusts = clusterObj.getClusterNumbers()
#	clusteredSegLists = []
#	for segs, clustList in [(tgt.segs, tgtClusts), (cps.postLimitSegmentNormList, cpsClusts)]:
#		for cidx in clustList:
#			clusteredSegLists.append([seg for seg in segs if seg.cluster == cidx])
#	for segList in clusteredSegLists:
#		if len(segList) == 0: continue
#		for dobj in AnalInterface.normalizeDescriptors:
#			stats = sfsegment.getDescriptorStatistics(segList, dobj, stdDeltaDegreesOfFreedom=ops.NORMALIZATION_DELTA_FREEDOM)
#			sfsegment.applyDescriptorNormalisation(segList, dobj, stats)
#





############################################################################
## get raw and normalized segemented sdesciptors for graphing in log.html ##
############################################################################
p.makeHtmlChartDescriptorNorm(AnalInterface, tgt.segs, cps.postLimitSegmentNormList)	

	
		
	
	
##############################
## initialise concatenation ##
##############################
p.logsection( "CONCATENATION" )
tgt.setupConcate(AnalInterface)
AnalInterface.done()
distanceCalculations = simcalc.distanceCalculations(ops.SUPERIMPOSE, ops.RANDOM_SEED, AnalInterface, tgt.segs, p)
distanceCalculations.setTarget(ops.SEARCH, tgt.segs)
superimp = concatenativeclasses.SuperimposeTracker(tgt.lengthInFrames, len(tgt.segs), ops.SUPERIMPOSE.overlapAmpThresh, ops.SUPERIMPOSE.peakAlign, ops.SUPERIMPOSE.peakAlignEnvelope, len(ops.CORPUS), ops.RESTRICT_CORPUS_OVERLAP_BY_STRING, p)
cps.setupConcate(tgt, AnalInterface)
outputEvents = []

#######################################
### sort segments by power if needed ##
#######################################
import operator
if ops.SUPERIMPOSE.searchOrder == 'power':
	tgt.segs = sorted(tgt.segs, key=operator.attrgetter("power"), reverse=True)
else:
	tgt.segs = sorted(tgt.segs, key=operator.attrgetter("segmentStartSec"))


#########################
## TARGET SEGMENT LOOP ##
#########################
p.startPercentageBar(upperLabel="CONCATINATING", total=len(tgt.segs)+1)
htmlSelectionTable = [['time x overlap', ]]
for sidx, s in enumerate(ops.SEARCH):
	htmlSelectionTable[0].append('spass #%s: %s'%(sidx+1, s.method))

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
		tif = tgtseg.segmentStartFrame+segSeek
		if tif >= tgt.lengthInFrames: break
		timeInSec = AnalInterface.f2s(tif)
		tgtsegdur =  tgtseg.segmentDurationSec - AnalInterface.f2s(segSeek)
		segidxt = superimp.test('segidx', segidx, ops.SUPERIMPOSE.minSegment, ops.SUPERIMPOSE.maxSegment)
		overt = superimp.test('overlap', tif, ops.SUPERIMPOSE.minOverlap, ops.SUPERIMPOSE.maxOverlap)
		onsett = superimp.test('onset', tif, ops.SUPERIMPOSE.minOnset, ops.SUPERIMPOSE.maxOnset)
		trigVal = tgtseg.thresholdTest(segSeek, AnalInterface.tgtOnsetDescriptors)
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
		validSegments = cps.evaluateValidSamples(tif, timeInSec, tgtseg.idx, ops.ROTATE_VOICES, ops.VOICE_PATTERN, ops.VOICE_TO_ONSET_MAPPING, ops.CLUSTER_MAPPING, tgtseg.classification, superimp)
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
		sourceAmpScale *= util.dbToAmp(selectCpsseg.envDb)
		###################$###########################
		## subtract power and update onset detection ##
		###################$###########################
		if ops.SUPERIMPOSE.calcMethod != None:
			#oneInCorpusLand = (1-cps.powerStats['mean'])/cps.powerStats['stddev']
			#normalizationPowerRatio = (oneInCorpusLand*tgt.powerStats['stddev'])+tgt.powerStats['mean']
			
			preSubtractPeak = util.ampToDb(np.max(tgtseg.desc['power'][segSeek:segSeek+minLen]))
			rawSubtraction = tgtseg.desc['power'][segSeek:segSeek+minLen]-(selectCpsseg.desc['power'][:minLen]*sourceAmpScale*ops.SUPERIMPOSE.subtractScale)
			tgtseg.desc['power'][segSeek:segSeek+minLen] = np.clip(rawSubtraction, 0, sys.maxsize) # clip it so its above zero
			postSubtractPeak = util.ampToDb(np.max(tgtseg.desc['power'][segSeek:segSeek+minLen]))
			#p.log("\tsubtracted %i corpus frames from target's amplitude -- original peak %.1fdB, new peak %.1fdB"%(minLen, preSubtractPeak, postSubtractPeak))
			
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
			tgtseg.mixSelectedSamplesDescriptors(selectCpsseg, sourceAmpScale, segSeek, AnalInterface)
		#################################
		## append selected corpus unit ##
		#################################
		transposition = util.getTransposition(tgtseg, selectCpsseg)
		cps.updateWithSelection(selectCpsseg, timeInSec, segidx)
		cpsEffDur = selectCpsseg.desc['effDurFrames-seg'].get(0, None)
		maxoverlaps = np.max(superimp.cnt['overlap'][tif:tif+minLen])
		eventTime = (timeInSec*ops.OUTPUTEVENT_TIME_STRETCH)+ops.OUTPUTEVENT_TIME_ADD
		outputEvents.append( concatenativeclasses.outputEvent(selectCpsseg, eventTime, util.ampToDb(sourceAmpScale), transposition, tgtseg, maxoverlaps, tgtsegdur, tgtseg.idx, ops.CSOUND_STRETCH_CORPUS_TO_TARGET_DUR, AnalInterface.f2s(1), ops.OUTPUTEVENT_DURATION_SELECT, ops.OUTPUTEVENT_DURATION_MIN, ops.OUTPUTEVENT_DURATION_MAX, ops.OUTPUTEVENT_ALIGN_PEAKS) )
		
		corpusname = os.path.split(cps.data['vcToCorpusName'][selectCpsseg.voiceID])[1]
		superimp.increment(tif, tgtseg.desc['effDurFrames-seg'].get(segSeek, None), segidx, selectCpsseg.voiceID, selectCpsseg.desc['power'], distanceCalculations.returnSearchPassText(), corpusname, selectCpsseg.filename)
		tgtseg.numberSelectedUnits += 1

		printLabel = "searching @ %.2f x %i"%(timeInSec, maxoverlaps+1)
		printLabel += ' '*(24-len(printLabel))
		printLabel += "search pass lengths: %s"%('  '.join(distanceCalculations.lengthAtPasses))
		p.percentageBarNext(lowerLabel=printLabel, incr=0)
		htmlSelectionTable.append(["%.2fx%i"%(timeInSec, int(maxoverlaps)+1), ] + distanceCalculations.lengthAtPassesVerbose )
p.percentageBarClose(txt='Selected %i events'%len(outputEvents))

p.maketable(htmlSelectionTable)



#####################################
## sort outputEvents by start time ##
#####################################
outputEvents.sort(key=lambda x: x.timeInScore)


###########################
## temporal quantization ##
###########################
concatenativeclasses.quantizeTime(outputEvents, ops.OUTPUTEVENT_QUANTIZE_TIME_METHOD, float(ops.OUTPUTEVENT_QUANTIZE_TIME_INTERVAL), p)


##################################
## CORPUS OUTPUT CLASSIFICATION ##
##################################
if ops.OUTPUTEVENT_CLASSIFY['numberClasses'] > 1:
	classifications = descriptordata.soundSegmentClassification(ops.OUTPUTEVENT_CLASSIFY['descriptors'], [oe.sfseghandle for oe in outputEvents], numbClasses=ops.OUTPUTEVENT_CLASSIFY['numberClasses'])
	for cidx, classified in enumerate(classifications): outputEvents[cidx].classification = int(classified)	



#########################################
## target signal decomposition cleanup ##
#########################################
if tgt.decompose != {}:
	for oeidx, oe in enumerate(outputEvents): 
		outputEvents[oeidx].decomposedstream = int(oe.timeInScore/tgt.decompose['origduration'])
		oe.timeInScore = oe.timeInScore%tgt.decompose['origduration']
	tgt.filename = tgt.decompose['origfilename']
	tgt.startSec = 0
	tgt.endSec = tgt.decompose['origduration']
	AnalInterface.rawData[tgt.decompose['origfilename']] = {'info': {'channels': 1, 'lengthsec': tgt.decompose['origduration']}}



#########################
## CREATE OUTPUT FILES ##
#########################
p.logsection( "OUTPUT FILES" )
allusedcpsfiles = list(set([oe.filename for oe in outputEvents]))



######################
## dict output file ##
######################
if ops.DICT_OUTPUT_FILEPATH != None:
	output = {}
	output['opsfilename'] = ops.opsfilehead
	output['opsfiledata'] = ops.opsfileAsString
	# make target segment dict list
	tgt.segs.sort(key=operator.attrgetter('segmentStartSec'))
	tgtSegDataList = []
	for ts in tgt.segs:
		thisSeg = {'startSec': ts.segmentStartSec, 'endSec': ts.segmentEndSec}
		thisSeg['power'] = ts.desc['power-seg'].get(0, None)
		thisSeg['numberSelectedUnits'] = ts.numberSelectedUnits
		thisSeg['has_been_mixed'] = ts.has_been_mixed
		tgtSegDataList.append(thisSeg)
	# finish up
	output['target'] = {'filename': tgt.filename, 'sfSkip': tgt.startSec, 'duration': tgt.endSec-tgt.startSec, 'segs': tgtSegDataList, 'fileduation': AnalInterface.rawData[tgt.filename]['info']['lengthsec'], 'chn': AnalInterface.rawData[tgt.filename]['info']['channels']} 
	output['corpus_file_list'] = list(set(allusedcpsfiles))
	output['selectedEvents'] = [oe.makeDictOutput() for oe in outputEvents]
	output['outputparse'] = {'simultaneousSelections': int(max([d['simultaneousSelectionNumber'] for d in output['selectedEvents']])+1), 'classifications': max(ops.OUTPUTEVENT_CLASSIFY['numberClasses'], 1), 'corpusIds': int(max([d['corpusIdNumber'] for d in output['selectedEvents']])+1)}
	fh = open(ops.DICT_OUTPUT_FILEPATH, 'w')
	json.dump(output, fh)
	fh.close()
	p.log( "Wrote JSON dict file %s\n"%ops.DICT_OUTPUT_FILEPATH )

#####################################
## maxmsp list output pour gilbert ##
#####################################
if ops.MAXMSP_OUTPUT_FILEPATH != None:
	output = {}
	output['target_file'] = [tgt.filename, tgt.startSec*1000., tgt.endSec*1000.]
	output['events'] = [oe.makeMaxMspListOutput() for oe in outputEvents]
	output['corpus_files'] = allusedcpsfiles
	fh = open(ops.MAXMSP_OUTPUT_FILEPATH, 'w')
	json.dump(output, fh)
	fh.close()
	p.log( "Wrote MAX/MSP JSON lists to file %s\n"%ops.MAXMSP_OUTPUT_FILEPATH )
	
######################
## midi output file ##
######################
if ops.MIDI_FILEPATH != None:
	import midifile
	MyMIDI = midifile.MIDIFile(1)
	MyMIDI.addTrackName(0, 0., "AudioGuide Track")
	MyMIDI.addTempo(0, 0., ops.MIDIFILE_TEMPO)
	temposcalar = ops.MIDIFILE_TEMPO/60.
	for oe in outputEvents:
		MyMIDI.addNote(0, 0, oe.midiPitch, oe.timeInScore*temposcalar, oe.duration*temposcalar, oe.midiVelocity)
	binfile = open(ops.MIDI_FILEPATH, 'wb')
	MyMIDI.writeFile(binfile)
	binfile.close()
	p.log( "Wrote MIDIfile %s\n"%ops.MIDI_FILEPATH )

###################################
## superimpose label output file ##
###################################
if ops.OUTPUT_LABEL_FILEPATH != None:
	fh = open(ops.OUTPUT_LABEL_FILEPATH, 'w')
	fh.write( ''.join([ oe.makeLabelText() for oe in outputEvents ]) )
	fh.close()
	p.log( "Wrote superimposition label file %s\n"%ops.OUTPUT_LABEL_FILEPATH )

#######################################
## corpus segmented features as json ##
#######################################
if ops.CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH != None:
	fh = open(ops.CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH, 'w')
	alldata = {}
	for c in cps.postLimitSegmentNormList:
		descs = {}
		for name, obj in c.desc.nameToObjMap.items():
			if name.find('-seg') != -1:
				descs[ name ] = obj.get(0, c.desc.len)
		alldata[(c.filename+'@'+str(c.segmentStartSec))] = descs
	json.dump(alldata, fh)
	fh.close()
	p.log( "Wrote corpus segmented features file %s\n"%ops.CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH )


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
	from audioguide import csoundinterface as csd
	maxOverlaps = np.max([oe.simSelects for oe in outputEvents])
	#csSco = csd.makeFtableFromDescriptor(tgt.whole.desc['power'], 'power', AnalInterface.f2s(1), ops.CSOUND_SR, ops.CSOUND_KSMPS)+'\n\n'
	csSco = 'i2  0.  %f  %f  "%s"  %f\n\n'%(tgt.endSec-tgt.startSec, tgt.whole.envDb, tgt.filename, tgt.startSec)
	
	# just in case that there are negative p2 times!
	minTime = min([ oe.timeInScore for oe in outputEvents ])
	if minTime < 0:
		for oe in outputEvents:
			oe.timeInScore -= minTime
	csSco += ''.join([ oe.makeCsoundOutputText(ops.CSOUND_CHANNEL_RENDER_METHOD) for oe in outputEvents ])
	csd.makeConcatenationCsdFile(ops.CSOUND_CSD_FILEPATH, ops.CSOUND_RENDER_FILEPATH, ops.CSOUND_CHANNEL_RENDER_METHOD, ops.CSOUND_SR, ops.CSOUND_KSMPS, csSco, cps.len, set([oe.sfchnls for oe in outputEvents]), maxOverlaps, ops.OUTPUTEVENT_CLASSIFY['numberClasses'], bits=ops.CSOUND_BITS)
	p.log( "Wrote csound csd file %s\n"%ops.CSOUND_CSD_FILEPATH )
	if ops.CSOUND_RENDER_FILEPATH != None:
		csd.render(ops.CSOUND_CSD_FILEPATH, len(outputEvents), printerobj=p)
		p.log( "Rendered csound soundfile output %s\n"%ops.CSOUND_RENDER_FILEPATH )
	
	if ops.CSOUND_NORMALIZE:
		csd.normalize(ops.CSOUND_RENDER_FILEPATH, db=ops.CSOUND_NORMALIZE_PEAK_DB)


####################
## close log file ##
####################
if ops.HTML_LOG_FILEPATH != None: p.writehtmllog(ops.HTML_LOG_FILEPATH)
	
if ops.CSOUND_CSD_FILEPATH != None and ops.CSOUND_RENDER_FILEPATH != None and ops.CSOUND_PLAY_RENDERED_FILE:
	csd.playFile( ops.CSOUND_RENDER_FILEPATH )
		
	
