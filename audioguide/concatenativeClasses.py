import sys, os
import util, descriptordata, sfSegment
import numpy as np




class parseOptions:
	def __init__(self, opsfile=None, optsDict=None, defaults=None, scriptpath=None):
		from UserClasses import TargetOptionsEntry as tsf
		from UserClasses import CorpusOptionsEntry as csf
		from UserClasses import SingleDescriptor as d
		from UserClasses import SearchPassOptionsEntry as spass
		from UserClasses import SuperimpositionOptionsEntry as si
		usrOptions = {}
		if opsfile != None:
			fh = open(opsfile)
			exec(fh.read(), locals(), usrOptions)
			fh.close()
		if optsDict != None:
			usrOptions.update(optsDict)
		ops = {}
		if defaults != None:
			fh = open(defaults)
			exec(fh.read(), locals(), ops)
			fh.close()
		ops.update(usrOptions)	
		# replace "none" with None
		for k, v in ops.items():
			if not isinstance(v, str): continue
			if v.lower() == 'none': ops[k] = None
		ops['SEARCH_PATHS'].append( os.path.split(scriptpath)[0] )
		if opsfile != None:
			ops['SEARCH_PATHS'].append( os.path.split(opsfile)[0] )
		if scriptpath != None:
			ops['SEARCH_PATHS'].append( scriptpath )
		# complete paths for output files...
		for item, val in ops.items():
			if item.find('_FILEPATH') == -1: continue
			if val == None: continue
			ops[item] = util.verifyOutputPath(val, scriptpath)
		# assign dict to this classes' attributes so that values may
		# be obtained by writing ops.CORPUS rather than ops['CORPUS']
		for k, v in ops.items(): setattr(self, k, v)
	#############################
	def createSdifInterface(self, p):
		import sdiflinkage
		linkage = sdiflinkage.SdifInterface(pm2_bin=self.PM2_BIN, supervp_bin=self.SUPERVP_BIN, winLengthSec=self.DESCRIPTOR_WIN_SIZE_SEC, hopLengthSec=self.DESCRIPTOR_HOP_SIZE_SEC, resampleRate=self.IRCAMDESCRIPTOR_RESAMPLE_RATE, windowType=self.IRCAMDESCRIPTOR_WINDOW_TYPE, numbMfccs=self.IRCAMDESCRIPTOR_NUMB_MFCCS, F0MaxAnalysisFreq=self.IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ, F0MinFrequency=self.IRCAMDESCRIPTOR_F0_MIN_FREQUENCY, F0MaxFrequency=self.IRCAMDESCRIPTOR_F0_MAX_FREQUENCY, F0AmpThreshold=self.IRCAMDESCRIPTOR_F0_AMP_THRESHOLD, F0Quality=self.IRCAMDESCRIPTOR_F0_QUALITY, numbPeaks=self.SUPERVP_NUMB_PEAKS, numbClust=self.CLUSTERANAL_NUMB_CLUSTS, clustDescriptDict=self.CLUSTERANAL_DESCRIPTOR_DIM, forceAnal=self.DESCRIPTOR_FORCE_ANALYSIS, validSfExtensions=self.SOUNDFILE_EXTENSIONS, searchPaths=self.SEARCH_PATHS, p=p)
		linkage.getDescriptorLists(self)
		return linkage
##########################################################





