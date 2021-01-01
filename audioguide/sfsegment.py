############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os
import audioguide.util as util
import audioguide.descriptordata as descriptordata
import numpy as np




class sfsegment:
	def __init__(self, filename, startSec, endSec, AnalInterface, envDb=+0, envAttackSec=0., envDecaySec=0., envSlope=1., envAttackenvDecayCushionSec=0.01, normtag='notag'):
		self.filename = util.verifyPath(filename, AnalInterface.searchPaths)
		self.soundfileExtension = os.path.splitext(self.filename)[1]
		self.printName = os.path.split(self.filename)[1] # short name for printing
		# filename-based descriptor info
		self.midipitch = None
		self.midiPitchFromFilename = descriptordata.getMidiPitchFromString(self.printName)
		self.rmsAmplitudeFromFilename, self.dynamicFromFilename = descriptordata.getDynamicFromFilename(self.printName, AnalInterface.dynToDbDict, AnalInterface.stringToDynDict, notFound=-1000)
		# other info
		self.soundfileTotalDuration, self.soundfileChns = AnalInterface.validateAnalResource(self.filename)
		self.segmentStartSec = startSec
		self.segmentEndSec = endSec
		self.envDb = util.getScaleDb(envDb, self)
		self.envAttack = envAttackSec
		self.envDecay = envDecaySec
		self.envSlope = envSlope
		if self.segmentStartSec == None: self.segmentStartSec = 0
		else: self.segmentStartSec = self.segmentStartSec
		if self.segmentEndSec == None: self.segmentEndSec = self.soundfileTotalDuration
		else: self.segmentEndSec = self.segmentEndSec
		self.segmentDurationSec = self.segmentEndSec-self.segmentStartSec		
		# ensure length is at least 1 frame
		self.lengthInFrames = max(1, AnalInterface.getSegmentFrameLength(self.segmentStartSec, self.segmentDurationSec, self.filename))
		self.f2s = AnalInterface.f2s(1)
		##############################################################
		## check to make sure all user supplied values check out OK ##
		##############################################################
		self.testForInitErrors(AnalInterface)
		################
		## other shit ##
		################
		self.segmentHash = util.listToCheckSum([self.filename, self.segmentStartSec, self.segmentEndSec, self.envDb, self.envAttack, self.envDecay, self.envSlope])
		####################################
		## get information about envelope ##
		####################################
		self.envAttackSec = util.getDurationFromValueOrString(self.envAttack, self.segmentDurationSec)
		self.envDecaySec = util.getDurationFromValueOrString(self.envDecay, self.segmentDurationSec)
		if (self.envAttackSec+self.envDecaySec+envAttackenvDecayCushionSec) > self.segmentDurationSec:
			self.envDecaySec = self.segmentDurationSec-self.envAttackSec-envAttackenvDecayCushionSec
		self.envAttackFrames = int(round(AnalInterface.s2f(self.envAttackSec, self.filename)))
		self.envDecayFrames = int(round(AnalInterface.s2f(self.envDecaySec, self.filename)))
		if (self.envAttackFrames+self.envDecayFrames) > self.lengthInFrames:
			if self.envAttackFrames > self.envDecayFrames: self.envAttackFrames = self.lengthInFrames-self.envDecayFrames
			else: self.envDecayFrames = self.lengthInFrames-self.envAttackFrames			
		if self.envAttackFrames <= 1 and self.envDecayFrames <= 1:
			self.envelopeMask = util.dbToAmp(self.envDb)
		else:
			self.envelopeMask = np.ones(self.lengthInFrames)
			if self.envAttackFrames > 0:
				self.envelopeMask[:self.envAttackFrames] = np.linspace(1/float(self.envAttackFrames), 1, num=self.envAttackFrames)
			if self.envDecayFrames > 0:
				self.envelopeMask[self.envDecayFrames*-1:] = np.linspace(1, 1/float(self.envDecayFrames), num=self.envDecayFrames)
			self.envelopeMask = np.power(self.envelopeMask, self.envSlope)
			self.envelopeMask *= util.dbToAmp(self.envDb)
		########################################
		## manage duration and time-in-frames ##
		########################################
		self.segmentStartFrame = AnalInterface.getSegmentStartInFrames(self.filename, self.segmentStartSec, self.segmentEndSec, self.lengthInFrames)
		###############################
		## initalise descriptor data ##
		###############################
		self.desc = AnalInterface.desc_manager.create_sf_descriptor_obj(self, AnalInterface.getDescriptorMatrix(self.filename), self.segmentStartFrame, self.lengthInFrames, tag=normtag, envelope=self.envelopeMask)
		self.triggerinit = False
	###################################################
	def initThresholdTest(self, onsetDescriptorDict):		
		# get min / max of trigger descriptors
		self.mins = {}
		self.maxs = {}
		for dname, weight in onsetDescriptorDict.items():
			self.mins[dname] = np.min(self.desc.get(dname))
			self.maxs[dname] = np.max(self.desc.get(dname))
		self.triggerinit = True
	###################################################
	def thresholdTest(self, time, onsetDescriptorDict):		
		if not self.triggerinit: self.initThresholdTest(onsetDescriptorDict) # only once!
		trig = 0.
		weightsum = 0.
		for dname, weight in onsetDescriptorDict.items():
			value = self.desc.get(dname, start=time, stop=time+1)
			if dname.find('power') != -1 or value < 0.:
				trigadd = value / self.maxs[dname]
			else:
				trigadd = value / self.mins[dname] # for non-power descriptors that are greater than 0.!
			trig += trigadd * weight
			weightsum += weight
		return util.ampToDb(trig)/weightsum
	#################################
	#################################
	def testForInitErrors(self, AnalInterface):
		# test self.filename
		oneframesec = AnalInterface.f2s(1)
		if not os.path.exists(self.filename):
			util.error('sfsegment init', 'file does not exist: \t%s\n'%self.filename)
		if self.soundfileExtension.lower() not in AnalInterface.validSfExtensions:
			util.error('sfsegment init', 'file is not an accepted soundfile type: \t%s\n'%self.filename)
		# test that startSec is sane
		if self.segmentStartSec < 0:
			util.error('sfsegment init', 'startSec is less than 0!!')
		if self.segmentStartSec >= self.segmentEndSec:
			util.error('sfsegment init', 'startSec is greater than its endSec!!')
		# test if requested read too long
		if self.segmentEndSec > self.soundfileTotalDuration+(oneframesec/2.):
			print('\n\nWARNING endSec (%.2f) is longer than the file\'s duration(%.2f)!!  Truncating to filelength.\n\n'%(self.segmentEndSec, self.soundfileTotalDuration))
			self.segmentEndSec = self.soundfileTotalDuration
			#util.error('sfsegment init', 'endSec is after the the file\'s duration!!')
	#################################
	#################################
	def __str__(self, length=50):
		prints = []
		for k, v in vars(self).items():
			valueStr = str(v)
			if len(valueStr) > length: valueStr = valueStr[:length-3]+'...'
			prints.append('\t%s : %s'%(k, valueStr))
		prints.sort() # alphabetize
		return '''<sfsegment object>\n'''+'\n'.join(prints)
	#################################





