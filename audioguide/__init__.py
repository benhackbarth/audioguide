############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

__author__ = "Benjamin Hackbarth, Norbert Schnell, Philippe Esling, Diemo Schwarz, Gilbert Nouno"
__author_email__ = "hackbarth@gmail.com"
__version__ = "1.71"




import sys, os, operator, platform, json
import numpy as np

import audioguide.util as util
import audioguide.sfsegment as sfsegment
import audioguide.userinterface as userinterface
import audioguide.concatenativeclasses as concatenativeclasses
import audioguide.anallinkage as anallinkage
import audioguide.descriptordata as descriptordata
import audioguide.musicalwriting as musicalwriting
import audioguide.simcalc as simcalc
import audioguide.tests as tests
import audioguide.dimscaling as dimscaling




class main:
	def __init__(self):
		self.ops = concatenativeclasses.parseOptionsV2()

	def set_option(self, optionname, optionvalue):
		self.ops.set_option(optionname, optionvalue)

	def parse_options_dict(self, opsdict, init=False):
		for optionname, optionvalue in opsdict.items():
			self.ops.set_option(optionname, optionvalue, init=init)

	def parse_options_file(self, opspath, init=False):
		usrOptions = self.ops.parse_file(opspath)
		self.parse_options_dict(usrOptions, init=init)
		return os.path.getmtime(opspath)

	def execute(self, print_steps=False):
		'''execute runs all parts of the concatenative code depending on what options have changed'''
		initanal, target, corpus, norm, concate, output = self.ops.poll_options()
		files = {}
		if initanal:
			if print_steps: print("1. initializing analysis interface")
			self.initialize_analysis_interface()
		if target:
			if print_steps: print("2. loading target")
			self.load_target()
			self.write_target_output_files()
		if corpus:
			if print_steps: print("3. loading corpus")
			self.load_corpus()
		if norm:
			if print_steps: print("4. normalizing")
			self.normalize()
		if concate:
			if print_steps: print("5. concatenating")
			self.standard_concatenate()
		if output:
			if print_steps: print("6. writing outputs")
			files = self.write_concatenate_output_files()
		self.ops.rewind() # clear list for future options changes
		return files
		

	def initialize_analysis_interface(self, printversion=True):
		if 'concateMethod' in self.ops.EXPERIMENTAL and self.ops.EXPERIMENTAL['concateMethod'] == 'framebyframe':
			util.error("CONFIG", "Frame by frame concatenation is only possible with the agConcatenateFrames.py script.")
		self.p = userinterface.printer(self.ops.VERBOSITY, os.path.dirname(__file__), self.ops.HTML_LOG_FILEPATH)
		if printversion: self.p.printProgramInfo(__version__)
		self.AnalInterface = self.ops.createAnalInterface(self.p)


	def load_target(self):
		self.p.logsection( "TARGET" )
		self.tgt = sfsegment.target(self.ops.TARGET, self.AnalInterface)
		self.tgt.initAnal(self.AnalInterface, self.ops, self.p)
		self.tgt.stageSegments(self.AnalInterface, self.ops, self.p)

		if len(self.tgt.segs) == 0:
			util.error("TARGET FILE", "no segments found!  this is rather strange.  could your target file %s be digital silence??"%(self.tgt.filename))
		self.p.log("TARGET SEGMENTATION: found %i segments with an average length of %.3f seconds"%(len(self.tgt.segs), np.average(self.tgt.seglengths)))

		descriptors = []
		dnames = []
		self.ops.parseDescriptors()
		for dobj in self.ops._normalizeDescriptors + self.ops._limitDescriptors:
			if dobj.seg or dobj.name in ['power']: continue
			d = np.array(self.tgt.whole.desc.get(dobj.name, copy=True))
			d -= np.min(d)
			d /= np.max(d)
			d = np.around(d, 2)
	
			descriptors.append(d)
			dnames.append(dobj.name)
		if self.p.html != None:
			self.p.html.jschart_timeseries(yarray=np.array([self.AnalInterface.f2s(i) for i in range(self.tgt.whole.lengthInFrames)]), xarrays=descriptors, ylabel='time in seconds', xlabels=dnames)

	def write_target_output_files(self):	
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
			self.tgt.whole.desc.writedict(self.ops.TARGET_DESCRIPTORS_FILEPATH, ag.AnalInterface)
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
		htmlCorpusTable.append(['power', np.min(power), np.max(power), np.mean(power)])
		self.p.maketable(htmlCorpusTable, resolution=5)




	def dimensional_scale_data(self):
		self.ops.parseDescriptors()
		dimscaling.buildarray_all_timevarying_descriptors(self.tgt.segs + self.cps.postLimitSegmentNormList, self.ops._normalizeDescriptors, self.AnalInterface)
		from userclasses import SearchPassOptionsEntry as spass
		from userclasses import SingleDescriptor as d
		self.ops.SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=25),