class cpsLimit:
	def __init__(self, origString, cpsScope, SdifInterface):
		self.origString = origString
		limit_pieces = util.parseEquationString(origString, ['==', '!=', '<', '<=', '>', '>='])
		for dobj in SdifInterface.requiredDescriptors:
			if dobj.name == limit_pieces[0]: break
		self.d = dobj
		self.symb = limit_pieces[1]
		# test to see if it is a percentage
		if limit_pieces[2].find('%') == -1:
			self.needMinMax = True
			self.value = float(limit_pieces[2])
		else: # its a percentage
			self.needMinMax = False
			self.percent = float(limit_pieces[2].replace('%', ''))
		self.cpsScope = cpsScope # scope is a list of applicable voiceIDs
		self.cnt_reject = []
	########################################
	def checkminMax(self, allcpshandles):
		if self.needMinMax: return
		# loop through corpus handles again, but only happens once per unique limit string
		tmp_data = []
		for ch in allcpshandles:
			if ch.voiceID not in self.cpsScope: continue # skip if outside scope
			if self.d.seg:
				tmp_data.append( ch.segdata.getraw(self.d.name, 0, None) )
			else:
				tmp_data.extend( ch.segdata.getraw(self.d.name, 0, None) )
		tmp_data.sort()
		self.value = tmp_data[ int((self.percent/100.)*(len(tmp_data)-1)) ]
		del tmp_data
		self.needMinMax = True
	########################################
	def test(self, sfobj):
		if self.d.seg:
			test = eval("%s %s %s"%(sfobj.desc[self.d.name].get(0, None), self.symb, self.value))
		else:
			test = eval("%s %s %s"%(np.max(sfobj.desc[self.d.name]), self.symb, self.value))
		if not test:
			self.cnt_reject.append(sfobj)
		return test
	########################################
	def printRejects(self, cps):
		dicty = {}
		for sf in self.cnt_reject:
			id = os.path.split(sf.userCpsStr)[1]
			if not dicty.has_key(sf.voiceID): dicty[sf.voiceID] = 0
			dicty[sf.voiceID] += 1
		output = self.origString+'\n'
		for voiceID, numb in dicty.iteritems():
			percent = numb*100. / float(cps.data['cspInfo'][voiceID]['segs'])
			output += "\tremoved %.1f%% segments from %s\n"%(percent, cps.data['cspInfo'][voiceID]['filehead'])
		return output






################################################################################
class corpus:
	def __init__(self, corpusFromUserOptions, corpusGlobalAttributesFromOptions, SdifInterface, p):
		self.preloadlist = []
		self.preLimitSegmentList = []
		self.postLimitSegmentNormList = []
		self.simSelectRuleByCorpusId = []
		self.len = len(corpusFromUserOptions)
		
		self.data = {}
		self.data['lastVoice'] = None
		self.data['totalLengthInSeconds'] = 0.
		self.data['vcToCorpusName'] = []
		self.data['postLimitSegmentDictVoice'] = {}
		self.data['postLimitSegmentCount'] = 0
		self.data['selectionTimeByVoice'] = {}
		self.data['cspInfo'] = []
		for cidx in range(len(corpusFromUserOptions)):
			self.data['postLimitSegmentDictVoice'][cidx] = []
			self.data['selectionTimeByVoice'][cidx] = []
		
		# find any GLOBAL limitations the user has placed on the corpus
		self.globalLimits = []
		self.localLimits = []
		if corpusGlobalAttributesFromOptions.has_key('limit'):
			for stringy in corpusGlobalAttributesFromOptions['limit']:
				self.globalLimits.append( cpsLimit(stringy, range(len(corpusFromUserOptions)), SdifInterface) )

		self.data['numberVoices'] = len(corpusFromUserOptions)
		for cidx, cobj in enumerate(corpusFromUserOptions):
			# add this voice
			vcCnt = 0
			cobj.name = util.verifyPath(cobj.name, SdifInterface.searchPaths)
			cobj.voiceID = cidx
			self.simSelectRuleByCorpusId.append(cobj.superimposeRule)
			self.data['vcToCorpusName'].append(cobj.name)
	

			for name, val in corpusGlobalAttributesFromOptions.iteritems():
				if name == 'limit': continue
				setattr(cobj, name, val)

			# add local limits
			totalLimitList = []
			for limitstr in cobj.limit:
				limitObj = cpsLimit(limitstr, [cidx], SdifInterface)
				self.localLimits.append(limitObj)
				totalLimitList.append( limitObj )
			# add global limits
			totalLimitList.extend(self.globalLimits) # from CORPUS_GLOBAL_ATTRIBUTES

			# get segments/files list
			timeList = []
			if os.path.isdir(cobj.name): fileType = 'dir'
			if os.path.isfile(cobj.name): fileType = 'file'
			if os.path.islink(cobj.name): fileType = 'link'
			
			# make a log entry
			#p.logsection('CORPUS')