class corpusSegment(sfsegment):
	'''Inherits sfsegment and adds additional attributes
	used uniquely by corpus segments.'''
	def __init__(self, filename, startSec, endSec, envDb, envAttackSec, envDecaySec, envSlope, AnalInterface, concatFileName, userCpsStr, voiceID, midiPitchMethod, limitObjList, pitchfilter, scaleDistance, superimposeRule, transMethod, transQuantize, allowRepetition, restrictInTime, restrictOverlaps, restrictRepetition, segfileData, metadata, clipDurationToTarget, instrTag, instrParams, normtag='cps'):
		# initalise the sound segment object	
		sfsegment.__init__(self, filename, startSec, endSec, AnalInterface, envDb=envDb, envAttackSec=envAttackSec, envDecaySec=envDecaySec, envSlope=envSlope, normtag='cps')
		# additional corpus-specific data
		self.userCpsStr = userCpsStr
		self.concatFileName = concatFileName
		self.voiceID = voiceID
		self.midiPitchMethod = midiPitchMethod
		self.limitObjList = limitObjList
		self.pitchfilter = pitchfilter
		self.scaleDistance = scaleDistance
		self.superimposeRule = superimposeRule
		self.transMethod = transMethod
		self.transQuantize = transQuantize
		self.allowRepetition = allowRepetition
		self.restrictOverlaps = restrictOverlaps
		self.restrictRepetition = restrictRepetition
		self.sim_accum = 0. # for similarity calculations
		self.segfileData = segfileData
		self.classification = 0
		self.metadata = metadata
		self.clipDurationToTarget = clipDurationToTarget
		self.instrTag = instrTag
		self.instrParams = instrParams






