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
if 'concateMethod' not in ops.EXPERIMENTAL or ops.EXPERIMENTAL['concateMethod'] != 'framebyframe':
	util.error("CONFIG", "agConcatenateFrames.py only supports frame by frame concatenation, e.g. examples/07-concatenateframes.py.")
p = userinterface.printer(ops.VERBOSITY, os.path.dirname(__file__), ops.HTML_LOG_FILEPATH)
p.printProgramInfo(audioguide.__version__)
AnalInterface = ops.createAnalInterface(p)
p.middleprint('EXPERIMENTAL FRAME-BASED CONCATENATION')




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


############
## CORPUS ##
############
p.logsection( "CORPUS" )
cps = concatenativeclasses.corpus(ops.CORPUS, ops.CORPUS_GLOBAL_ATTRIBUTES, ops.RESTRICT_CORPUS_SELECT_PERCENTAGE_BY_STRING, ops.SEARCH_PATHS, AnalInterface, p)



###################
## NORMALIZATION ##
###################
p.logsection( "NORMALIZATION" )


if ops.NORMALIZATION_METHOD == 'standard':
	normalizationTable = [['descriptor', 'norm method', 'target mean', 'target stddev', 'corpus mean', 'corpus stddev', 'freedom']]
	for dobj in AnalInterface.normalizeDescriptors:
		if dobj.norm == 1:
			# normalize both together
			allsegs = [tgt.whole] + cps.postLimitSegmentNormList
			tgtStatistics = cpsStatistics = sfsegment.getDescriptorStatistics(allsegs, dobj, stdDeltaDegreesOfFreedom=ops.NORMALIZATION_DELTA_FREEDOM)
			sfsegment.applyDescriptorNormalisation(allsegs, dobj, tgtStatistics)
		elif dobj.norm == 2:
			# normalize target
			tgtStatistics = sfsegment.getDescriptorStatistics([tgt.whole], dobj, stdDeltaDegreesOfFreedom=ops.NORMALIZATION_DELTA_FREEDOM)
			sfsegment.applyDescriptorNormalisation([tgt.whole], dobj, tgtStatistics)
			# normalize corpus
			cpsStatistics = sfsegment.getDescriptorStatistics(cps.postLimitSegmentNormList, dobj, stdDeltaDegreesOfFreedom=ops.NORMALIZATION_DELTA_FREEDOM)
			sfsegment.applyDescriptorNormalisation(cps.postLimitSegmentNormList, dobj, cpsStatistics)
		normalizationTable.append([dobj.name, dobj.normmethod, tgtStatistics['mean'], tgtStatistics['stddev'], cpsStatistics['mean'], cpsStatistics['stddev'], ops.NORMALIZATION_DELTA_FREEDOM])
	p.maketable(normalizationTable)
	
elif ops.NORMALIZATION_METHOD == 'cluster':
	clusterObj = descriptordata.clusterAnalysis(ops.CLUSTER_MAPPING, tgt.segs, cps.postLimitSegmentNormList, os.path.dirname(__file__))
	tgtClusts, cpsClusts = clusterObj.getClusterNumbers()
	clusteredSegLists = []
	for segs, clustList in [(tgt.segs, tgtClusts), (cps.postLimitSegmentNormList, cpsClusts)]:
		for cidx in clustList:
			clusteredSegLists.append([seg for seg in segs if seg.cluster == cidx])
	for segList in clusteredSegLists:
		if len(segList) == 0: continue
		for dobj in AnalInterface.normalizeDescriptors:
			stats = sfsegment.getDescriptorStatistics(segList, dobj, stdDeltaDegreesOfFreedom=ops.NORMALIZATION_DELTA_FREEDOM)
			sfsegment.applyDescriptorNormalisation(segList, dobj, stats)




##############################
## initialise concatenation ##
##############################
p.logsection( "FRAME BY FRAME CONCATENATION" )
tgt.setupConcate(AnalInterface)
AnalInterface.done()
cps.setupConcate(tgt, AnalInterface)



# add defaults in case not everything is user supplied
defaults = {'envAttackFrames': 1, 'envDecayFrames': 1, 'percentMatchDeviationForSegmentFrameAddition': 20, 'minimumLengthInFrames': 5, 'maximumLengthInFrames': None, 'maxoverlaps': 4, 'canReuseCorpusFrames': True,}
for k, v in defaults.items():
	if k not in ops.EXPERIMENTAL: ops.EXPERIMENTAL[k] = v