#			logStr = '* #%i - %s - %s\n'%(cidx, fileType.upper(), cobj.name)
#			for name in dir(cobj):
#				if name[0] == '_': continue
#				if name in ['voiceID', 'concatFileName', 'name']: continue
#				if cobj._defaults.has_key(name) and getattr(cobj, name) == cobj._defaults[name] : continue # skip default settings
#				val = getattr(cobj, name)
#				if type(val) == str:
#					logStr += "\t%s = '%s'\n"%(name, getattr(cobj, name))
#				else:
#					logStr += "\t%s = %s\n"%(name, getattr(cobj, name))
#			p.write(logStr)

			
			# use non-standard location segmentation file?
			if cobj.segmentationFile == None: # add default name of segmentation file if nothing is specified by the user			
				cobj.segmentationFile = cobj.name+cobj.segmentationExtension
			elif type(cobj.segmentationFile) == str: # if a single string
				cobj.segmentationFile = cobj.segmentationFile
			elif type(cobj.segmentationFile) in [tuple, list]: # a list of seg files
				tmp = []
				for string in cobj.segmentationFile:
					tmp.append(path.test(string, ops.CORPUS_SEARCH_PATH)[1])
				cobj.segmentationFile = tmp
			if not cobj.segmentationFile:
				util.error("ops", "Bad Source input name -> %s.  Not a file, a directory"%cobj.segmentationFile)
			
			if fileType == 'file': # an audio file
				##################
				## input a FILE ## -- look for audacity-style txt label file
				##################
				times = []
				#for segFile in cobj.segmentationFile:
				if not cobj.wholeFile and not os.path.isfile(cobj.segmentationFile):
					util.error('segmentation file', "Cannot find segmentation file '%s'"%cobj.segmentationFile)
				times.extend(util.readAudacityLabelFile(cobj.segmentationFile))
				for timeSeg in times:
					writeLine = [cobj.name]
					writeLine.extend(timeSeg)
					timeList.append( writeLine )
				cobj.numbSfFiles = 1
			elif fileType == 'dir': # a directory
				#######################
				## input a DIRECTORY ##
				#######################
				files = util.getDirListOnlyExt(cobj.name, cobj.recursive, SdifInterface.validSfExtensions)
				cobj.segmentationFile = None # don't print it
				print files
				for file in files:
					segFileTest = file+cobj.segmentationExtension
					if not cobj.wholeFile and not os.path.isfile(segFileTest):
						util.error('segmentation file', "Cannot find segmentation file '%s'.  To specify the use of whole sound files as corpus segments, write this corpus entry as: \n\tcsf('%s', wholeFile=True)\nor\n\tCORPUS_GLOBAL_ATTRIBUTES = {'wholeFile': True}"%(segFileTest, cobj.name))
					if os.path.exists(segFileTest):
						times = util.readAudacityLabelFile(segFileTest)
					else:
						times = [[0, None]]
					for timeSeg in times:
						writeLine = [file]
						writeLine.extend(timeSeg)
						timeList.append( writeLine )
				cobj.numbSfFiles = len(files)
			# reset counters...
			segCount = 0
			windowDist = descriptordata.hannWin(len(timeList)*2)
			# segment list
			for idx in range(len(timeList)): 
				#thisSegDict = {}
				filehead = os.path.split(timeList[idx][0])[1]
				startSec = timeList[idx][1]
				endSec = timeList[idx][2]
				# matchSting: includeStr/excludeStr
				if cobj.includeStr != None:
					skip = True
					if type(cobj.includeStr) not in [list, tuple]: cobj.includeStr = [cobj.includeStr]
					for test in cobj.includeStr:
						if util.matchString(filehead, test, caseSensative=True): skip = False
					if skip: continue
				if cobj.excludeStr != None:
					skip = False
					if type(cobj.excludeStr) not in [list, tuple]: cobj.excludeStr = [cobj.excludeStr]
					for test in cobj.excludeStr:
						if util.matchString(filehead, test, caseSensative=True): skip = True
					if skip: continue
				#        minTime / maxTime
				if cobj.start != None and startSec < cobj.start: continue # skip it
				if cobj.end != None and startSec > cobj.end: continue # skip it
				# matchTime: includeTimes/excludeTimes
				if len(cobj.includeTimes) > 0:
					skip = True
					for timeTuple in cobj.includeTimes:
						if startSec >= timeTuple[0] and endSec <= timeTuple[1]: skip = False
					if skip: continue
				if len(cobj.excludeTimes) > 0:
					skip = False
					if type(cobj.excludeTimes) not in [list, tuple]: cobj.excludeTimes = [cobj.excludeTimes] # force it to be a list
					for timeTuple in cobj.excludeTimes:
						if startSec >= timeTuple[0] and endSec <= timeTuple[1]: skip = True
					#print filehead, start, end, skip
					if skip: continue
					
				if len(timeList[idx]) >= 3: extraMappedData = timeList[idx][3:]
				else: extraMappedData = ''
				# test if limitDur is set...
				if cobj.limitDur != None:
					if endSec != None and endSec-startSec > cobj.limitDur: endSec = start+cobj.limitDur
				# see which sf to map sound concatenation onto...
				if cobj.concatFileName == None: concatFileName = timeList[idx][0]
				self.preloadlist.append([timeList[idx][0], timeList[idx][1], timeList[idx][2], cobj.scaleDb, cobj.onsetLen, cobj.offsetLen, cobj.envelopeSlope, SdifInterface, concatFileName, cobj.name, cobj.voiceID, cobj.midiPitchMethod, totalLimitList, cobj.scaleDistance, cobj.superimposeRule, cobj.transMethod, cobj.transQuantize, cobj.allowRepetition, cobj.restrictInTime, cobj.restrictOverlaps, cobj.restrictRepetition, cobj.postSelectAmpBool, cobj.postSelectAmpMin, cobj.postSelectAmpMax, cobj.postSelectAmpMethod, cobj.hasParams])
				vcCnt += 1
			self.data['cspInfo'].append( {'name': cobj.name, 'filehead': os.path.split(cobj.name)[1], 'segs': str(vcCnt), 'fileType': fileType, 'numbSfFiles': cobj.numbSfFiles, 'restrictInTime': cobj.restrictInTime, 'segFile': cobj.segmentationFile, 'restrictOverlaps': cobj.restrictOverlaps, 'scaleDb': cobj.scaleDb} )	
			###########################
			## done with CORPUS loop ##
			###########################
		p.startPercentageBar(upperLabel="Evaluating CORPUS...", total=len(self.preloadlist))
		# in a seperate loop for printing...
		for cidx, corpusSegParams in enumerate(self.preloadlist):
			start=corpusSegParams[1]
			stop=corpusSegParams[2]
			if start == None: start=0
			if stop == None: stop=100
			p.percentageBarNext(lowerLabel="%s@%.2f-%.2f"%(corpusSegParams[0], start, stop))
			# make the obj
			cpsSeg = sfSegment.corpusSegment(*corpusSegParams)
			# add it to the list!
			self.preLimitSegmentList.append(cpsSeg)
		
		self.evaluatePreConcateLimitations()

		p.percentageBarClose(txt="Read %i/%i segments (%.0f%%, %.2f min.)"%(self.data['postLimitSegmentCount'], len(self.preLimitSegmentList), self.data['postLimitSegmentCount']/float(len(self.preLimitSegmentList))*100., self.data['totalLengthInSeconds']/60.))



	############################################################################
	############################################################################
	def evaluatePreConcateLimitations(self):
		# find min/max of descriptor variance if using a percentage
		for limitList in [self.globalLimits, self.localLimits]:
			for cpsLimitObj in limitList:
				cpsLimitObj.checkminMax(self.preLimitSegmentList)
		# test corpus segments for validity (can be restricted by used descriptor limits)
		for csfs in self.preLimitSegmentList:
			passed = []
			for limitObj in csfs.limitObjList:
				passed.append(limitObj.test(csfs))
			if False in passed:
				continue # then ignore this segment!
			# add the segment since if passed any user-supplied limitations...
			self.data['postLimitSegmentDictVoice'][csfs.voiceID].append(csfs)
			self.postLimitSegmentNormList.append(csfs)
			self.data['totalLengthInSeconds'] += csfs.segmentDurationSec
			self.data['postLimitSegmentCount'] += 1
		# test to make sure some samples made it though usert limitations... 
		if self.data['postLimitSegmentCount'] == 0:
			util.error('CORPUS', "No database segments made it into the selection pool.  Check limits..")
		# print corpus segment data
		for limitList in [self.globalLimits,self.localLimits]:	
			if len(limitList) > 0:
				print('LIMITS')
				for cpsLimitObj in limitList:
					print( cpsLimitObj.printRejects(self) )
				print('\n')
	############################################################################
	def nameTest(self, name, prefixList): # return only same with a certain starting prefix
		test = True
		name = name.split('/')[-1]
		for t in prefixList:
			if name[0:len(t)] == t:
				test = True
				break
			else:
				test = False
		return test
	############################################################################
	def updateWithSelection(self, cpsh, timeInSec):
		self.data['lastVoice'] = cpsh.voiceID
		self.data['selectionTimeByVoice'][cpsh.voiceID].append(timeInSec)
		cpsh.selectionTimes.append(timeInSec)
		
		if not cpsh.allowRepetition:
			del self.data['postLimitSegmentDictVoice'][cpsh.voiceID] # remove it altogether
	############################################################################
	def setupCorpusConcatenationLimitations(self, tgtObj, SdifInterface):
		'''called when concate is initialized'''
		##########################################################
		## set up voice restriction per second as a frame value ##
		##########################################################
		self.voiceRestrictPerFrame = {}
		for voiceId, infoDict in enumerate(self.data['cspInfo']):
			if infoDict['restrictInTime'] > 0:
				self.voiceRestrictPerFrame[voiceId] = SdifInterface.s2f(infoDict['restrictInTime'], tgtObj.filename)/2
	############################################################################
	############################################################################
	def evaluateValidSamples(self, timeInFrames, timeInSec, rotateVoices, voicePattern, superimp):
		# get which voices are valid at this selection time
		if rotateVoices and self.data['lastVoice'] != None:
			validVoices = [(self.data['lastVoice']+1)%self.data['numberVoices']]
		elif voicePattern not in [None, []]: # not case sensative!, oes a search, so matches partial strings
			validVoices = []
			for nidx, name in enumerate(self.data['vcToCorpusName']):
				if util.matchString(name, voicePattern[superimp.cnt['selectionCount']%len(voicePattern)], caseSensative=False):
					validVoices.append(nidx)
		else:
			validVoices = range(self.data['numberVoices'])
		########################################################
		## remove any voices that are outside temporal limits ##
		########################################################
		voicesToRemove = []
		# voice frequency restriction per frame...
		for vc in validVoices:
			if self.voiceRestrictPerFrame.has_key(vc):
				srt_look = max(0, timeInFrames-self.voiceRestrictPerFrame[vc])
				end_look = min(timeInFrames+self.voiceRestrictPerFrame[vc], len(superimp.cnt['cpsvc_overlap'][vc]))
				if np.sum(superimp.cnt['cpsvc_overlap'][vc][srt_look:end_look]) != 0: 
					if vc not in voicesToRemove: voicesToRemove.append(vc)
		# restrict corpus ID by number of selected overlapping samples
		# uses eval() to test against overlap number...
		for vc in validVoices:
			if self.simSelectRuleByCorpusId[vc] != None:
				if not eval(str(superimp.cnt['overlap'][timeInFrames])+self.simSelectRuleByCorpusId[vc]):
					if vc not in voicesToRemove: voicesToRemove.append(vc)
		###############################################
		## NOW remove any voices that should be here ##
		###############################################
		for vc in voicesToRemove:
			validVoices.remove(vc)

		#####################################
		## loop through each sound segment ##
		#####################################
		validSegments = []
		for h in self.postLimitSegmentNormList:
			# no voices that didn't pass through...
			if h.voiceID not in validVoices: continue
			# restiction in seconds per sample
			if h.restrictRepetition != None and len(h.selectionTimes) > 0:
				passme = True
				for selectedTime in h.selectionTimes:
					if abs(selectedTime-timeInSec) < h.restrictRepetition:
						passme = False
				if not passme: continue
			# see if it overlaps too much (dependant on each segments' duration)
			if h.restrictOverlaps != None:
				max_look = min(timeInFrames+h.lengthInFrames, len(superimp.cnt['cpsvc_overlap'][h.voiceID]))
				maxOver = np.max(superimp.cnt['cpsvc_overlap'][h.voiceID][timeInFrames:max_look])
				if maxOver >= h.restrictOverlaps: continue # skip this segment
			validSegments.append(h)
		return validSegments



	############################################################################
