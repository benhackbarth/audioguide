############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

__author__ = "Benjamin Hackbarth, Norbert Schnell, Philippe Esling, Diemo Schwarz, Gilbert Nouno"
__author_email__ = "hackbarth@gmail.com"
__version__ = "1.41"




import sys, os, operator, platform
import numpy as np
import json
import audioguide.sfsegment as sfsegment
import audioguide.userinterface as userinterface
import audioguide.concatenativeclasses as concatenativeclasses
import audioguide.anallinkage as anallinkage
import audioguide.descriptordata as descriptordata
import audioguide.util as util
import audioguide.musicalwriting as musicalwriting
import audioguide.simcalc as simcalc




class main:
	def __init__(self):
		# add pre-compiled library path
		if sys.maxsize > 2**32: bits = 64
		else: bits = 32
		libpath = os.path.join(os.path.dirname(__file__), 'audioguide', 'pylib%i.%i-%s-%i'%(sys.version_info[0], sys.version_info[1], platform.system().lower(), bits))
		sys.path.append(libpath)
		self.ops = concatenativeclasses.parseOptions()


	def parse_options_file(self, opspath):
		self.ops.parse_file(opspath)
		self.finish_setup()

	def parse_options_dict(self, opsdict):
		self.ops.parse_dict(opsdict)
		self.finish_setup()
	
	
	def finish_setup(self, printversion=True):
		if 'concateMethod' in self.ops.EXPERIMENTAL and self.ops.EXPERIMENTAL['concateMethod'] == 'framebyframe':
			util.error("CONFIG", "Frame by frame concatenation is only possible with the agConcatenateFrames.py script.")
		self.p = userinterface.printer(self.ops.VERBOSITY, os.path.dirname(__file__), self.ops.HTML_LOG_FILEPATH)
		if printversion: self.p.printProgramInfo(__version__)
		self.AnalInterface = self.ops.createAnalInterface(self.p)


	def load_target(self):
		############
		## TARGET ##
		############
		self.p.logsection( "TARGET" )
		self.tgt = sfsegment.target(self.ops.TARGET, self.AnalInterface)
		self.tgt.initAnal(self.AnalInterface, self.ops, self.p)
		self.tgt.stageSegments(self.AnalInterface, self.ops, self.p)

		if len(self.tgt.segs) == 0:
			util.error("TARGET FILE", "no segments found!  this is rather strange.  could your target file %s be digital silence??"%(self.tgt.filename))
		self.p.log("TARGET SEGMENTATION: found %i segments with an average length of %.3f seconds"%(len(self.tgt.segs), np.average(self.tgt.seglengths)))
		#######################
		## target label file ##
		#######################
		if self.ops.TARGET_SEGMENT_LABELS_FILEPATH != None:
			self.tgt.writeSegmentationFile(self.ops.TARGET_SEGMENT_LABELS_FILEPATH)
			self.p.log( "TARGET: wrote segmentation label file %s"%self.ops.TARGET_SEGMENT_LABELS_FILEPATH )
		#############################
		## target descriptors file ##
		#############################
		if self.ops.TARGET_DESCRIPTORS_FILEPATH != None:
			outputdict = self.tgt.whole.desc.getdict()
			outputdict['frame2second'] = self.AnalInterface.f2s(1)
			fh = open(self.ops.TARGET_DESCRIPTORS_FILEPATH, 'w')
			json.dump(outputdict, fh)
			fh.close()
			self.p.log("TARGET: wrote descriptors to %s"%(self.ops.TARGET_DESCRIPTORS_FILEPATH))
		##############################
		## target descriptor graphs ##
		##############################
		if self.ops.TARGET_PLOT_DESCRIPTORS_FILEPATH != None:
			self.tgt.plotMetrics(self.ops.TARGET_PLOT_DESCRIPTORS_FILEPATH, self.AnalInterface, self.p)
		###############################
		## target segmentation graph ##
		###############################
		if self.ops.TARGET_SEGMENTATION_GRAPH_FILEPATH != None:
			self.tgt.plotSegmentation(self.ops.TARGET_SEGMENTATION_GRAPH_FILEPATH, self.AnalInterface, self.p)

		descriptors = []
		dnames = []
		for dobj in self.AnalInterface.requiredDescriptors:
			if dobj.seg or dobj.name in ['power']: continue
			d = np.array(self.tgt.whole.desc.get(dobj.name, copy=True))
			d -= np.min(d)
			d /= np.max(d)
			d = np.around(d, 2)
	
			descriptors.append(d)
			dnames.append(dobj.name)
		self.p.html.jschart_timeseries(yarray=np.array([self.AnalInterface.f2s(i) for i in range(self.tgt.whole.lengthInFrames)]), xarrays=descriptors, ylabel='time in seconds', xlabels=dnames)




	def load_corpus(self):
		############
		## CORPUS ##
		############
		self.p.logsection( "CORPUS" )
		self.cps = concatenativeclasses.corpus(self.ops.CORPUS, self.ops.CORPUS_GLOBAL_ATTRIBUTES, self.ops.RESTRICT_CORPUS_SELECT_PERCENTAGE_BY_STRING, self.ops.SEARCH_PATHS, self.AnalInterface, self.p)

		htmlCorpusTable = [['', 'minimum', 'maximum', 'average']]
		segmentLength = [c.segmentDurationSec for c in self.cps.postLimitSegmentNormList]
		htmlCorpusTable.append(['segment length', min(segmentLength), max(segmentLength), np.mean(segmentLength)])
		power = [c.desc.get('power-seg') for c in self.cps.postLimitSegmentNormList]
		htmlCorpusTable.append(['power', min(power), max(power), np.mean(power)])
		self.p.maketable(htmlCorpusTable)




	def normalize(self):
		###################
		## NORMALIZATION ##
		###################
		self.p.logsection( "NORMALIZATION" )
		self.AnalInterface.desc_manager.normalize(self.tgt.segs + self.cps.postLimitSegmentNormList, self.AnalInterface.normalizeDescriptors)

		###########################################################################
		## get raw and normalized segemented desciptors for graphing in log.html ##
		###########################################################################
		self.p.makeHtmlChartDescriptorNorm(self.AnalInterface, self.tgt.segs, self.cps.postLimitSegmentNormList)	

	
		
	
	
	def standard_concatenate(self):
		##############################
		## initialise concatenation ##
		##############################
		self.p.logsection( "CONCATENATION" )
		self.tgt.setupConcate(self.AnalInterface)
		self.AnalInterface.done()
		distanceCalculations = simcalc.distanceCalculations(self.ops.SUPERIMPOSE, self.ops.RANDOM_SEED, self.AnalInterface, self.tgt.segs, self.p)
		distanceCalculations.setTarget(self.ops.SEARCH, self.tgt.segs)

		self.instruments = musicalwriting.instruments(self.ops.INSTRUMENTS, self.ops.CORPUS, self.ops.SCORE_OUTPUT_FILEPATH, self.tgt.lengthInFrames, self.cps.postLimitSegmentNormList, self.AnalInterface.hopLengthSec, self.p)

		superimp = concatenativeclasses.SuperimposeTracker(self.tgt.lengthInFrames, len(self.tgt.segs), self.ops.SUPERIMPOSE.overlapAmpThresh, self.ops.SUPERIMPOSE.peakAlign, self.ops.SUPERIMPOSE.peakAlignEnvelope, len(self.ops.CORPUS), self.ops.RESTRICT_CORPUS_OVERLAP_BY_STRING, self.p)
		self.cps.setupConcate(self.tgt, self.AnalInterface)
		self.outputEvents = []

		#######################################
		### sort segments by power if needed ##
		#######################################
		if self.ops.SUPERIMPOSE.searchOrder == 'power':
			self.tgt.segs = sorted(self.tgt.segs, key=operator.attrgetter("power"), reverse=True)
		else:
			self.tgt.segs = sorted(self.tgt.segs, key=operator.attrgetter("segmentStartSec"))


		#################
		## CONCATENATE ##
		#################
		self.p.startPercentageBar(upperLabel="CONCATINATING", total=len(self.tgt.segs)+1)
		htmlSelectionTable = [['time x overlap', ]]
		for sidx, s in enumerate(self.ops.SEARCH):
			htmlSelectionTable[0].append('spass #%s: %s'%(sidx+1, s.method))





		while False in [t.selectiondone for t in self.tgt.segs]:
			self.p.percentageBarNext()
			for segidx, tgtseg in enumerate(self.tgt.segs):
				if tgtseg.selectiondone == True:
					continue
				##############################################################
				## check to see if we are done with this particular segment ##
				##############################################################
				if tgtseg.seek >= tgtseg.lengthInFrames: 
					tgtseg.selectiondone = True
					continue 
				########################################
				## run selection superimposition test ##
				########################################
				tif = tgtseg.segmentStartFrame+tgtseg.seek
				if tif >= self.tgt.lengthInFrames:
					tgtseg.selectiondone = True
					continue 
				timeInSec = self.AnalInterface.f2s(tif)
				tgtsegdur =  tgtseg.segmentDurationSec - self.AnalInterface.f2s(tgtseg.seek)
				segidxt = superimp.test('segidx', segidx, self.ops.SUPERIMPOSE.minSegment, self.ops.SUPERIMPOSE.maxSegment)
				overt = superimp.test('overlap', tif, self.ops.SUPERIMPOSE.minOverlap, self.ops.SUPERIMPOSE.maxOverlap)
				onsett = superimp.test('onset', tif, self.ops.SUPERIMPOSE.minOnset, self.ops.SUPERIMPOSE.maxOnset)
				trigVal = tgtseg.thresholdTest(tgtseg.seek, self.AnalInterface.tgtOnsetDescriptors)
				trig = trigVal >= self.tgt.segmentationThresh
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
					tgtseg.seek += self.ops.SUPERIMPOSE.incr
					continue # next frame
				##############################################################
				## see if a selection should be forced without thresholding ##
				##############################################################
				if 'force' not in [onsett, overt, segidxt]: # test for amplitude threshold
					if not trig:
						superimp.skip('target too soft', trigVal, timeInSec)
						tgtseg.seek += self.ops.SUPERIMPOSE.incr
						continue # not loud enough, next frame
				##############################
				## get valid corpus handles ##
				##############################
				validSegments = self.cps.evaluateValidSamples(tif, timeInSec, tgtseg.idx, self.ops.ROTATE_VOICES, self.ops.VOICE_PATTERN, self.ops.VOICE_TO_ONSET_MAPPING, self.ops.CLUSTER_MAPPING, tgtseg.classification, superimp, self.instruments)
				if len(validSegments) == 0:
					superimp.skip('no corpus sounds made it past restrictions and limitations', None, timeInSec)
					tgtseg.seek += self.ops.SUPERIMPOSE.incr
					continue		
				distanceCalculations.setCorpus(validSegments)
				################################################
				## search and see if we find a winning sample ##
				################################################
				returnBool = distanceCalculations.executeSearch(tgtseg, tgtseg.seek, self.ops.SEARCH, self.ops.SUPERIMPOSE, self.ops.RANDOMIZE_AMPLITUDE_FOR_SIM_SELECTION)
				if not returnBool: # nothing valid, so skip to new frame...
					superimp.skip('no corpus sounds made it through the search passes', None, timeInSec)
					tgtseg.seek += self.ops.SUPERIMPOSE.incr
					continue
				###################################################
				## if passing this point, picking a corpus sound ##
				###################################################
				superimp.pick(trig, trigVal, onsett, overt, segidxt, timeInSec)
				selectCpsseg = distanceCalculations.returnSearch()
				######################################
				## MODIFY CHOSEN SAMPLES AMPLITUDE? ##
				######################################
				minLen = min(tgtseg.lengthInFrames-tgtseg.seek, selectCpsseg.lengthInFrames)	
				if selectCpsseg.postSelectAmpBool:
					if selectCpsseg.postSelectAmpMethod == "lstsqr":
						try:
							leastSqrWholeLine = (np.linalg.lstsq(np.vstack([selectCpsseg.desc.get('power', stop=minLen)]).T, np.vstack([tgtseg.desc.get('power', stop=minLen)]).T)[0][0][0])
						except np.linalg.linalg.LinAlgError: # in case of incompatible dimensions
							leastSqrWholeLine = 0
							pass
					elif selectCpsseg.postSelectAmpMethod in ["power-seg", "power-mean-seg"]:
						tgtPower = tgtseg.desc.get(selectCpsseg.postSelectAmpMethod, start=tgtseg.seek)
						cpsPower = selectCpsseg.desc.get(selectCpsseg.postSelectAmpMethod)
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
				sourceAmpScale *= util.dbToAmp(self.ops.OUTPUT_GAIN_DB)
				sourceAmpScale *= util.dbToAmp(selectCpsseg.envDb)
				###################$###########################
				## subtract power and update onset detection ##
				###################$###########################
				if self.ops.SUPERIMPOSE.calcMethod != None:
					tgtseg.desc.mixture_subtract(selectCpsseg, sourceAmpScale*self.ops.SUPERIMPOSE.subtractScale, minLen, verbose=True)
				#####################################
				## mix chosen sample's descriptors ##
				#####################################
				if self.ops.SUPERIMPOSE.calcMethod == "mixture":
					#tgtseg.mixSelectedSamplesDescriptors(selectCpsseg, sourceAmpScale, tgtseg.seek, self.AnalInterface)
					tgtseg.desc.mixture_mix(selectCpsseg, sourceAmpScale, tgtseg.seek, self.AnalInterface.mixtureDescriptors)
					tgtseg.has_been_mixed = True
				#################################
				## append selected corpus unit ##
				#################################
				transposition = util.getTransposition(tgtseg, selectCpsseg)
				self.cps.updateWithSelection(selectCpsseg, timeInSec, segidx)
				cpsEffDur = selectCpsseg.desc.get('effDurFrames-seg')
				maxoverlaps = np.max(superimp.cnt['overlap'][tif:tif+minLen])
				eventTime = (timeInSec*self.ops.OUTPUTEVENT_TIME_STRETCH)+self.ops.OUTPUTEVENT_TIME_ADD
				oeObj = concatenativeclasses.outputEvent(selectCpsseg, eventTime, util.ampToDb(sourceAmpScale), transposition, superimp.cnt['selectionCount'], tgtseg, maxoverlaps, tgtsegdur, tgtseg.idx, self.ops.CSOUND_STRETCH_CORPUS_TO_TARGET_DUR, self.AnalInterface.f2s(1), self.ops.OUTPUTEVENT_DURATION_SELECT, self.ops.OUTPUTEVENT_DURATION_MIN, self.ops.OUTPUTEVENT_DURATION_MAX, self.ops.OUTPUTEVENT_ALIGN_PEAKS)
				self.outputEvents.append( oeObj )
		
				corpusname = os.path.split(self.cps.data['vcToCorpusName'][selectCpsseg.voiceID])[1]
				superimp.increment(tif, tgtseg.desc.get('effDurFrames-seg', start=tgtseg.seek), segidx, selectCpsseg, distanceCalculations.returnSearchPassText(), corpusname)

				self.instruments.increment(tif, tgtseg.desc.get('effDurFrames-seg', start=tgtseg.seek), oeObj)

				tgtseg.numberSelectedUnits += 1

				printLabel = "searching @ %.2f x %i"%(timeInSec, maxoverlaps+1)
				printLabel += ' '*(24-len(printLabel))
				printLabel += "search pass lengths: %s"%('  '.join(distanceCalculations.lengthAtPasses))
				self.p.percentageBarNext(lowerLabel=printLabel, incr=0)
				htmlSelectionTable.append(["%.2fx%i"%(timeInSec, int(maxoverlaps)+1), ] + distanceCalculations.lengthAtPassesVerbose )

		self.p.percentageBarClose(txt='Selected %i events'%len(self.outputEvents))
		self.p.maketable(htmlSelectionTable)





	def write_output_files(self):
		##########################################
		## sort self.outputEvents by start time ##
		##########################################
		self.outputEvents.sort(key=lambda x: x.timeInScore)


		###########################
		## temporal quantization ##
		###########################
		concatenativeclasses.quantizeTime(self.outputEvents, self.ops.OUTPUTEVENT_QUANTIZE_TIME_METHOD, float(self.ops.OUTPUTEVENT_QUANTIZE_TIME_INTERVAL), self.p)


		##################################
		## CORPUS OUTPUT CLASSIFICATION ##
		##################################
		if self.ops.OUTPUTEVENT_CLASSIFY['numberClasses'] > 1:
			classifications = descriptordata.soundSegmentClassification(self.ops.OUTPUTEVENT_CLASSIFY['descriptors'], [oe.sfseghandle for oe in self.outputEvents], numbClasses=self.ops.OUTPUTEVENT_CLASSIFY['numberClasses'])
			for cidx, classified in enumerate(classifications): self.outputEvents[cidx].classification = int(classified)	



		#########################################
		## target signal decomposition cleanup ##
		#########################################
		if self.tgt.decompose != {}:
			for oeidx, oe in enumerate(self.outputEvents): 
				self.outputEvents[oeidx].decomposedstream = int(oe.timeInScore/self.tgt.decompose['origduration'])
				oe.timeInScore = oe.timeInScore%self.tgt.decompose['origduration']
			self.tgt.filename = self.tgt.decompose['origfilename']
			self.tgt.startSec = 0
			self.tgt.endSec = self.tgt.decompose['origduration']
			self.AnalInterface.rawData[self.tgt.decompose['origfilename']] = {'info': {'channels': 1, 'lengthsec': self.tgt.decompose['origduration']}}



		#########################
		## CREATE OUTPUT FILES ##
		#########################
		self.p.logsection( "OUTPUT FILES" )
		allusedcpsfiles = list(set([oe.filename for oe in self.outputEvents]))


		self.instruments.write(self.outputEvents)


		######################
		## dict output file ##
		######################
		if self.ops.DICT_OUTPUT_FILEPATH != None:
			output = {}
			output['self.opsfilename'] = self.ops.opsfilehead
			output['self.opsfiledata'] = self.ops.opsfileAsString
			# make target segment dict list
			self.tgt.segs.sort(key=operator.attrgetter('segmentStartSec'))
			tgtSegDataList = []
			for ts in self.tgt.segs:
				thisSeg = {'startSec': ts.segmentStartSec, 'endSec': ts.segmentEndSec}
				thisSeg['power'] = ts.desc.get('power-seg')
				thisSeg['numberSelectedUnits'] = ts.numberSelectedUnits
				thisSeg['has_been_mixed'] = ts.has_been_mixed
				tgtSegDataList.append(thisSeg)
			# finish up
			output['target'] = {'filename': self.tgt.filename, 'sfSkip': self.tgt.startSec, 'duration': self.tgt.endSec-self.tgt.startSec, 'segs': tgtSegDataList, 'fileduation': self.AnalInterface.rawData[self.tgt.filename]['info']['lengthsec'], 'chn': self.AnalInterface.rawData[self.tgt.filename]['info']['channels']} 
			output['corpus_file_list'] = list(set(allusedcpsfiles))
			output['selectedEvents'] = [oe.makeDictOutput() for oe in self.outputEvents]
			output['outputparse'] = {'simultaneousSelections': int(max([d['simultaneousSelectionNumber'] for d in output['selectedEvents']])+1), 'classifications': max(self.ops.OUTPUTEVENT_CLASSIFY['numberClasses'], 1), 'corpusIds': int(max([d['corpusIdNumber'] for d in output['selectedEvents']])+1)}
			fh = open(self.ops.DICT_OUTPUT_FILEPATH, 'w')
			json.dump(output, fh)
			fh.close()
			self.p.log( "Wrote JSON dict file %s\n"%self.ops.DICT_OUTPUT_FILEPATH )

		#####################################
		## maxmsp list output pour gilbert ##
		#####################################
		if self.ops.MAXMSP_OUTPUT_FILEPATH != None:
			output = {}
			output['target_file'] = [self.tgt.filename, self.tgt.startSec*1000., self.tgt.endSec*1000.]
			output['events'] = [oe.makeMaxMspListOutput() for oe in self.outputEvents]
			output['corpus_files'] = allusedcpsfiles
			fh = open(self.ops.MAXMSP_OUTPUT_FILEPATH, 'w')
			json.dump(output, fh)
			fh.close()
			self.p.log( "Wrote MAX/MSP JSON lists to file %s\n"%self.ops.MAXMSP_OUTPUT_FILEPATH )
	
		######################
		## midi output file ##
		######################
		if self.ops.MIDI_FILEPATH != None:
			import midifile
			MyMIDI = midifile.MIDIFile(1)
			MyMIDI.addTrackName(0, 0., "AudioGuide Track")
			MyMIDI.addTempo(0, 0., self.ops.MIDIFILE_TEMPO)
			temposcalar = self.ops.MIDIFILE_TEMPO/60.
			for oe in self.outputEvents:
				MyMIDI.addNote(0, 0, oe.midiPitch, oe.timeInScore*temposcalar, oe.duration*temposcalar, oe.midiVelocity)
			binfile = open(self.ops.MIDI_FILEPATH, 'wb')
			MyMIDI.writeFile(binfile)
			binfile.close()
			self.p.log( "Wrote MIDIfile %s\n"%self.ops.MIDI_FILEPATH )

		###################################
		## superimpose label output file ##
		###################################
		if self.ops.OUTPUT_LABEL_FILEPATH != None:
			fh = open(self.ops.OUTPUT_LABEL_FILEPATH, 'w')
			fh.write( ''.join([ oe.makeLabelText() for oe in self.outputEvents ]) )
			fh.close()
			self.p.log( "Wrote superimposition label file %s\n"%self.ops.OUTPUT_LABEL_FILEPATH )

		#######################################
		## corpus segmented features as json ##
		#######################################
		if self.ops.CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH != None:
			fh = open(self.ops.CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH, 'w')
			alldata = {}
			for c in self.cps.postLimitSegmentNormList:
				descs = {}
				for name, obj in c.desc.nameToObjMap.items():
					if name.find('-seg') != -1:
						descs[ name ] = obj.get(0, c.desc.len)
				alldata[(c.filename+'@'+str(c.segmentStartSec))] = descs
			json.dump(alldata, fh)
			fh.close()
			self.p.log( "Wrote corpus segmented features file %s\n"%self.ops.CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH )


		######################
		## lisp output file ##
		######################
		if self.ops.LISP_OUTPUT_FILEPATH != None:
			fh = open(self.ops.LISP_OUTPUT_FILEPATH, 'w')
			fh.write('(' + ''.join([ oe.makeLispText() for oe in self.outputEvents ]) +')')
			fh.close()
			self.p.log( "Wrote lisp output file %s\n"%self.ops.LISP_OUTPUT_FILEPATH )

		########################################
		## data from segmentation file output ##
		########################################
		if self.ops.DATA_FROM_SEGMENTATION_FILEPATH != None:
			fh = open(self.ops.DATA_FROM_SEGMENTATION_FILEPATH, 'w')
			for line in [oe.makeSegmentationDataText() for oe in self.outputEvents]:
				fh.write(line)
			fh.close()
			self.p.log( "Wrote data from segmentation file to textfile %s\n"%self.ops.DATA_FROM_SEGMENTATION_FILEPATH )

		########################
		## csound output file ##
		########################
		if self.ops.CSOUND_CSD_FILEPATH != None:
			from audioguide import csoundinterface as csd
			maxOverlaps = np.max([oe.simSelects for oe in self.outputEvents])
			csSco = 'i2  0.  %f  %f  "%s"  %f\n\n'%(self.tgt.endSec-self.tgt.startSec, self.tgt.whole.envDb, self.tgt.filename, self.tgt.startSec)
	
			# just in case that there are negative p2 times!
			minTime = min([ oe.timeInScore for oe in self.outputEvents ])
			if minTime < 0:
				for oe in self.outputEvents:
					oe.timeInScore -= minTime
			csSco += ''.join([ oe.makeCsoundOutputText(self.ops.CSOUND_CHANNEL_RENDER_METHOD) for oe in self.outputEvents ])
			csd.makeConcatenationCsdFile(self.ops.CSOUND_CSD_FILEPATH, self.ops.CSOUND_RENDER_FILEPATH, self.ops.CSOUND_CHANNEL_RENDER_METHOD, self.ops.CSOUND_SR, self.ops.CSOUND_KSMPS, csSco, self.cps.len, set([oe.sfchnls for oe in self.outputEvents]), maxOverlaps, self.instruments, self.ops.OUTPUTEVENT_CLASSIFY['numberClasses'], bits=self.ops.CSOUND_BITS)
			self.p.log( "Wrote csound csd file %s\n"%self.ops.CSOUND_CSD_FILEPATH )
			if self.ops.CSOUND_RENDER_FILEPATH != None:
				csd.render(self.ops.CSOUND_CSD_FILEPATH, len(self.outputEvents), printerobj=self.p)
				self.p.log( "Rendered csound soundfile output %s\n"%self.ops.CSOUND_RENDER_FILEPATH )
	
			if self.ops.CSOUND_NORMALIZE:
				csd.normalize(self.ops.CSOUND_RENDER_FILEPATH, db=self.ops.CSOUND_NORMALIZE_PEAK_DB)


		####################
		## close log file ##
		####################
		if self.ops.HTML_LOG_FILEPATH != None: self.p.writehtmllog(self.ops.HTML_LOG_FILEPATH)
	
		if self.ops.CSOUND_CSD_FILEPATH != None and self.ops.CSOUND_RENDER_FILEPATH != None and self.ops.CSOUND_PLAY_RENDERED_FILE:
			csd.playFile( self.ops.CSOUND_RENDER_FILEPATH )

