import sys, os
sys.path.append('/Users/ben/Documents/audioGuide/0-new')
#sys.path.append('/Users/ben/Documents/audioGuide/audioguide')
sys.path.append('/Users/ben/Documents/audioGuide/audioguide/pylib2.7-darwin-64')
import util, descriptordata
import numpy as np



class SfSegment:
	def __init__(self, filename, startSec, endSec, descriptors, SdifInterface, envDb=+0, envAttackSec=0., envDecaySec=0., envSlope=1., envAttackenvDecayCushionSec=0.01):
		self.filename = util.verifyPath(filename, SdifInterface.searchPaths)
		self.soundfileExtension = os.path.splitext(self.filename)[1]
		self.soundfileTotalDuration, self.soundfileChns = SdifInterface.validateSdifResource(self.filename)
		self.segmentStartSec = startSec
		self.segmentEndSec = endSec
		self.envDb = envDb
		self.envAttackSec = envAttackSec
		self.envDecaySec = envDecaySec
		self.envSlope = envSlope
		# if startSec=None, it is begninning
		# if endSec=None, it is end of file
		if self.segmentStartSec == None: self.segmentStartSec = 0
		else: self.segmentStartSec = self.segmentStartSec
		if self.segmentEndSec == None: self.segmentEndSec = self.soundfileTotalDuration
		else: self.segmentEndSec = self.segmentEndSec
		self.segmentDurationSec = self.segmentEndSec-self.segmentStartSec		
		##############################################################
		## check to make sure all user supplied values check out OK ##
		##############################################################
		self.testForInitErrors(SdifInterface)
		################
		## other shit ##
		################
		self.printName = os.path.split(self.filename)[1] # short name for printing
		self.segmentHash = util.listToCheckSum([self.filename, self.segmentStartSec, self.segmentEndSec, self.envDb, self.envAttackSec, self.envDecaySec, self.envSlope])
		self.midiPitchFromFilename = descriptordata.getMidiPitchFromString(self.printName)
		self.rmsAmplitudeFromFilename = util.getDynamicFromFilename(self.printName, notFound=-1000)
		####################################
		## get information about envelope ##
		####################################
		self.envAttackSec = util.getDurationFromValueOrString(self.envAttackSec, self.segmentDurationSec)
		self.envDecaySec = util.getDurationFromValueOrString(self.envDecaySec, self.segmentDurationSec)
		if (self.envAttackSec+self.envDecaySec+envAttackenvDecayCushionSec) > self.segmentDurationSec:
			self.envDecaySec = self.segmentDurationSec-self.envAttackSec-envAttackenvDecayCushionSec
		self.envAttackFrames = int(round(SdifInterface.s2f(self.envAttackSec, self.filename)))
		self.envDecayFrames = int(round(SdifInterface.s2f(self.envDecaySec, self.filename)))
		self.lengthInFrames = SdifInterface.s2f(self.segmentDurationSec, self.filename, minimum=1)
		if (self.envAttackFrames+self.envDecayFrames) > self.lengthInFrames:
			if self.envAttackFrames > self.envDecayFrames:
				self.envAttackFrames = self.lengthInFrames-self.envDecayFrames
			else:
				self.envDecayFrames = self.lengthInFrames-self.envAttackFrames			
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
		###############################
		## initalise descriptor data ##
		###############################
		self.desc = descriptordata.container(descriptors, self) # for storing descriptor values from disk
		# tells us which descriptors are:
		#	SdifDescList - loaded from SDIF analyses
		#	ComputedDescList - transformed from loaded descriptor data - delta, deltadelta, odf, etc.
		#	AveragedDescList - averaged descriptors from loaded descriptor data
		SdifDescList, ComputedDescList, AveragedDescList = self.desc.getDescriptorOrigins() 
		tmppy = {}
		self.segmentStartSec, self.segmentEndSec, self.segmentStartFrame, self.lengthInFrames = SdifInterface.getDescriptorSegment(self.filename, self.segmentStartSec, self.segmentEndSec, SdifDescList, tmppy, self.envelopeMask)
		for dname, data in tmppy.items():
			self.desc[dname] = data
		del tmppy
		for dobj in ComputedDescList:
			self.desc[dobj.name] = descriptordata.DescriptorComputation(dobj, self, None, None)
		self.triggerinit = False
	###################################################
	def initThresholdTest(self, onsetDescriptorDict):		
		# get min / max of trigger descriptors
		self.mins = {}
		self.maxs = {}
		for dname, weight in onsetDescriptorDict.items():
			self.mins[dname] = np.min(self.desc[dname][:])
			self.maxs[dname] = np.max(self.desc[dname][:])
		self.triggerinit = True
	###################################################
	def thresholdTest(self, time, onsetDescriptorDict):		
		if not self.triggerinit: self.initThresholdTest(onsetDescriptorDict) # only once!
		trig = 0.
		weightsum = 0.
		for dname, weight in onsetDescriptorDict.items():
			value = self.desc[dname][time]
			if dname.find('power') != -1 or value < 0.:
				trigadd = value / self.maxs[dname]
			else:
				trigadd = value / self.mins[dname] # for non-power descriptors that are greater than 0.!
			trig += trigadd * weight
			weightsum += weight
		return util.ampToDb(trig)/weightsum
	#################################
	#################################
	def testForInitErrors(self, SdifInterface):
		# test self.filename
		oneframesec = SdifInterface.f2s(1)
		if not os.path.exists(self.filename):
			util.error('sfSegment init', 'file does not exist: \t%s\n'%self.filename)
		if self.soundfileExtension.lower() not in SdifInterface.validSfExtensions:
			util.error('sfSegment init', 'file is not an accepted soundfile type: \t%s\n'%self.filename)
		# test that startSec is sane
		if self.segmentStartSec < 0:
			util.error('sfSegment init', 'startSec is less than 0!!')
		if self.segmentStartSec >= self.segmentEndSec:
			util.error('sfSegment init', 'startSec is greater than its endSec!!')
		# test if requested read too long
		if self.segmentEndSec > self.soundfileTotalDuration+(oneframesec/2.):
			print('\n\nWARNING endSec (%.2f) is longer than the file\'s duration(%.2f)!!  Truncating to filelength.\n\n'%(self.segmentEndSec, self.soundfileTotalDuration))
			self.segmentEndSec = self.soundfileTotalDuration
			#util.error('sfSegment init', 'endSec is after the the file\'s duration!!')
	#################################
	#################################
	def __str__(self, length=50):
		prints = []
		for k, v in vars(self).items():
			valueStr = str(v)
			if len(valueStr) > length: valueStr = valueStr[:length-3]+'...'
			prints.append('\t%s : %s'%(k, valueStr))
		prints.sort() # alphabetize
		return '''<SfSegment object>\n'''+'\n'.join(prints)
	#################################