#	def printCorpusInfo(self):
#		postLevel = 2
#		printNumbSegsOrFiles = True
#		printLimits = True
#		# get number of total potential segments
#		totalSegs = 0
#		for name, dict in self.corpusPrintData.iteritems(): totalSegs += int(dict['segs'])
#		p.middle('Corpus - '+str(totalSegs)+' Possible Segments', postLevel)
#		
#		for name, dict in self.corpusPrintData.iteritems():
#			if dict['segFile'] != None: # make a printable list of segmentation files
#				tmp = []
#				for item in dict['segFile']:
#					tmp.append(os.path.split(item)[1])
#				name = ','.join(tmp)
#			
#			end = dict['limitEnd']
#			if end == sys.maxint: end = 'end'
#			printStr = "${YELLOW}"+str(dict['fileType'])+"${NORMAL} "+str(name)+" -> "
#			if printNumbSegsOrFiles:
#				if dict['fileType'] == 'file':
#					printStr += "${RED}"+dict['segs']+"${NORMAL} segments"
#					if dict['limitStart'] != 0 and str(end) not in ["end", None, "none"]:
#						printStr += " from "+str(dict['limitStart'])+" to "+str(end)+"."
#				elif dict['fileType'] == 'dir': printStr += "${RED}"+dict['segs']+"${NORMAL} segments from "+str(dict['numbSfFiles'])+" files."
#				elif dict['fileType'] == 'name': printStr += "${RED}"+dict['segs']+"${NORMAL} segments"
#				
#			if printLimits:
#				if len(dict['limit']) > 0:
#					for key, valDict in dict['limit'].iteritems():
#						restrict = [None, None]
#						for item, value in valDict.iteritems():
#							if item == 'scope': scoped = value
#							if item == 'low': restrict[0] = str(value)
#							if item == 'high': restrict[1] = str(value)
#							if item == 'lowPer': restrict[0] = str(value)+"%"
#							if item == 'highPer': restrict[1] = str(value)+"%"
#						if restrict[1] == None: restStr = "above "+str(restrict[0])
#						elif restrict[0] == None: restStr = "below "+restrict[1]
#						else: restStr = "between "+restrict[0]+" -> "+restrict[1]
#						printStr += "\n\t${RED}"+key+ "${NORMAL} "+restStr+", scoped ${YELLOW}"+scoped+"ly${NORMAL}"
#				if dict.has_key('restrictInTime') and dict['restrictInTime'] > 0:
#					print "\tRestricting segments to once every", dict['restrictInTime'], "seconds."
#				if dict['restrictOverlaps'] != None:
#					printStr += "\n\tRestricting segments to a ${RED}maximum simultanous overlap${NORMAL} of "+str(dict['restrictOverlaps'])+" -- scoped ${YELLOW}"+dict['restrictOverlapsReason']+"ly${NORMAL}."
#
#			p.post(printStr, postLevel)
#		p.post( "" )
#		pass
	############################################################################
	def makeSampleHistogram(self, outputEvents):
		cpsNames = [ oe.printname for oe in outputEvents ]
	
		noteHist = util.histogram(self.nameSelectedList)
		if len(noteHist) <= 1: noteHist = util.histogram(self.fileSelectedList)
		if ag.countRanOutOfSamples > 0: noteHist.append((ag.countRanOutOfSamples, "Out of Valid Segments"))
		p.middle('File Selection Histogram', postLevel)
		for (val, key) in noteHist:
			p.post( key+" -> ${RED}"+str(util.trunc((val/float(outputFiles.totalOutputNotes+ag.countRanOutOfSamples))*100, 2))+"%${NORMAL}", postLevel)
		p.post("", postLevel)