# check to make sure user arguments are correct
from audioguide import tests
assert ops.EXPERIMENTAL['concateMethod'] == 'framebyframe'
assert tests.testVariable('an spass() object', ops.EXPERIMENTAL['matrix'])

if ops.EXPERIMENTAL['minimumLengthInFrames'] == None: ops.EXPERIMENTAL['minimumLengthInFrames'] = 0
if ops.EXPERIMENTAL['maximumLengthInFrames'] == None: ops.EXPERIMENTAL['maximumLengthInFrames'] = 100000


##################################
## order target frames by power ##
##################################
tgtorderedframes = [(pwr, tidx) for (tidx, pwr) in enumerate(tgt.whole.desc['power'])]
tgtorderedframes.sort(reverse=True)
tgtorderedframes = [tidx for (pwr, tidx) in tgtorderedframes] # tidx's ordered from loudest to softest
tgtoverlaps = np.zeros(tgt.whole.lengthInFrames)

###################################
## make target descriptor matrix ##
###################################
tgtmatrix = np.empty((len(ops.EXPERIMENTAL['matrix'].descriptor_list), tgt.whole.lengthInFrames))
for didx, dobj in enumerate(ops.EXPERIMENTAL['matrix'].descriptor_list):
	tgtmatrix[didx] = tgt.whole.desc[dobj.name].getnorm()
###################################
## make corpus descriptor matrix ##
###################################
cpsmatrix = np.empty((len(ops.EXPERIMENTAL['matrix'].descriptor_list), sum([c.lengthInFrames for c in cps.postLimitSegmentNormList])))
cpsmatrixregistry = {}
f = 0
for c in cps.postLimitSegmentNormList:
	for didx, d in enumerate(ops.EXPERIMENTAL['matrix'].descriptor_list):
		cpsmatrix[didx][f:f+c.lengthInFrames] = c.desc[d.name].getnorm()
		#print "CORPUS", d.name, cpsmatrix[didx][0:5]
	skip = 0 
	for i in range(c.lengthInFrames):
		cpsmatrixregistry[f+skip] = (c, f, f+c.lengthInFrames, skip) # frame -> (cobjm, startframe, endframe, skipframe)
		skip += 1
	f += c.lengthInFrames
cpsSelectedFrameDict = {}