class corpusSegment(SfSegment):
	'''Inherits class of SfSegment and adds additional attributes
	used uniquely by corpus segments.'''
	def __init__(self, filename, startSec, endSec, envDb, envAttackSec, envDecaySec, envSlope, SdifInterface, concatFileName, userCpsStr, voiceID, midiPitchMethod, limitObjList, scaleDistance, superimposeRule, transMethod, transQuantize, allowRepetition, restrictInTime, restrictOverlaps, restrictRepetition, postSelectAmpBool, postSelectAmpMin, postSelectAmpMax, postSelectAmpMethod, segfileData):
		# initalise the sound segment object	
		SfSegment.__init__(self, filename, startSec, endSec, SdifInterface.requiredDescriptors, SdifInterface, envDb=envDb, envAttackSec=envAttackSec, envDecaySec=envDecaySec, envSlope=envSlope)
		# additional corpus-specific data
		self.userCpsStr = userCpsStr
		self.concatFileName = concatFileName
		self.voiceID = voiceID
		self.midiPitchMethod = midiPitchMethod
		self.limitObjList = limitObjList
		self.scaleDistance = scaleDistance
		self.postSelectAmpBool = postSelectAmpBool
		self.postSelectAmpMin = postSelectAmpMin
		self.postSelectAmpMax = postSelectAmpMax
		self.postSelectAmpMethod = postSelectAmpMethod
		self.superimposeRule = superimposeRule
		self.transMethod = transMethod
		self.transQuantize = transQuantize
		self.allowRepetition = allowRepetition
		self.restrictOverlaps = restrictOverlaps
		self.restrictRepetition = restrictRepetition
		self.sim_accum = 0. # for similarity calculations
		self.selectionTimes = []
		self.segfileData = segfileData
	###################################################
	def getValuesForSimCalc(self, tgtseg, tgtSeek, array_len, dobj, superimposeObj):
		tgtvals = tgtseg.desc[dobj.name].getnorm(tgtSeek, tgtSeek+array_len)	
		if superimposeObj.calcMethod == "mixture" and dobj.is_mixable and tgtseg.has_been_mixed:
			if dobj.seg: d = dobj.parents[0]
			else:  d = dobj.name
			#############################
			## USE DESCRIPTOR MIXTURES ##
			#############################
			tgtrawvals = tgtseg.mixdesc[d][tgtSeek:tgtSeek+array_len]
			cpsrawvals = self.desc[d][:array_len]
			if dobj.describes_energy:
				mixedvals = tgtrawvals + cpsrawvals
			else:
				tgtrawpowers = tgtseg.mixdesc['power'][tgtSeek:tgtSeek+array_len]
				cpsrawpowers = self.desc['power'][:array_len]
				mixedpowers = (tgtrawpowers + cpsrawpowers)
				mixedvals = ((tgtrawvals*tgtrawpowers) + (cpsrawvals*cpsrawpowers)) / mixedpowers

			if dobj.seg: # segmented
				if dobj.describes_energy:
					averagedVal = np.average(mixedvals)
				else:
					try: averagedVal = np.average(mixedvals, weights=mixedpowers)
					except ZeroDivisionError: averagedVal = 0
				normedVal = (averagedVal-self.desc[dobj.name].normSubtract)/self.desc[dobj.name].normDivide
				#print "mixed segmented UNNORMED", averagedVal, "NORMED", normedVal
				return tgtvals, normedVal
			else: # time-varying
				#print "mixed time-varying UNNORMED", mixedvals, "NROMED", normedvals
				normedvals = (mixedvals-self.desc[dobj.name].normSubtract)/self.desc[dobj.name].normDivide
				return tgtvals, normedvals
		else: # not mixed
			if dobj.seg: # segmented
				return tgtvals, self.desc[dobj.name].getnorm(0, None)	
			else: # time-varying
				return tgtvals, self.desc[dobj.name].getnorm(0, None)	
	