#	############################################################################
#	def printSimultanousHistogram(self):
#		postLevel = 2
#		tmpy = []
#		for numbSeg in tgt.onsetsPerFrame:
#			if numbSeg > 0: tmpy.append(numbSeg)
#		#print tmpy
#		noteHist = util.histogram(tmpy)
#		#print noteHist
#		p.middle('Simultaneous Selection Histogram', postLevel)
#		for (val, key) in noteHist:
#			p.post(str(key)+" note(s) -> ${RED}"+str(util.trunc(val/float(len(tmpy))*100, 2))+"%${NORMAL}", postLevel)
#		p.post("", postLevel)






################################################################################
################################################################################
class SuperimposeTracker():
	def __init__(self, tgtlength, tgtlengthsegs, overlap_inc_amp, peakAlign, peakAlignEnvelope, cpsentrylength, p):
		self.p = p
		self.cnt = {'onset': np.zeros(tgtlength), 'overlap': np.zeros(tgtlength), 'segidx': np.zeros(tgtlengthsegs), 'cpsvc_overlap': np.zeros((cpsentrylength, tgtlength)), 'selectionCount': 0}
		self.choiceCnt = 0 # tracks number of decisions made
		self.overlap_inc_amp = util.dbToAmp(overlap_inc_amp)
		self.peakAlign = peakAlign
		self.peakAlignEnvelope = peakAlignEnvelope
		self.histogram = {'select': [], 'skip': {}}
	########################################
	def test(self, type, time, min, max):
		pick = 'ok' # 'ok', 'notok', 'force'
		if min != None and self.cnt[type][time] < min: pick = 'force'
		if max != None and self.cnt[type][time] >= max: pick = 'notok'
		return pick	
	########################################
	def increment(self, start, dur, segidx, cps_voiceid, powers, logtext):
		self.p.log( logtext )
		self.cnt['segidx'][segidx] += 1
		self.cnt['onset'][start] += 1
		self.cnt['selectionCount'] += 1
		self.histogram['select'].append(start)
		self.choiceCnt += 1
		for f in range(dur):
			try:
				if powers[f] >= self.overlap_inc_amp:
					self.cnt['overlap'][start+f] += 1
					self.cnt['cpsvc_overlap'][cps_voiceid][start+f] += 1
			except IndexError: break # cps handle data not long enough
	########################################
	def skip(self, reason, value, timeinSec):
		if not self.histogram['skip'].has_key(reason):
			self.histogram['skip'][reason] = []
		self.histogram['skip'][reason].append(value)
		self.p.log( "SKIP @ %.2f -- %s (%s)"%(timeinSec, reason, value) )
		self.choiceCnt += 1
	########################################
	def pick(self, trig, trigVal, onsett, overt, segidxt, timeinSec):
		if not trig and onsett == 'force':
			self.p.log( "SELECT @ %.2f -- target too soft but forced to by minOnset"%(timeinSec) )
		elif not trig and overt == 'force':
			self.p.log( "SELECT @ %.2f -- target too soft but forced to by minOverlap"%(timeinSec) )
		elif not trig and segidxt == 'force':
			self.p.log( "SELECT @ %.2f -- target too soft but forced to by minSegment"%(timeinSec) )
		else:
			self.p.log( "SELECT @ %.2f"%(timeinSec) )