class targetSegment(sfsegment):
	'''Inherits class of sfsegment and adds additional attributes
	used by target segments.'''
	def __init__(self, filename, segmentidx, startSec, endSec, envDb, envAttackSec, envDecaySec, envSlope, AnalInterface, midiPitchMethod):
		# initalise the sound segment object	
		sfsegment.__init__(self, filename, startSec, endSec, AnalInterface, envDb=envDb, envAttackSec=envAttackSec, envDecaySec=envDecaySec, envSlope=envSlope, normtag='tgt')
		# additional target-specific data
		self.midiPitchMethod = midiPitchMethod
		self.idx = segmentidx









class target: # the target
	def __init__(self, userOptsTargetObject, AnalInterface):
		self.filename = userOptsTargetObject.filename
		self.filename = util.verifyPath(self.filename, AnalInterface.searchPaths)
		self.filename = os.path.abspath(self.filename)
		self.startSec = userOptsTargetObject.start
		self.endSec = userOptsTargetObject.end
		
		# check for signal decomposition
		self.decompose = userOptsTargetObject.decompose
		if self.decompose != {}:
			if self.startSec == None: self.startSec = 0
			import audioguide.signaldecompose as signaldecompose
			newtargetpath, origtargetduration = signaldecompose.decomposeTargetSf(self.filename, self.startSec, self.endSec, self.decompose)
			self.decompose['origfilename'] = self.filename
			self.decompose['origduration'] = origtargetduration
			self.filename = newtargetpath
	

		self.segmentationThresh = userOptsTargetObject.thresh
		self.segmentationOffsetRise = userOptsTargetObject.offsetRise
		self.segmentationOffsetThreshAdd = userOptsTargetObject.offsetThreshAdd
		self.segmentationOffsetThreshAbs = userOptsTargetObject.offsetThreshAbs
		self.segmentationMinLenSec = userOptsTargetObject.minSegLen
		self.segmentationMaxLenSec = userOptsTargetObject.maxSegLen

		self.envDb = userOptsTargetObject.scaleDb
		self.midiPitchMethod = userOptsTargetObject.midiPitchMethod
		self.stretch = userOptsTargetObject.stretch
		self.segmentationFilepath = userOptsTargetObject.segmentationFilepath		
		# multirise corpus segmentation ?
		self.multiriseBool = userOptsTargetObject.multiriseBool
		self.multirisePercentDev = userOptsTargetObject.multirisePercentDev
		self.multiriseSteps = userOptsTargetObject.multiriseSteps
	########################################