class targetSegment(SfSegment):
	'''Inherits class of SfSegment and adds additional attributes
	used uniquely by target segments.'''
	def __init__(self, filename, startSec, endSec, envDb, envAttackSec, envDecaySec, envSlope, SdifInterface, midiPitchMethod):
		# initalise the sound segment object	
		SfSegment.__init__(self, filename, startSec, endSec, SdifInterface.requiredDescriptors, SdifInterface, envDb=envDb, envAttackSec=envAttackSec, envDecaySec=envDecaySec, envSlope=envSlope)
		# additional target-specific data
		self.midiPitchMethod = midiPitchMethod
	###################################################
	def initMixture(self, SdifInterface):
		self.mixdesc = descriptordata.container(SdifInterface.mixtureDescriptors, self)
		for dobj in SdifInterface.mixtureDescriptors:
			if dobj.seg: continue
			#	def setNorm(self, subtract, divide):
			self.mixdesc[dobj.name] = np.zeros(self.lengthInFrames) # array of zeros
		self.has_been_mixed = False
	#################################
	def mixSelectedSamplesDescriptors(self, cpsh, cpsAmpScale, tgtsegSeek, SdifInterface, v=True):
		mix_dur = min(self.lengthInFrames-tgtsegSeek, cpsh.lengthInFrames)
		for d in SdifInterface.mixtureDescriptors:
			if not d.seg: # is time-varying
				self.mixdesc[d.name][tgtsegSeek:tgtsegSeek+mix_dur] = timeVaryingDescriptorMixture(self, tgtsegSeek, cpsh, 0, d, cpsAmpScale)
			else: # is segmented
				self.mixdesc[d.name].clear()
		self.has_been_mixed = True