################################
## loop through target frames ##
################################
p.startPercentageBar(upperLabel="CONCATINATING", total=len(tgtorderedframes)+1)
outputEvents = []
csSco = ''
for tidx in tgtorderedframes:
	p.percentageBarNext()
	# are overlaps met for this frame?
	if tgtoverlaps[tidx] == ops.EXPERIMENTAL['maxoverlaps']: continue
	# is this frame below the tgt.thresh?
	if tgt.whole.desc['power'][tidx] < util.dbToAmp(tgt.segmentationThresh): continue
		
	# get least srq array for this target frame compared to all corpus frames
	cpsMatrixLeastSq = np.sum(np.power(tgtmatrix[:, np.newaxis,tidx] - cpsmatrix, 2), axis=0)

	# mask invalid corpus frames from selection
	cpsValidMask = np.zeros(cpsmatrix.shape[1])	
	if not ops.EXPERIMENTAL['canReuseCorpusFrames']:
		for idx in cpsSelectedFrameDict: cpsValidMask[idx] = 1

	winidx = np.argmin(np.ma.masked_array(cpsMatrixLeastSq, mask=cpsValidMask))
	winlstsq = cpsMatrixLeastSq[winidx]
	selectCpsseg, cpsstartframe, cpsstopframe, frameskip = cpsmatrixregistry[winidx]

	# test to find out how long this frame goes
	results = [(0, 0., True)] # idx, percentchange, ideal?	
	# test forward incrementation
	f = 0
	while True:
		tnextf = tidx+f+1
		cnextf = winidx+f+1
		frameImpossible = cnextf >= cpsstopframe or tnextf >= tgt.whole.lengthInFrames or tgt.whole.desc['power'][tnextf] < util.dbToAmp(tgt.segmentationThresh) or tgtoverlaps[tnextf] == ops.EXPERIMENTAL['maxoverlaps']
		if frameImpossible: break
		leastSqrNext = np.sum(np.power(tgtmatrix[:, np.newaxis, tnextf] - cpsmatrix[:, np.newaxis, cnextf], 2))
		nextframePercent = (leastSqrNext - winlstsq) / max(winlstsq, 0.00000001)
		frameNotIdeal = True in [cnextf in cpsSelectedFrameDict, nextframePercent >= ops.EXPERIMENTAL['percentMatchDeviationForSegmentFrameAddition']]

		if ops.EXPERIMENTAL['maximumLengthInFrames'] != None and f >= ops.EXPERIMENTAL['maximumLengthInFrames']: break
		if frameNotIdeal and f >= ops.EXPERIMENTAL['minimumLengthInFrames']: break
		f += 1
		results.append((f, nextframePercent, frameNotIdeal))
	# test backward incrementation
	f = 0
	while True:
		tprevf = tidx+f-1
		cprevf = winidx+f-1
		frameImpossible = cprevf < cpsstartframe or tprevf < 0 or tgt.whole.desc['power'][tprevf] < util.dbToAmp(tgt.segmentationThresh) or tgtoverlaps[tprevf] == ops.EXPERIMENTAL['maxoverlaps']
		if frameImpossible: break
		leastSqrPrev = np.sum(np.power(tgtmatrix[:, np.newaxis, tprevf] - cpsmatrix[:, np.newaxis, cprevf], 2))
		if leastSqrPrev == 0: leastSqrPrev = 0.00000001
		prevframePercent = (leastSqrPrev - winlstsq) / max(winlstsq, 0.00000001)
		frameNotIdeal = True in [cprevf in cpsSelectedFrameDict, prevframePercent < ops.EXPERIMENTAL['percentMatchDeviationForSegmentFrameAddition']]
		if ops.EXPERIMENTAL['maximumLengthInFrames'] != None and f >= ops.EXPERIMENTAL['maximumLengthInFrames']: break
		if frameNotIdeal and abs(f) >= ops.EXPERIMENTAL['minimumLengthInFrames']: break
		f -= 1
		results.append((f, prevframePercent, frameNotIdeal))
	results.sort()

	# get best subslice
	fmatch = [r[0] for r in results].index(0)
	inc = [0, 0]
	while True:
		previdx = fmatch+inc[0]-1
		nextidx = fmatch+inc[1]+1
		minselecttest = inc[1]-inc[0] < ops.EXPERIMENTAL['minimumLengthInFrames']
		maxselecttest = ops.EXPERIMENTAL['maximumLengthInFrames'] != None and inc[1]-inc[0] > ops.EXPERIMENTAL['maximumLengthInFrames']
		if maxselecttest: break
		if previdx < 0: prevstatus = 'notok'
		elif not results[previdx][2]: prevstatus = 'ok'
		else: prevstatus = 'meh'
		if nextidx >= len(results): nextstatus = 'notok'
		elif not results[nextidx][2]: nextstatus = 'ok'
		else: nextstatus = 'meh'


		#print tidx, prevstatus, nextstatus, results[previdx][1] , results[nextidx][1]
		if prevstatus == 'ok' and nextstatus == 'ok': # both are ok, so let's add the best one
			if results[previdx][1] < results[nextidx][1]: inc[0] -= 1
			else: inc[1] += 1
		elif prevstatus == 'ok': # only prev is OK, add prev
			 inc[0] -= 1
		elif nextstatus == 'ok': # only next is OK, add next
			 inc[1] += 1
		elif minselecttest and prevstatus == 'meh' and nextstatus == 'meh': # both are meh, but we need to pick one
			if results[previdx][1] < results[nextidx][1]: inc[0] -= 1
			else: inc[1] += 1
		elif minselecttest and prevstatus == 'meh': # prev is meh, but we need to add it
			 inc[0] -= 1
		elif minselecttest and nextstatus == 'meh': # next is meh, but we need to add it
			 inc[1] += 1
		else:
			break
	notedurationframes = inc[1]-inc[0]

	if notedurationframes < ops.EXPERIMENTAL['minimumLengthInFrames']: continue
	
	noteinfo = {}
	noteinfo['filename'] = selectCpsseg.filename
	noteinfo['timeInScore'] = AnalInterface.f2s(tidx+inc[0]-ops.EXPERIMENTAL['envAttackFrames'])
	noteinfo['duration'] = AnalInterface.f2s(1 + notedurationframes + ops.EXPERIMENTAL['envAttackFrames'] + ops.EXPERIMENTAL['envDecayFrames'])
	noteinfo['sfSkip'] = selectCpsseg.segmentStartSec + AnalInterface.f2s(frameskip+inc[0]-ops.EXPERIMENTAL['envAttackFrames'])
	noteinfo['corpusId'] = selectCpsseg.voiceID
	noteinfo['sfchnls'] = selectCpsseg.soundfileChns
	noteinfo['transposition'] = 0 # not supported yet
	noteinfo['envDb'] = 0. # not supported yet
	noteinfo['envScaleDb'] = 0. # not supported yet
	noteinfo['envAttackSec'] = AnalInterface.f2s(ops.EXPERIMENTAL['envAttackFrames'])
	noteinfo['envDecaySec'] = AnalInterface.f2s(ops.EXPERIMENTAL['envDecayFrames'])
	noteinfo['envSlope'] = 1. # not supported yet
	cpsstartf = frameskip+inc[0]-ops.EXPERIMENTAL['envAttackFrames']
	if cpsstartf < 0: cpsstartf = 0
	cpsendf = frameskip+inc[1]+ops.EXPERIMENTAL['envDecayFrames']
	#print("\n\n", "CPS", cpsstartf, cpsendf, selectCpsseg.lengthInFrames)
	cpsframepowers = selectCpsseg.desc['power'][cpsstartf:cpsendf]
	cpspeakframe = np.argmax(cpsframepowers)
	noteinfo['peaktimeSec'] = AnalInterface.f2s(cpspeakframe)
	noteinfo['peakRms'] = cpsframepowers[cpspeakframe]
	noteinfo['peakRmsDb'] = util.ampToDb(noteinfo['peakRms'])
	noteinfo['midiPitch'] = selectCpsseg.desc['MIDIPitch-seg'].get(cpsstartf, cpsendf)
	tgtstartf = tidx+inc[0]-ops.EXPERIMENTAL['envAttackFrames']
	tgtendf = tidx+inc[1]+ops.EXPERIMENTAL['envDecayFrames']
	#print("TGT", tgtstartf, tgtendf)
	noteinfo['simSelects'] = max(tgtoverlaps[tgtstartf:tgtendf])
	
	outputEvents.append(noteinfo)

	for df in range(inc[0], inc[1]):
		tgtoverlaps[tidx+df] += 1
		cspf = winidx + df
		if cspf not in cpsSelectedFrameDict: cpsSelectedFrameDict[cspf] = 0
		cpsSelectedFrameDict[cspf] += 1

	printLabel = "searching @ frame %i x %i: "%(tidx, tgtoverlaps[tidx]+1)
	printLabel += ' '*(24-len(printLabel))
	printLabel += "found %i frames"%(notedurationframes)
	p.percentageBarNext(lowerLabel=printLabel, incr=0)