class outputEvent:
	def __init__(self, sfseghandle, timeInScore, ampBoost, transposition, tgtseg, simSelects, tgtsegdur, tgtsegnumb, stretchcode, minOutputMidi=21):		
		# soundfile stuff
		self.filename = sfseghandle.concatFileName
		self.printName = sfseghandle.printName
		self.timeInScore = timeInScore
		self.sfSkip = sfseghandle.segmentStartSec
		self.duration = sfseghandle.segmentDurationSec
		self.effDurSec = sfseghandle.desc['effDur-seg'].get(0, None)
		self.peaktimeSec = sfseghandle.desc['peakTime-seg'].get(0, None)
		self.powerSeg = sfseghandle.desc['power-seg'].get(0, None)
		self.rmsSeg = util.ampToDb(self.powerSeg)
		self.midiVelocity = self.rmsSeg+127
		if self.midiVelocity > 127: self.midiVelocity = 127
		if self.midiVelocity < 10: self.midiVelocity = 10
		# tgt stuff
		self.tgtsegdur = tgtsegdur
		self.tgtsegnumb = tgtsegnumb
		self.stretchcode = stretchcode
		self.simSelects = simSelects
		self.sfchnls = sfseghandle.soundfileChns
		# audioguide stuff
		self.transposition = transposition
		self.voiceID = sfseghandle.voiceID
		self.synthesisParams = sfseghandle.synthesisParameters
		self.midiFromFilename = sfseghandle.desc['MIDIPitch-seg'].get(0, None)
		self.midiPitch = self.midiFromFilename + self.transposition
		if self.midiPitch < minOutputMidi: self.midiPitch = minOutputMidi
		# amplitude envelope
		self.envDb = ampBoost
		self.envAttackSec = sfseghandle.envAttackSec
		self.envDecaySec = sfseghandle.envDecaySec
		self.envSlope = sfseghandle.envSlope
	####################################	
	def makeCsoundOutputText(self, channelMethod, instru=1):		
		return "i%i  %.3f  %.3f  %.3f  \"%s\"  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %i  %i  %f  %i  \"%s\"  \"%s\"\n"%(instru, self.timeInScore, self.duration, self.envDb, self.filename, self.sfSkip, self.transposition, self.rmsSeg, self.peaktimeSec, self.effDurSec, self.envAttackSec, self.envDecaySec, self.envSlope, self.voiceID, self.simSelects, self.tgtsegdur, self.tgtsegnumb, self.stretchcode, channelMethod)
	####################################	
	def makeLabelText(self):
		if self.sfSkip == 0:
			text = "%s"%(self.printName)
		else:
			text = "%s@%.2f"%(self.printName, self.sfSkip)
		return "%f\t%f\t%s\n"%(self.timeInScore, self.timeInScore+self.duration, text)
	####################################	
	def makeLispText(self):
		return '(%.3f %.3f %.3f "%s" %.2f) '%(self.timeInScore, self.duration, self.midiPitch, self.filename, self.rmsSeg)
	####################################	
	def makeDictOutput(self):
		dicty = {}
		for key in ['timeInScore', 'sfchnls', 'duration', 'envAttackSec', 'envDb', 'envDecaySec', 'envSlope', 'filename', 'midiFromFilename', 'peaktimeSec', 'powerSeg', 'sfSkip', 'simSelects', 'transposition', 'voiceID']:
			dicty[key] = getattr(self, key)
		return dicty

	