def timeVaryingDescriptorMixture(tgtsegh, tgtseek, cpssegh, cpsseek, dobj, cpsAmpScale, v=False):
	mix_dur = min(tgtsegh.lengthInFrames-tgtseek, cpssegh.lengthInFrames-cpsseek)
	tgt_vals = tgtsegh.mixdesc[dobj.name][tgtseek:tgtseek+mix_dur]
	cps_vals = cpssegh.desc[dobj.name][cpsseek:cpsseek+mix_dur]
	if dobj.describes_energy: # powers are summed
		mixture = tgt_vals + (cps_vals*cpsAmpScale)
	else: # power averaged
		tgt_amps = tgtsegh.mixdesc['power'][tgtseek:tgtseek+mix_dur]
		cps_amps = cpssegh.desc['power'][cpsseek:cpsseek+mix_dur]*cpsAmpScale
		mixture = ((tgt_vals*tgt_amps)+(cps_vals*cps_amps))/(tgt_amps + cps_amps)	
	if v: # verbose printing
		maxxy = min(5, len(mixture))
		if dobj.describes_energy: # powers are summed
			print "SUM", dobj.name, tgtseek, mix_dur
		else:
			print "MIXTURE", dobj.name, tgtseek, mix_dur
		print "\tpastmix:", tgt_vals[0:maxxy]
		print "\tcorpus:", cps_vals[0:maxxy]
		print "\tnewmix:", mixture[0:maxxy]
	return mixture