#	def timeStretch(self, AnalInterface, ops, p):
#		self.filename = util.initStretchedSoundfile(self.filename, self.startSec, self.endSec, self.stretch, AnalInterface.supervp_bin, p=p)
#		self.startSec = 0 # this now gets reset, as starttime was considered when making the stretched file
#		self.endSec = None # this now gets reset, as endtime was considered when making the stretched file
	########################################
	def initAnal(self, AnalInterface, ops, p):
		# Start by loading the entire target as an 
		# sfsegment to get the whole amplitude envelope.
		# see if we need to time stretch the target file...
		if self.stretch != 1:
			self.timeStretch(AnalInterface, ops, p)
		# analise the whole target sound!
		self.whole = sfsegment(self.filename, self.startSec, self.endSec, AnalInterface, envDb=self.envDb, normtag='tgtwhole')
		self.startSec = self.whole.segmentStartSec
		self.endSec = self.whole.segmentEndSec
		self.whole.midiPitchMethod = self.midiPitchMethod
		self.lengthInFrames = self.whole.lengthInFrames

		# SEGMENTATION DATA CONTAINERS
		self.segs = []
		self.segmentationInFrames = []
		self.segmentationInOnsetFrames = []
		self.extraSegmentationData = []
		self.seglengths = []		


		# SEGMENTATION
		power = AnalInterface.getDescriptorColumn(self.filename, 'power')
		self.segmentationMinLenFrames = AnalInterface.s2f(self.segmentationMinLenSec, self.filename)
		self.segmentationMaxLenFrames = AnalInterface.s2f(self.segmentationMaxLenSec, self.filename)
		p.log("TARGET SEGMENTATION: minimum segment length %.3f sec; maximum %.3f sec"%(self.segmentationMinLenSec, self.segmentationMaxLenSec))
		self.minPower = min(power)
		if self.minPower < util.dbToAmp(self.segmentationOffsetThreshAbs): # use absolute threshold
			self.powerOffsetValue = util.dbToAmp(self.segmentationOffsetThreshAbs)
			p.log("TARGET SEGMENTATION: using an offset amplitude value of %s"%(self.segmentationOffsetThreshAbs))
		else:
			self.powerOffsetValue = self.minPower*util.dbToAmp(self.segmentationOffsetThreshAdd)
			p.log("TARGET SEGMENTATION: the amplitude of %s never got below the offset threshold of %sdB specified in offsetThreshAbs.  So, I'm using offsetThreshAdd dB (%.2f) above the minimum found power -- a value of %.2f dB."%(self.filename, self.segmentationOffsetThreshAdd, self.segmentationOffsetThreshAdd, util.ampToDb(self.powerOffsetValue)))
	
		if self.segmentationFilepath == None:
			import descriptordata
			odf = descriptordata.odf(power, 7)
			# do multirise segmentation?
			if self.multiriseBool:
				multiriseDeviation = self.segmentationOffsetRise*(self.multirisePercentDev/100.)
				riseRatioList = np.linspace(max(1.05, self.segmentationOffsetRise-multiriseDeviation), self.segmentationOffsetRise+multiriseDeviation, num=self.multiriseSteps)
			else:
				# just use one rise ration
				riseRatioList = [self.segmentationOffsetRise]
				
			for userRiseRatio in riseRatioList: # this a list of rises if desired!
				segments, logic = segmentationAlgoV2(self.segmentationThresh, self.powerOffsetValue, userRiseRatio, power, odf, self.segmentationMinLenFrames, self.segmentationMaxLenFrames, AnalInterface)
				# ensure that each segment isn't in the list already
				for idx in range(len(segments)):
					if segments[idx] in self.segmentationInOnsetFrames: continue
					self.segmentationInOnsetFrames.append(segments[idx])
					if ops.TARGET_SEGMENT_LABELS_INFO == 'logic':
						self.extraSegmentationData.append(logic[idx])
			# end loop



			closebartxt = "Found %i segments (threshold=%.1f offsetrise=%.2f offsetthreshadd=%.2f)."%(len(self.segmentationInOnsetFrames), self.segmentationThresh, self.segmentationOffsetRise, self.segmentationOffsetThreshAdd)
		else: # load target segments from a file
			p.log("TARGET SEGMENTATION: reading segments from file %s"%(self.segmentationFilepath))
			for dataentry in util.readAudacityLabelFile(self.segmentationFilepath):
				startf = AnalInterface.s2f(dataentry[0], self.filename)
				endf = AnalInterface.s2f(dataentry[1], self.filename)
				self.segmentationInOnsetFrames.append((startf, endf))
				self.extraSegmentationData.append('from file')
			closebartxt = "Read %i segments from file %s"%(len(self.segmentationInFrames), os.path.split(self.segmentationFilepath)[1])
	########################################
	def stageSegments(self, AnalInterface, ops, p):
		###################################
		## make segment times in seconds ##
		###################################
		self.segmentationInSec = []
		self.segmentationInFrames = self.segmentationInOnsetFrames
		for start, end in self.segmentationInOnsetFrames:
			self.segmentationInSec.append((AnalInterface.f2s(start), AnalInterface.f2s(end)))
			self.seglengths.append(AnalInterface.f2s(end-start))

		if ops.TARGET_SEGMENT_LABELS_INFO != 'logic':
			for start, end in self.segmentationInFrames:
				self.extraSegmentationData.append('%.4f'%(self.whole.desc.get(ops.TARGET_SEGMENT_LABELS_INFO, start=start, stop=end) ))
		p.startPercentageBar(upperLabel="Evaluating TARGET %s from %.2f-%.2f"%(self.whole.printName, self.whole.segmentStartSec, self.whole.segmentEndSec), total=len(self.segmentationInSec))
		for sidx, (startSec, endSec) in enumerate(self.segmentationInSec):
			p.percentageBarNext(lowerLabel="@%.2f sec - %.2f sec"%(startSec, endSec))
			segment = targetSegment(self.filename, sidx, startSec, endSec, +0, 0.0001, 0.0001, 1, AnalInterface, self.midiPitchMethod)
			segment.power = segment.desc.get('power-seg') # for sorting
			self.segs.append(segment)


		if self.segmentationFilepath == None:
			closebartxt = "Found %i segments (threshold=%.1f offsetrise=%.2f offsetthreshadd=%.2f)."%(len(self.segmentationInOnsetFrames), self.segmentationThresh, self.segmentationOffsetRise, self.segmentationOffsetThreshAdd)
		else:
			closebartxt = "Read %i segments from file %s"%(len(self.segmentationInFrames), os.path.split(self.segmentationFilepath)[1])

		p.percentageBarClose(txt=closebartxt)
		################################################
		## evaluate midipitch for each target segment ##
		################################################
		descriptordata.evaluate_midipitches(self.segs, self.segs[0].midiPitchMethod)
		###################################
		## hack for signal decomposition ##
		###################################
		if 'origduration' in self.decompose:
			for s in self.segs:
				s.decomposeSfSkip = s.segmentStartSec
				s.segmentStartSec = s.segmentStartSec % self.decompose['origduration']
				s.segmentEndSec = s.segmentStartSec + s.segmentDurationSec
				s.segmentStartFrame = AnalInterface.getSegmentStartInFrames(s.filename, s.segmentStartSec, s.segmentEndSec, s.lengthInFrames)
	########################################
	def writeSegmentationFile(self, filename):
		assert len(self.segmentationInSec) == len(self.extraSegmentationData)
		fh = open(filename, 'w')
		for sidx in range(len(self.segmentationInSec)):
			fh.write( "%f\t%f\t%s\n"%(self.segmentationInSec[sidx][0], self.segmentationInSec[sidx][1], self.extraSegmentationData[sidx]) )
		fh.close()
	########################################
	def setupConcate(self, mixturelist):
		from userclasses import SingleDescriptor as d
		self.powerStats = getDescriptorStatistics(self.segs, d('power'))
		# initalise mixture and add norm coeffs to mixables...
		for seg in self.segs:
			seg.seek = 0
			seg.selectiondone = False
			seg.classification = 0
			seg.numberSelectedUnits = 0
			seg.desc.rewind()
			seg.desc.init_mixture(mixturelist)
			seg.has_been_mixed = False
			seg.originalPeak = seg.desc.get('peakTime-seg') # keep original, unsubtacted peak
	########################################
	def plotMetrics(self, outputpath, AnalInterface, p, normalise=True):
		import matplotlib.pyplot as plt
		lengthTv = self.whole.lengthInFrames
		powers = self.whole.desc['power'][:]
		if normalise:
			powers -= np.min(powers)
			powers /= np.max(powers)

		for dobj in AnalInterface.requiredDescriptors:
			fig = plt.figure(figsize=(lengthTv/10., 10.))
			proot, pext = os.path.splitext(outputpath)
			
			savepath = proot + '-' + dobj.name + pext
			if dobj.seg or dobj.name in ['power']: continue
			vals = self.whole.desc[dobj.name][:]
			if normalise:
				vals -= np.min(vals)
				vals /= np.max(vals)
			
			plt.plot(range(lengthTv), vals, ls='steps-post', lw=1, label=[dobj.name])
			plt.plot(range(lengthTv), powers, ls='steps-post', lw=1, label=['power'])
			leg = plt.legend([dobj.name, 'power'],'upper right', shadow=False)
			frame  = leg.get_frame()  
			frame.set_facecolor('0.90')    # set the frame face color to light gray
			p.log("TARGET: plotted descriptor %s as %s"%(dobj.name, savepath))
			plt.savefig(savepath)
			plt.close()
	########################################
	def NEWplotMetrics(self, outputpath, AnalInterface, p):
		import matplotlib.pyplot as plt
		import matplotlib.ticker as ticker


		p = {'outputdir': '/Users/ben/Desktop', 'descriptors': [('mfcc1',), ('mfcc1', 'mfcc2', 'mfcc3', 'mfcc4'), ('mfcc1', 'power')], 'diminches': (10, 4), 'ext': '.jpg', }
		assert os.path.isdir(p['outputdir'])

		timearray = [AnalInterface.f2s(i) for i in range(len(self.whole.desc[p['descriptors'][0][0]][:]))]
		for dlist in p['descriptors']:
			savepath = os.path.join(p['outputdir'], '-'.join([d for d in dlist]) + p['ext'])
			
			
			fig, ax = plt.subplots(figsize=p['diminches'])
			for d in dlist:
				ax.plot(timearray, self.whole.desc.get(d)[:], ls='steps-post', lw=1)
			
			formatter = ticker.FormatStrFormatter('%1.1f')
			ax.xaxis.set_major_formatter(formatter)
			plt.savefig(savepath, bbox_inches=0, pad_inches=0.0)
			plt.close()

	########################################
	def plotSegmentation(self, outputpath, AnalInterface, p):
		import matplotlib.pyplot as plt
		powers = self.whole.desc.get('power')[:]
		powers -= np.min(powers)
		powers /= np.max(powers) # normalise between 0 and 1
		plotheight = 15.
		fig = plt.figure(figsize=(len(powers)/10., plotheight))
		plt.plot(range(len(powers)), powers, ls='steps-post', lw=1, label=['power'])
		for sidx in range(len(self.segmentationInFrames)): # plot segmentation
			xstart = self.segmentationInFrames[sidx][0]
			xend = self.segmentationInFrames[sidx][1]
			#print(self.segmentationInFrames[sidx], self.extraSegmentationData[sidx])
			plt.axvspan(xstart, xend, facecolor='#FFCCCC', alpha=1, ec='r', lw=1)
			plt.text(xstart, 0.5*plotheight, 'benny', fontsize=12, color='black')
		leg = plt.legend(['power'],'upper right', shadow=False)
		frame  = leg.get_frame()  
		frame.set_facecolor('0.90')    # set the frame face color to light gray
		p.log("TARGET: plotted segmentation to %s"%(outputpath))
		plt.savefig(outputpath)
		plt.close()





	