p.percentageBarClose(txt='Selected %i events'%len(outputEvents))





######################
## dict output file ##
######################
if ops.DICT_OUTPUT_FILEPATH != None:
	import operator
	output = {}
	output['opsfilename'] = ops.opsfilehead
	output['opsfiledata'] = ops.opsfileAsString
	output['target'] = {'filename': tgt.filename, 'sfSkip': tgt.startSec, 'duration': tgt.endSec-tgt.startSec, 'fileduation': AnalInterface.rawData[tgt.filename]['info']['lengthsec'], 'chn': AnalInterface.rawData[tgt.filename]['info']['channels']} 
	output['corpus_file_list'] = list(set([oe['filename'] for oe in outputEvents]))	
	output['selectedEvents'] = [oe for oe in outputEvents]
	fh = open(ops.DICT_OUTPUT_FILEPATH, 'w')
	json.dump(output, fh)
	fh.close()
	p.log( "Wrote JSON dict file %s\n"%ops.DICT_OUTPUT_FILEPATH )




########################
## csound output file ##
########################
if ops.CSOUND_CSD_FILEPATH != None:
	from audioguide import csoundinterface as csd
	for noteinfo in outputEvents:
		csSco += "i1  %.3f  %.3f  %.3f  \"%s\"  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %i  %i  %f  %i  %i  \"%s\"  \"%s\"\n"%(noteinfo['timeInScore'], noteinfo['duration'], 0, noteinfo['filename'], noteinfo['sfSkip'], 1, -10, 0, 1, AnalInterface.f2s(ops.EXPERIMENTAL['envAttackFrames']), AnalInterface.f2s(ops.EXPERIMENTAL['envDecayFrames']), 1, 1, 1, 0, 0, tidx, 0, "None", "stereo")
	instruments = None
	csd.makeConcatenationCsdFile(ops.CSOUND_CSD_FILEPATH, ops.CSOUND_RENDER_FILEPATH, ops.CSOUND_CHANNEL_RENDER_METHOD, ops.CSOUND_SR, ops.CSOUND_KSMPS, csSco, cps.len, set([oe['sfchnls'] for oe in outputEvents]), 2, instruments, ops.OUTPUTEVENT_CLASSIFY['numberClasses'], bits=ops.CSOUND_BITS)
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
		
	