class target: # the target
	def __init__(self, userOptsTargetObject):
		self.filename = userOptsTargetObject.filename
		self.startSec = userOptsTargetObject.start
		self.endSec = userOptsTargetObject.end
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
	########################################
	def timeStretch(self, SdifInterface, ops, p):
		self.filename = util.initStretchedSoundfile(self.filename, self.startSec, self.endSec, self.stretch, SdifInterface.supervp_bin, p=p)
		self.startSec = 0 # this now gets reset, as starttime was considered when making the stretched file
		self.endSec = None # this now gets reset, as endtime was considered when making the stretched file
	########################################
	def initAnal(self, SdifInterface, ops, p):
		# Start by loading the entire target as an 
		# sfSegment to get the whole amplitude envelope.
		self.filename = util.verifyPath(self.filename, SdifInterface.searchPaths)
		# see if we need to time stretch the target file...
		if self.stretch != 1:
			self.timeStretch(SdifInterface, ops, p)
		# analise the whole target sound!
		self.whole = SfSegment(self.filename, self.startSec, self.endSec, SdifInterface.requiredDescriptors, SdifInterface)
		self.startSec = self.whole.segmentStartSec
		self.endSec = self.whole.segmentEndSec
		self.whole.midiPitchMethod = self.midiPitchMethod
		self.lengthInFrames = self.whole.lengthInFrames

		# SEGMENTATION
		self.filename = os.path.abspath(self.filename)
		self.segmentationMinLenFrames = SdifInterface.s2f(self.segmentationMinLenSec, self.filename, minimum=1)
		self.segmentationMaxLenFrames = SdifInterface.s2f(self.segmentationMaxLenSec, self.filename)
		p.log("TARGET SEGMENTATION: minimum segment length %.3f sec; maximum %.3f sec"%(self.segmentationMinLenSec, self.segmentationMaxLenSec))
		self.minPower = min(self.whole.desc['power'])
		if self.minPower < util.dbToAmp(self.segmentationOffsetThreshAbs): # use absolute threshold
			self.powerOffsetValue = util.dbToAmp(self.segmentationOffsetThreshAbs)
			p.log("TARGET SEGMENTATION: using an offset amplitude value of %s"%(self.segmentationOffsetThreshAbs))
		else:
			self.powerOffsetValue = self.minPower*util.dbToAmp(self.segmentationOffsetThreshAdd)
			p.log("TARGET SEGMENTATION: the amplitude of %s never got below the offset threshold of %sdB specified in offsetThreshAbs.  So, I'm using offsetThreshAdd dB (%.2f) above the minimum found power -- a value of %.2f dB."%(self.filename, self.segmentationOffsetThreshAdd, self.segmentationOffsetThreshAdd, util.ampToDb(self.powerOffsetValue)))
	
		self.segs = []
		self.segmentationInFrames = []
		self.segmentationInSec = []
		self.segmentationLogic = []
		self.seglengths = []
		
		if self.segmentationFilepath == None:
			f = 0
			while True:
				if f >= self.whole.lengthInFrames: break # we are done!
				trigVal = self.whole.thresholdTest(f, SdifInterface.tgtOnsetDescriptors)
				if trigVal < self.segmentationThresh:
					f += 1
					continue
				# an onset because above trigger threshold
				self.segmentationLogic.append([SdifInterface.f2s(f), 'triggered', trigVal])
				segLen = self.segmentationMinLenFrames
				while True:
					# an offset if end of file is reached
					if f+segLen+1 >= self.whole.lengthInFrames:
						reason = ['eof', self.whole.lengthInFrames]
						endtimeSec = min(SdifInterface.f2s(f+segLen), self.whole.soundfileTotalDuration)
						self.segmentationLogic[-1].extend([endtimeSec, 'eof', SdifInterface.f2s(self.whole.lengthInFrames)])
						break
					# an offset if max seg length is reached
					if segLen+1 >= self.segmentationMaxLenFrames:
						reason = ['maxSegLength', self.whole.lengthInFrames]
						endtimeSec = min(SdifInterface.f2s(f+segLen), self.whole.soundfileTotalDuration)
						self.segmentationLogic[-1].extend([endtimeSec, 'maxSegLength', self.segmentationMaxLenSec])
						break			
					# an offset if amplitude is below offset threshold
					if self.whole.desc['power'][f+segLen] < self.powerOffsetValue:
						endtimeSec = min(SdifInterface.f2s(f+segLen), self.whole.soundfileTotalDuration)
						self.segmentationLogic[-1].extend([endtimeSec, 'drop', util.ampToDb(self.whole.desc['power'][f+segLen])])
						break
					# an offset if riseratio is too large
					riseRatio = self.whole.desc['power'][f+segLen+1]/self.whole.desc['power'][f+segLen]
					if riseRatio >= self.segmentationOffsetRise:
						endtimeSec = min(SdifInterface.f2s(f+segLen), self.whole.soundfileTotalDuration)
						self.segmentationLogic[-1].extend([endtimeSec, 'rise', riseRatio])
						break
					segLen += 1
				self.segmentationInFrames.append((f, f+segLen))
				f += segLen
			closebartxt = "Found %i segments (threshold=%.1f offsetrise=%.2f offsetthreshadd=%.2f)."%(len(self.segmentationInFrames), self.segmentationThresh, self.segmentationOffsetRise, self.segmentationOffsetThreshAdd)
		else: # load target segments from a file
			p.log("TARGET SEGMENTATION: reading segments from file %s"%(self.segmentationFilepath))
			for dataentry in util.readAudacityLabelFile(self.segmentationFilepath):
				startf = SdifInterface.s2f(dataentry[0], self.filename)
				endf = SdifInterface.s2f(dataentry[1], self.filename)
				self.segmentationInFrames.append((startf, endf))
			closebartxt = "Read %i segments from file %s"%(len(self.segmentationInFrames), os.path.split(self.segmentationFilepath)[1])
		###################################
		## make segment times in seconds ##
		###################################
		for start, end in self.segmentationInFrames:
			self.segmentationInSec.append((SdifInterface.f2s(start), SdifInterface.f2s(end)))
			self.seglengths.append(SdifInterface.f2s(end-start))


		
		p.startPercentageBar(upperLabel="Evaluating TARGET %s from %.2f-%.2f"%(self.whole.printName, self.whole.segmentStartSec, self.whole.segmentEndSec), total=len(self.segmentationInSec))
		for sidx, (startSec, endSec) in enumerate(self.segmentationInSec):
			p.percentageBarNext(lowerLabel="@%.2f sec - %.2f sec"%(startSec, endSec))
			segment = targetSegment(self.filename, startSec, endSec, +0, 0.0001, 0.0001, 1, SdifInterface, self.midiPitchMethod)
			segment.power = segment.desc['power-seg'].get(0, None) # for sorting
			self.segs.append(segment)
		p.percentageBarClose(txt=closebartxt)
		# done!
	########################################
	def writeSegmentationFile(self, filename):
		fh = open(filename, 'w')
		for segment in self.segmentationLogic:
			fh.write( "%f\t%f\ttrig=%.2f %s=%.2f\n"%(segment[0], segment[3], segment[2], segment[4], segment[5]) )
		fh.close()
	########################################
	def setupConcate(self, SdifInterface):
		# initalise mixture and add norm coeffs to mixables...
		for seg in self.segs:
			seg.initMixture(SdifInterface)
			for dobj in SdifInterface.mixtureDescriptors:
				seg.mixdesc[dobj.name].setNorm(seg.desc[dobj.name].normSubtract, seg.desc[dobj.name].normDivide)
	########################################
	def plotMetrics(self, outputpath, SdifInterface, p, normalise=True):
		import matplotlib.pyplot as plt
		lengthTv = self.whole.lengthInFrames
		powers = self.whole.desc['power'][:]
		if normalise:
			powers -= np.min(powers)
			powers /= np.max(powers)

		for dobj in SdifInterface.requiredDescriptors:
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
	def plotSegmentation(self, outputpath, SdifInterface, p):
		import matplotlib.pyplot as plt
		powers = self.whole.desc['power'][:]
		powers -= np.min(powers)
		powers /= np.max(powers) # normalise between 0 and 1
		plotheight = 15.
		fig = plt.figure(figsize=(len(powers)/10., plotheight))
		plt.plot(range(len(powers)), powers, ls='steps-post', lw=1, label=['power'])
		for sidx in range(len(self.segmentationInFrames)): # plot segmentation
			xstart = self.segmentationInFrames[sidx][0]
			xend = self.segmentationInFrames[sidx][1]
			#print self.segmentationInFrames[sidx], self.segmentationLogic[sidx]
			plt.axvspan(xstart, xend, facecolor='#FFCCCC', alpha=1, ec='r', lw=1)
			plt.text(xstart, 0.5*plotheight, 'benny', fontsize=12, color='black')
		leg = plt.legend(['power'],'upper right', shadow=False)
		frame  = leg.get_frame()  
		frame.set_facecolor('0.90')    # set the frame face color to light gray
		p.log("TARGET: plotted segmentation to %s"%(outputpath))
		plt.savefig(outputpath)
		plt.close()





	