spass('closest', d('X', norm=1), d('Y', norm=1))
]



	def normalize(self):
		###################
		## NORMALIZATION ##
		###################
		self.p.logsection( "NORMALIZATION" )
		self.ops.parseDescriptors()
		self.AnalInterface.desc_manager.normalize(self.tgt.segs + self.cps.postLimitSegmentNormList, self.ops._normalizeDescriptors)
		###########################################################################
		## get raw and normalized segemented desciptors for graphing in log.html ##
		###########################################################################
		self.p.makeHtmlChartDescriptorNorm(self.ops._normalizeDescriptors+self.ops._limitDescriptors, self.ops._normalizeDescriptors, self.tgt.segs, self.cps.postLimitSegmentNormList)	
		
	
		
	
	
	def standard_concatenate(self):
		##############################
		## initialise concatenation ##
		##############################
		self.p.logsection( "CONCATENATION" )
		self.tgt.setupConcate(self.ops._mixtureDescriptors)
		self.AnalInterface.done(dataGbLimit=self.ops.DESCRIPTOR_DATABASE_SIZE_LIMIT, dataDayLimit=self.ops.DESCRIPTOR_DATABASE_AGE_LIMIT)
		distanceCalculations = simcalc.distanceCalculations(self.ops.SUPERIMPOSE, self.ops.RANDOM_SEED, self.AnalInterface, self.tgt.segs, self.p)
		distanceCalculations.setTarget(self.ops.SEARCH, self.tgt.segs)

		self.instruments = musicalwriting.instruments(self.ops.INSTRUMENTS, self.ops.CORPUS, self.tgt.lengthInFrames, self.cps.postLimitSegmentNormList, self.AnalInterface.hopLengthSec, self.p)

		superimp = concatenativeclasses.SuperimposeTracker(self.tgt.lengthInFrames, len(self.tgt.segs), self.ops.SUPERIMPOSE.overlapAmpThresh, self.ops.SUPERIMPOSE.peakAlign, self.ops.SUPERIMPOSE.peakAlignEnvelope, len(self.ops.CORPUS), self.ops.RESTRICT_CORPUS_OVERLAP_BY_STRING, self.p)
		superimp.setup_subtract(self.ops.SUPERIMPOSE.subtractScale, self.tgt.segs, self.cps.postLimitSegmentNormList)

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
				onsett = superimp.test('onset', tif, self.ops.SUPERIMPOSE.minFrame, self.ops.SUPERIMPOSE.maxFrame)
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
				returnBool = distanceCalculations.executeSearch(tgtseg, tgtseg.seek, self.ops.SEARCH, self.ops.SUPERIMPOSE)
				if not returnBool: # nothing valid, so skip to new frame...
					superimp.skip('no corpus sounds made it through the search passes', None, timeInSec)
					tgtseg.seek += self.ops.SUPERIMPOSE.incr
					continue
				###################################################
				## if passing this point, picking a corpus sound ##
				###################################################
				superimp.pick(trig, trigVal, onsett, overt, segidxt, timeInSec)
				selectCpsseg = distanceCalculations.returnSearch()
				#####################################
				## MODIFY CHOSEN SAMPLES AMPLITUDE ##
				#####################################
				minLen = min(tgtseg.lengthInFrames-tgtseg.seek, selectCpsseg.lengthInFrames)	
				# apply amp scaling
				sourceAmpScale = util.dbToAmp(self.ops.OUTPUT_GAIN_DB)
				sourceAmpScale *= util.dbToAmp(selectCpsseg.envDb)
				###################$###########################
				## subtract power and update onset detection ##
				###################$###########################
				if self.ops.SUPERIMPOSE.calcMethod != None:
					tgtseg.desc.mixture_subtract(selectCpsseg, sourceAmpScale*superimp.subtract_scalar, minLen, verbose=True)
				#####################################
				## mix chosen sample's descriptors ##
				#####################################
				if self.ops.SUPERIMPOSE.calcMethod == "mixture":
					#tgtseg.mixSelectedSamplesDescriptors(selectCpsseg, sourceAmpScale, tgtseg.seek, self.AnalInterface)
					tgtseg.desc.mixture_mix(selectCpsseg, sourceAmpScale, tgtseg.seek, self.ops._mixtureDescriptors)
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





	def write_concatenate_output_files(self):
		dict_of_files_written = {}
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
		
		
		#################
		## BACH output ##
		#################	
		if self.ops.BACH_FILEPATH != None:
			self.instruments.write(self.ops.BACH_FILEPATH, self.tgt.segs, self.cps.data['vcToCorpusName'], self.outputEvents, self.ops.BACH_SLOTS_MAPPING, self.ops.BACH_TARGET_STAFF, self.ops.BACH_CORPUS_STAFF, addTarget=self.ops.BACH_INCLUDE_TARGET)
			dict_of_files_written['BACH_FILEPATH'] = self.ops.BACH_FILEPATH


		################
		## AAF output ##
		################
		if self.ops.AAF_FILEPATH != None:
			import audioguide.aaf as aaf
			this_aaf = aaf.output(self.ops.AAF_FILEPATH)
			if self.ops.AAF_INCLUDE_TARGET:
				this_aaf.addSoundfileResource(self.tgt.filename, self.AnalInterface.rawData[self.tgt.filename]['info'])
				this_aaf.makeTgtTrack(self.tgt)
			
			for cpsfile in allusedcpsfiles:
				this_aaf.addSoundfileResource(cpsfile, self.AnalInterface.rawData[cpsfile]['info'])
			this_aaf.makeCpsTracks(self.outputEvents, self.cps.data['vcToCorpusName'], self.ops.AAF_CPSTRACK_METHOD)
			this_aaf.done()
			dict_of_files_written['AAF_FILEPATH'] = self.ops.AAF_FILEPATH
			self.p.log( "Wrote aaf file %s\n"%self.ops.AAF_FILEPATH )


		################
		## RPP output ##
		################
		if self.ops.RPP_FILEPATH != None:
			import audioguide.reaper as rpp
			this_rpp = rpp.output(self.ops.RPP_FILEPATH)
			if self.ops.RPP_INCLUDE_TARGET:
				this_rpp.makeTgtTrack(self.tgt)
			this_rpp.makeCpsTracks(self.outputEvents, self.cps.data['vcToCorpusName'], self.ops.RPP_CPSTRACK_METHOD)
			this_rpp.write()
			dict_of_files_written['RPP_FILEPATH'] = self.ops.RPP_FILEPATH
			self.p.log( "Wrote rpp file %s\n"%self.ops.RPP_FILEPATH )



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
			dict_of_files_written['DICT_OUTPUT_FILEPATH'] = self.ops.DICT_OUTPUT_FILEPATH
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
			dict_of_files_written['MAXMSP_OUTPUT_FILEPATH'] = self.ops.MAXMSP_OUTPUT_FILEPATH
			self.p.log( "Wrote MAX/MSP JSON lists to file %s\n"%self.ops.MAXMSP_OUTPUT_FILEPATH )

		###################################
		## superimpose label output file ##
		###################################
		if self.ops.OUTPUT_LABEL_FILEPATH != None:
			fh = open(self.ops.OUTPUT_LABEL_FILEPATH, 'w')
			fh.write( ''.join([ oe.makeLabelText() for oe in self.outputEvents ]) )
			fh.close()
			dict_of_files_written['OUTPUT_LABEL_FILEPATH'] = self.ops.OUTPUT_LABEL_FILEPATH
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
			dict_of_files_written['CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH'] = self.ops.CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH
			self.p.log( "Wrote corpus segmented features file %s\n"%self.ops.CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH )


		######################
		## lisp output file ##
		######################
		if self.ops.LISP_OUTPUT_FILEPATH != None:
			fh = open(self.ops.LISP_OUTPUT_FILEPATH, 'w')
			fh.write('(' + ''.join([ oe.makeLispText() for oe in self.outputEvents ]) +')')
			fh.close()
			dict_of_files_written['LISP_OUTPUT_FILEPATH'] = self.ops.LISP_OUTPUT_FILEPATH
			self.p.log( "Wrote lisp output file %s\n"%self.ops.LISP_OUTPUT_FILEPATH )

		########################################
		## data from segmentation file output ##
		########################################
		if self.ops.DATA_FROM_SEGMENTATION_FILEPATH != None:
			fh = open(self.ops.DATA_FROM_SEGMENTATION_FILEPATH, 'w')
			for line in [oe.makeSegmentationDataText() for oe in self.outputEvents]:
				fh.write(line)
			fh.close()
			dict_of_files_written['DATA_FROM_SEGMENTATION_FILEPATH'] = self.ops.DATA_FROM_SEGMENTATION_FILEPATH
			self.p.log( "Wrote data from segmentation file to textfile %s\n"%self.ops.DATA_FROM_SEGMENTATION_FILEPATH )

		############################
		## csound CSD output file ##
		############################
		if self.ops.CSOUND_CSD_FILEPATH != None and self.ops.CSOUND_RENDER_FILEPATH != None:
			from audioguide import csoundinterface as csd
			maxOverlaps = np.max([oe.simSelects for oe in self.outputEvents])
			csSco = 'i2  0.  %f  %f  "%s"  %f  %i\n\n'%(self.tgt.endSec-self.tgt.startSec, self.tgt.whole.envDb, self.tgt.filename, self.tgt.startSec, int(self.ops.CSOUND_CHANNEL_RENDER_METHOD == 'targetoutputmix'))
	
			# just in case that there are negative p2 times!
			minTime = min([ oe.timeInScore for oe in self.outputEvents ])
			if minTime < 0:
				for oe in self.outputEvents:
					oe.timeInScore -= minTime
			csSco += ''.join([ oe.makeCsoundOutputText(self.ops.CSOUND_CHANNEL_RENDER_METHOD) for oe in self.outputEvents ])
			csd.makeConcatenationCsdFile(self.ops.CSOUND_CSD_FILEPATH, self.ops.CSOUND_RENDER_FILEPATH, self.ops.CSOUND_CHANNEL_RENDER_METHOD, self.ops.CSOUND_SR, self.ops.CSOUND_KSMPS, csSco, self.cps.len, set([oe.sfchnls for oe in self.outputEvents]), maxOverlaps, self.instruments, self.ops.OUTPUTEVENT_CLASSIFY['numberClasses'], bits=self.ops.CSOUND_BITS)
			dict_of_files_written['CSOUND_CSD_FILEPATH'] = self.ops.CSOUND_CSD_FILEPATH
			self.p.log( "Wrote csound csd file %s\n"%self.ops.CSOUND_CSD_FILEPATH )
			if self.ops.CSOUND_RENDER_FILEPATH != None:
				csd.render(self.ops.CSOUND_CSD_FILEPATH, len(self.outputEvents), printerobj=self.p)
				self.p.log( "Rendered csound soundfile output %s\n"%self.ops.CSOUND_RENDER_FILEPATH )
				dict_of_files_written['CSOUND_RENDER_FILEPATH'] = self.ops.CSOUND_RENDER_FILEPATH
	
			if self.ops.CSOUND_NORMALIZE:
				csd.normalize(self.ops.CSOUND_RENDER_FILEPATH, db=self.ops.CSOUND_NORMALIZE_PEAK_DB)
		################################
		## csound simple score output ##
		################################
		if self.ops.CSOUND_SCORE_FILEPATH != None:
			from audioguide import csoundinterface as csd
			csSco = csd.instru2helpstring()+'\n'
			csSco += ''.join([ oe.makeCsoundOutputText(self.ops.CSOUND_CHANNEL_RENDER_METHOD) for oe in self.outputEvents ])
			fh = open(self.ops.CSOUND_SCORE_FILEPATH, 'w')
			fh.write(csSco)
			fh.close()
		####################
		## close log file ##
		####################
		if self.ops.HTML_LOG_FILEPATH != None:
			self.p.writehtmllog(self.ops.HTML_LOG_FILEPATH)
			dict_of_files_written['HTML_LOG_FILEPATH'] = self.ops.HTML_LOG_FILEPATH
	
		if self.ops.CSOUND_CSD_FILEPATH != None and self.ops.CSOUND_RENDER_FILEPATH != None and self.ops.CSOUND_PLAY_RENDERED_FILE:
			csd.playFile( self.ops.CSOUND_RENDER_FILEPATH )

		return dict_of_files_written