def segmentationAlgoV2(threshold_onset, threshold_offset, riseratio, powers, odf, minlen, maxlen, AnalInterface):
	f = 0
	maxpower = np.max(powers)
	segments = []
	logic = []
	while True:
		if f+minlen > len(odf): break
		trigVal = util.ampToDb(odf[f] / maxpower)				
		if trigVal < threshold_onset:
			f += 1
			continue
		# an onset because above trigger threshold
		segmentationLogicString = 'trig=%.2f'%trigVal
		s = minlen
		while True:
			# an offset if end of file is reached
			if f+s+1 >= len(odf):
				segmentationLogicString += ' eof=%.1f'%AnalInterface.f2s(len(powers))
				break
			# an offset if max seg length is reached
			if s+1 >= maxlen:
				segmentationLogicString += ' maxseglen=%.1f'%AnalInterface.f2s(maxlen)
				break			
			# an offset if amplitude is below offset threshold
			if powers[f+s] < threshold_offset:
				segmentationLogicString += ' drop=%.0f'%util.ampToDb(powers[f+s])
				break
			# an offset if riseratio is too large
			riseRatioTmp = powers[f+s+1]/powers[f+s]
			if riseRatioTmp >= riseratio:
				segmentationLogicString += ' rise=%.3f'%riseRatioTmp
				break
			s += 1

		segments.append((f, f+s))
		logic.append(segmentationLogicString)
		f += s
	return segments, logic




def getDescriptorStatistics(listOfSegmentObjs, descriptorObj, takeOnlyEffDur=True, stdDeltaDegreesOfFreedom=0):
	if descriptorObj.seg:
		allDescs = np.array([sfsObj.desc.get(descriptorObj.name) for sfsObj in listOfSegmentObjs])
	else:
		cnt = 0
		for sfsObj in listOfSegmentObjs: cnt += sfsObj.desc.get('effDurFrames-seg')
		allDescs = np.empty((cnt))
		cnt = 0
		for sfsObj in listOfSegmentObjs: 
			effDur = sfsObj.desc.get('effDurFrames-seg')
			allDescs[cnt:cnt+effDur] = sfsObj.desc.get(descriptorObj.name, stop=effDur)
			cnt += effDur
	return { 'min': np.min(allDescs), 'max': np.max(allDescs), 'mean': np.mean(allDescs),'stddev': np.std(allDescs, ddof=stdDeltaDegreesOfFreedom) }