def getDescriptorStatistics(listOfSegmentObjs, descriptorObj, takeOnlyEffDur=True):
	if descriptorObj.seg:
		allDescs = np.array([sfsObj.desc[descriptorObj.name].get(0, None) for sfsObj in listOfSegmentObjs])
	else:
		cnt = 0
		for sfsObj in listOfSegmentObjs: cnt += sfsObj.desc['effDur-seg'].get(0, None)
		allDescs = np.empty((cnt))
		cnt = 0
		for sfsObj in listOfSegmentObjs: 
			effDur = sfsObj.desc['effDur-seg'].get(0, None)
			allDescs[cnt:cnt+effDur] = sfsObj.desc[descriptorObj.name][:effDur]
			cnt += effDur
	return { 'min': np.min(allDescs), 'max': np.max(allDescs), 'mean': np.mean(allDescs),'stddev': np.std(allDescs) }


def applyDescriptorNormalisation(listOfSegmentObjs, dobj, descStatistics):
	if dobj.normmethod == 'minmax':
		valToSubtract = descStatistics['min']
		valToDivide =   descStatistics['max']-descStatistics['min']
	elif dobj.normmethod == 'stddev':
		valToSubtract = descStatistics['mean']
		valToDivide =   descStatistics['stddev']
	else:
		assert False
	for sfseg in listOfSegmentObjs:
		sfseg.desc[dobj.name].setNorm(valToSubtract, valToDivide)

