############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os, types
import numpy as np
import audioguide.util as util
import audioguide.descriptordata as descriptordata
import audioguide.sfsegment as sfsegment
import audioguide.tests as tests



	

class parseOptions:
	def __init__(self, opsfile=None, optsDict=None, defaults=None, scriptpath=None):
		from audioguide.userclasses import TargetOptionsEntry as tsf
		from audioguide.userclasses import CorpusOptionsEntry as csf
		from audioguide.userclasses import SearchPassOptionsEntry as spass
		from audioguide.userclasses import SuperimpositionOptionsEntry as si
		from audioguide.userclasses import SingleDescriptor as d
		usrOptions = {}
		self.opsfileAsString = ''
		self.opsfilehead = ''
		if opsfile != None:
			fh = open(opsfile)
			self.opsfilehead = os.path.split(opsfile)[1]
			self.opsfileAsString = fh.read()
			exec(self.opsfileAsString, locals(), usrOptions)
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
		tests.testOpsDict(ops)
		for k, v in ops.items(): setattr(self, k, v)
	#############################
	def createAnalInterface(self, p):
		import anallinkage
		p.log("ORDERED SEARCH PATH: %s"%self.SEARCH_PATHS)
		linkage = anallinkage.AnalInterface(pm2_bin=self.PM2_BIN, supervp_bin=self.SUPERVP_BIN, userWinLengthSec=self.DESCRIPTOR_WIN_SIZE_SEC, userHopLengthSec=self.DESCRIPTOR_HOP_SIZE_SEC, userEnergyHopLengthSec=self.DESCRIPTOR_ENERGY_ENVELOPE_HOP_SEC, resampleRate=self.IRCAMDESCRIPTOR_RESAMPLE_RATE, windowType=self.IRCAMDESCRIPTOR_WINDOW_TYPE, F0MaxAnalysisFreq=self.IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ, F0MinFrequency=self.IRCAMDESCRIPTOR_F0_MIN_FREQUENCY, F0MaxFrequency=self.IRCAMDESCRIPTOR_F0_MAX_FREQUENCY, F0AmpThreshold=self.IRCAMDESCRIPTOR_F0_AMP_THRESHOLD, numbMfccs=self.IRCAMDESCRIPTOR_NUMB_MFCCS, forceAnal=self.DESCRIPTOR_FORCE_ANALYSIS, searchPaths=self.SEARCH_PATHS, p=p, dataDirectoryLocation=self.DESCRIPTOR_OVERRIDE_DATA_PATH)
		linkage.getDescriptorLists(self)
		return linkage
##########################################################





class cpsLimit:
	def __init__(self, origString, cpsScope, AnalInterface):
		self.origString = origString
		limit_pieces = util.parseEquationString(origString, ['==', '!=', '<', '<=', '>', '>='])
		assert limit_pieces[0] in [dobj.name for dobj in AnalInterface.requiredDescriptors]
		for dobj in AnalInterface.requiredDescriptors:
		#	print dobj, dobj.name, limit_pieces[0]
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
			#print self.origString, self.d.name, ch.desc[self.d.name].get(0, None)
			if ch.voiceID not in self.cpsScope: continue # skip if outside scope
			if self.d.seg:
				tmp_data.append( ch.desc[self.d.name].get(0, None)  )
			else:
				tmp_data.extend( ch.desc[self.d.name].get(0, None)  )
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
	def printRejects(self, cps, p):
		dicty = {}
		for sf in self.cnt_reject:
			id = os.path.split(sf.userCpsStr)[1]
			if not sf.voiceID in dicty: dicty[sf.voiceID] = 0
			dicty[sf.voiceID] += 1
		p.pprint( self.origString, colour='BOLD')
		for voiceID, numb in dicty.items():
			percent = numb*100. / float(cps.data['cspInfo'][voiceID]['segs'])
			p.printreject(numb, percent, cps.data['cspInfo'][voiceID]['filehead'])






################################################################################
class corpus:
	def __init__(self, corpusFromUserOptions, corpusGlobalAttributesFromOptions, restrictCorpusSelectionsByFilenameString, searchPaths, AnalInterface, p):
		self.preloadlist = []
		self.preLimitSegmentList = []
		self.postLimitSegmentNormList = []
		self.selectedSegmentList = []
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
		if 'limit' in corpusGlobalAttributesFromOptions:
			for stringy in corpusGlobalAttributesFromOptions['limit']:
				self.globalLimits.append( cpsLimit(stringy, range(len(corpusFromUserOptions)), AnalInterface) )

		self.data['numberVoices'] = len(corpusFromUserOptions)
		for cidx, cobj in enumerate(corpusFromUserOptions):
			# add this voice
			vcCnt = 0
			cobj.name = util.verifyPath(cobj.name, AnalInterface.searchPaths)
			cobj.voiceID = cidx
			self.simSelectRuleByCorpusId.append(cobj.superimposeRule)
			self.data['vcToCorpusName'].append(cobj.name)
	

			for name, val in corpusGlobalAttributesFromOptions.items():
				if name == 'limit': continue
				setattr(cobj, name, val)

			# add local limits
			totalLimitList = []
			for limitstr in cobj.limit:
				limitObj = cpsLimit(limitstr, [cidx], AnalInterface)
				self.localLimits.append(limitObj)
				totalLimitList.append( limitObj )
			# add global limits
			totalLimitList.extend(self.globalLimits) # from CORPUS_GLOBAL_ATTRIBUTES

			# get segments/files list
			timeList = []
			if os.path.isdir(cobj.name): fileType = 'dir'
			if os.path.isfile(cobj.name): fileType = 'file'
			if os.path.islink(cobj.name): fileType = 'link'
			# use non-standard location segmentation file?
			if cobj.segmentationFile == None: # add default name of segmentation file if nothing is specified by the user; also look in search paths
				segmentationSearchPaths = searchPaths[:]
				segmentationSearchPaths.insert(0, os.path.split(cobj.name)[0])
				segmentationSearchPaths = list(set(segmentationSearchPaths))
				possibilities = []
				for d in segmentationSearchPaths:
					testpath = os.path.join(d, os.path.split(cobj.name)[1]+cobj.segmentationExtension)
					possibilities.append(testpath)
					if os.path.exists(testpath):
						cobj.segmentationFile = testpath
						break

			elif type(cobj.segmentationFile) == str: # if a single string
				cobj.segmentationFile = cobj.segmentationFile				

			elif type(cobj.segmentationFile) in [tuple, list]: # a list of seg files
				tmp = []
				for string in cobj.segmentationFile:
					tmp.append(path.test(string, ops.SEARCH_PATHS)[1])
				cobj.segmentationFile = tmp


			if not cobj.segmentationFile:
				util.error("ops", "Cannot find segmentation file -> %s"%cobj.segmentationFile)
			
			if fileType == 'file': # an audio file
				##################
				## input a FILE ## -- look for audacity-style txt label file
				##################
				times = []
				#for segFile in cobj.segmentationFile:
				if not cobj.wholeFile and not os.path.isfile(cobj.segmentationFile):
					util.error('segmentation file', "Cannot find segmentation file '%s'"%cobj.segmentationFile)
				if cobj.wholeFile:
					times.append([0, None])
				else:
					sgs = util.readAudacityLabelFile(cobj.segmentationFile)
					times.extend(sgs)
					p.log( "Using segments from segmentation file %s (%i segments)"%(cobj.segmentationFile, len(sgs)) )
				for timeSeg in times:
					writeLine = [cobj.name]
					writeLine.extend(timeSeg)
					timeList.append( writeLine )
				cobj.numbSfFiles = 1
			elif fileType == 'dir': # a directory
				#######################
				## input a DIRECTORY ##
				#######################
				files = util.getDirListOnlyExt(cobj.name, cobj.recursive, AnalInterface.validSfExtensions)
				cobj.segmentationFile = None # don't print it
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
			stringMatchingWithFullPaths = True
			for idx in range(len(timeList)): 
				startSec = timeList[idx][1]
				endSec = timeList[idx][2]
				if cobj.start != None and startSec < cobj.start: continue # skip it
				if cobj.end != None and startSec > cobj.end: continue # skip it				
				# matchSting: includeStr/excludeStr
				if stringMatchingWithFullPaths:
					stringMatchPath = os.path.abspath(timeList[idx][0])
				else:
					stringMatchPath = os.path.split(timeList[idx][0])[1]
				if cobj.includeStr != None:
					skip = True
					if type(cobj.includeStr) not in [list, tuple]: cobj.includeStr = [cobj.includeStr]
					for test in cobj.includeStr:
						if util.matchString(stringMatchPath, test, caseSensative=True): skip = False
					if skip: continue
				if cobj.excludeStr != None:
					skip = False
					if type(cobj.excludeStr) not in [list, tuple]: cobj.excludeStr = [cobj.excludeStr]
					for test in cobj.excludeStr:
						if util.matchString(stringMatchPath, test, caseSensative=True): skip = True
					if skip: continue
				#        minTime / maxTime
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
						if startSec >= timeTuple[0] and startSec < timeTuple[1]: skip = True
					#print stringMatchPath, start, end, skip
					if skip: continue
				# see if there is any extra data from the segmentation file
				if len(timeList[idx]) > 3:
					segmentationfileData = ' '.join(timeList[idx][3:])
				else:
					segmentationfileData = None
				# test if limitDur is set...
				if cobj.limitDur != None:
					if endSec != None and endSec-startSec > cobj.limitDur: endSec = startSec+cobj.limitDur
				# see which sf to map sound concatenation onto...
				if cobj.concatFileName == None: concatFileName = timeList[idx][0]
				else: concatFileName = cobj.concatFileName
				# get any metadata
				metadata = ''
				for mstring, mstart, mstop in cobj.metadata:
					if startSec >= mstart and startSec <= mstop:
						metadata += mstring + ' '
				
				# see if global RESTRICT_CORPUS_SELECT_PERCENTAGE_BY_STRING applies
				maxPercentTargetSegmentsByString = None
				for restrictStr, restrictVal in restrictCorpusSelectionsByFilenameString.items():
					if util.matchString(timeList[idx][0], restrictStr): maxPercentTargetSegmentsByString = restrictVal

				
				self.preloadlist.append([timeList[idx][0], timeList[idx][1], timeList[idx][2], cobj.scaleDb, cobj.onsetLen, cobj.offsetLen, cobj.envelopeSlope, AnalInterface, concatFileName, cobj.name, cobj.voiceID, cobj.midiPitchMethod, totalLimitList, cobj.scaleDistance, cobj.superimposeRule, cobj.transMethod, cobj.transQuantize, cobj.allowRepetition, cobj.restrictInTime, cobj.restrictOverlaps, cobj.restrictRepetition, cobj.postSelectAmpBool, cobj.postSelectAmpMin, cobj.postSelectAmpMax, cobj.postSelectAmpMethod, segmentationfileData, metadata])
				vcCnt += 1
			self.data['cspInfo'].append( {'name': cobj.name, 'filehead': os.path.split(cobj.name)[1], 'segs': str(vcCnt), 'fileType': fileType, 'numbSfFiles': cobj.numbSfFiles, 'restrictInTime': cobj.restrictInTime, 'segFile': cobj.segmentationFile, 'restrictOverlaps': cobj.restrictOverlaps, 'scaleDb': cobj.scaleDb, 'maxPercentTargetSegments': cobj.maxPercentTargetSegments, 'selectedTargetSegments': []} )	
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
			cpsSeg = sfsegment.corpusSegment(*corpusSegParams)
			# add it to the list!
			self.preLimitSegmentList.append(cpsSeg)
		
		self.evaluatePreConcateLimitations()

		p.percentageBarClose(txt="Read %i/%i segments (%.0f%%, %.2f min.)"%(self.data['postLimitSegmentCount'], len(self.preLimitSegmentList), self.data['postLimitSegmentCount']/float(len(self.preLimitSegmentList))*100., self.data['totalLengthInSeconds']/60.))

		self.printConcateLimitations(p)


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
	############################################################################
	def printConcateLimitations(self, p): # return only same with a certain starting prefix
		# print corpus segment data
		for limitList in [self.globalLimits, self.localLimits]:	
			if len(limitList) > 0:
				p.pprint('LIMITS')
				for cpsLimitObj in limitList:
					cpsLimitObj.printRejects(self, p)
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
	def updateWithSelection(self, cpsh, timeInSec, tgtsegidx):
		if cpsh not in self.selectedSegmentList: self.selectedSegmentList.append(cpsh)
		self.data['lastVoice'] = cpsh.voiceID
		self.data['selectionTimeByVoice'][cpsh.voiceID].append(timeInSec)
		self.data['cspInfo'][cpsh.voiceID]['selectedTargetSegments'].append(tgtsegidx)
		cpsh.selectionTimes.append(timeInSec)
	############################################################################
	def setupConcate(self, tgtObj, AnalInterface):
		'''called when concate is initialized'''
		from userclasses import SingleDescriptor as d
		self.powerStats = sfsegment.getDescriptorStatistics(self.postLimitSegmentNormList, d('power'))
		self.totalNumberOfTargetSegments = len(tgtObj.segs)
		##########################################################
		## set up voice restriction per second as a frame value ##
		##########################################################
		self.voiceRestrictPerFrame = {}
		for voiceId, infoDict in enumerate(self.data['cspInfo']):
			if infoDict['restrictInTime'] > 0:
				self.voiceRestrictPerFrame[voiceId] = AnalInterface.s2f(infoDict['restrictInTime'], tgtObj.filename)/2
	############################################################################
	############################################################################
	def evaluateValidSamples(self, timeInFrames, timeInSec, tgtSegIdx, rotateVoices, voicePattern, voiceToCorpusIdMapping, clusterMappingDict, tgtclusterId, superimp):
		# get which voices are valid at this selection time
		if rotateVoices and self.data['lastVoice'] != None:
			validVoices = [(self.data['lastVoice']+1)%self.data['numberVoices']]
		elif voicePattern not in [None, []]: # not case sensative!, does a search, so matches partial strings
			validVoices = []
			for nidx, name in enumerate(self.data['vcToCorpusName']):
				if util.matchString(name, voicePattern[superimp.cnt['selectionCount']%len(voicePattern)], caseSensative=False):
					validVoices.append(nidx)
		elif voiceToCorpusIdMapping not in [None, [], {}]:
			realidx = tgtSegIdx%len(voiceToCorpusIdMapping)
			if type(voiceToCorpusIdMapping[realidx]) in [list, tuple]:
				validVoices = voiceToCorpusIdMapping[realidx]
			else:
				validVoices = [ voiceToCorpusIdMapping[realidx] ]
		else:
			validVoices = list(range(self.data['numberVoices']))
		########################################################
		## remove any voices that are outside temporal limits ##
		########################################################
		voicesToRemove = []
		# voice frequency restriction per frame...
		for vc in validVoices:
			if vc in self.voiceRestrictPerFrame:
				srt_look = int(max(0, timeInFrames-self.voiceRestrictPerFrame[vc]))
				end_look = int(min(timeInFrames+self.voiceRestrictPerFrame[vc], len(superimp.cnt['cpsvc_overlap'][vc])))
				if np.sum(superimp.cnt['cpsvc_overlap'][vc][srt_look:end_look]) != 0: 
					if vc not in voicesToRemove: voicesToRemove.append(vc)
		# restrict corpus ID by number of selected overlapping samples
		# uses eval() to test against overlap number...
		for vc in validVoices:
			if self.simSelectRuleByCorpusId[vc] != None:
				if not eval(str(superimp.cnt['overlap'][timeInFrames])+self.simSelectRuleByCorpusId[vc]):
					if vc not in voicesToRemove: voicesToRemove.append(vc)
		#
		# look to see if maxPercentTargetSegments has been exceeded
		for vc in validVoices:
			if self.data['cspInfo'][vc]['maxPercentTargetSegments'] == None: continue
			percentageSegmentsChosen = (float(len(set(self.data['cspInfo'][vc]['selectedTargetSegments'])))/float(self.totalNumberOfTargetSegments))*100.
			if percentageSegmentsChosen > self.data['cspInfo'][vc]['maxPercentTargetSegments']: voicesToRemove.append(vc)
			
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

			#########################################
			## remove based on clustering if asked ##
			#########################################
			if clusterMappingDict != {} and h.cluster != None and h.cluster != tgtclusterId: continue

			# if allowRepetition is False then test
			if not h.allowRepetition and len(h.selectionTimes) > 0: continue # skip this segment

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
			
			# user string overlap restriction
			for str, (counter, limit) in superimp.cnt['corpusOverlapByString'].items():
				if util.matchString(h.filename, str):
					max_look = min(timeInFrames+h.lengthInFrames, len(superimp.cnt['corpusOverlapByString'][str][0]))
					maxOver = np.max(superimp.cnt['corpusOverlapByString'][str][0][timeInFrames:max_look])
					if maxOver >= limit: continue

			


			validSegments.append(h)
		return validSegments



	############################################################################
#	def printCorpusInfo(self):
#		postLevel = 2
#		printNumbSegsOrFiles = True
#		printLimits = True
#		# get number of total potential segments
#		totalSegs = 0
#		for name, dict in self.corpusPrintData.items(): totalSegs += int(dict['segs'])
#		p.middle('Corpus - '+str(totalSegs)+' Possible Segments', postLevel)
#		
#		for name, dict in self.corpusPrintData.items():
#			if dict['segFile'] != None: # make a printable list of segmentation files
#				tmp = []
#				for item in dict['segFile']:
#					tmp.append(os.path.split(item)[1])
#				name = ','.join(tmp)
#			
#			end = dict['limitEnd']
#			if end == sys.maxsize: end = 'end'
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
#					for key, valDict in dict['limit'].items():
#						restrict = [None, None]
#						for item, value in valDict.items():
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
	def __init__(self, tgtlength, tgtlengthsegs, overlap_inc_amp, peakAlign, peakAlignEnvelope, cpsentrylength, corpusOverlapByStringDict, p):
		self.p = p
		self.cnt = {'onset': np.zeros(tgtlength), 'overlap': np.zeros(tgtlength), 'segidx': np.zeros(tgtlengthsegs), 'cpsvc_overlap': np.zeros((cpsentrylength, tgtlength)), 'selectionCount': 0, 'cpsnames': [], 'corpusOverlapByString': {}}
		
		for str, val in corpusOverlapByStringDict.items():
			self.cnt['corpusOverlapByString'][str] = [np.zeros(tgtlength), val]

		self.choiceCnt = 0 # tracks number of decisions made
		self.overlap_inc_amp = util.dbToAmp(overlap_inc_amp)
		self.peakAlign = peakAlign
		self.peakAlignEnvelope = peakAlignEnvelope
		self.histogram = {'select': [], 'skip': {}}
	########################################
	def test(self, type, time, min, max):
		pick = 'ok' # 'ok', 'notok', 'force'
		if min != None and self.cnt[type][time] < min: pick = 'force'
		if max != None and len(self.cnt[type]) > time and self.cnt[type][time] >= max: pick = 'notok'
		return pick	
	########################################
	def increment(self, start, dur, segidx, cps_voiceid, powers, logtext, corpusname, cpsfilename):
		self.p.log( logtext )
		self.cnt['segidx'][segidx] += 1
		self.cnt['onset'][start] += 1
		self.cnt['selectionCount'] += 1
		self.cnt['cpsnames'].append(corpusname)
		self.histogram['select'].append(start)
		self.choiceCnt += 1
		for f in range(dur):
			try:
				if powers[f] >= self.overlap_inc_amp:
					self.cnt['overlap'][start+f] += 1
					self.cnt['cpsvc_overlap'][cps_voiceid][start+f] += 1
					for str in self.cnt['corpusOverlapByString']:
						if util.matchString(cpsfilename, str):
							self.cnt['corpusOverlapByString'][str][0][start+f] += 1
			except IndexError: break # cps handle data not long enough
	########################################
	def skip(self, reason, value, timeinSec):
		if not reason in self.histogram['skip']:
			self.histogram['skip'][reason] = []
		self.histogram['skip'][reason].append(value)
		#self.p.log( "SKIP @ %.2f -- %s (%s)"%(timeinSec, reason, value) )
		self.choiceCnt += 1
	########################################
	def pick(self, trig, trigVal, onsett, overt, segidxt, timeinSec):
		if not trig and onsett == 'force':
			pass
			#self.p.log( "SELECT @ %.2f -- target too soft but forced to by minOnset"%(timeinSec) )
		elif not trig and overt == 'force':
			pass
			#self.p.log( "SELECT @ %.2f -- target too soft but forced to by minOverlap"%(timeinSec) )
		elif not trig and segidxt == 'force':
			pass
			#self.p.log( "SELECT @ %.2f -- target too soft but forced to by minSegment"%(timeinSec) )
		else:
			pass
			#self.p.log( "SELECT @ %.2f (t=%.2f)"%(timeinSec, trigVal) )





class outputEvent:
	def __init__(self, sfseghandle, timeInScore, ampBoost, transposition, tgtseg, simSelects, tgtsegdur, tgtsegnumb, stretchcode, f2s, durationSelect, durationMin, durationMax, alignPeaksBool, minOutputMidi=21):		
		# cps segment stuff
		self.sfseghandle = sfseghandle
		self.filename = sfseghandle.concatFileName
		self.printName = sfseghandle.printName
		self.sfSkip = sfseghandle.segmentStartSec
		self.cpsduration = sfseghandle.segmentDurationSec
		self.effDurSec = sfseghandle.desc['effDur-seg'].get(0, None)
		self.peaktimeSec = sfseghandle.desc['peakTime-seg'].get(0, None) * f2s
		self.powerSeg = sfseghandle.desc['power-seg'].get(0, None)
		self.rmsSeg = util.ampToDb(self.powerSeg)
		self.midiVelocity = self.rmsSeg+127
		if self.midiVelocity > 127: self.midiVelocity = 127
		if self.midiVelocity < 10: self.midiVelocity = 10
		# tgt stuff
		self.tgtsegstart = tgtseg.segmentStartSec
		self.tgtsegpeak = tgtseg.originalPeak*f2s
		self.tgtsegdur = tgtsegdur
		self.tgtsegnumb = tgtsegnumb
		self.stretchcode = stretchcode
		self.simSelects = simSelects
		self.sfchnls = sfseghandle.soundfileChns
		# audioguide stuff
		self.transposition = transposition
		self.transratio = 2 ** (transposition/12.)
		self.voiceID = sfseghandle.voiceID
		self.extraDataFromSegmentationFile = sfseghandle.segfileData
		self.midiFromFilename = sfseghandle.desc['MIDIPitch-seg'].get(0, None)
		self.midiPitch = self.midiFromFilename + self.transposition
		if self.midiPitch < minOutputMidi: self.midiPitch = minOutputMidi
		self.metadata = sfseghandle.metadata
		# amplitude envelope
		self.envDb = ampBoost
		self.envAttackSec = sfseghandle.envAttackSec
		self.envDecaySec = sfseghandle.envDecaySec
		self.envSlope = sfseghandle.envSlope
		self.classification = sfseghandle.classification
		
		# test for which duration to use - the target's or the corpus'
		if durationSelect == 'cps':
			self.duration = self.cpsduration * (1./self.transratio)
		elif durationSelect == 'tgt':
			self.duration = self.tgtsegdur

		# duration min/max
		if durationMin != None and self.duration < durationMin:
			newEndSec = min(self.sfSkip+durationMin, self.sfseghandle.soundfileTotalDuration)
			self.duration = newEndSec-self.sfSkip
		if durationMax != None and self.duration > durationMax:
			self.duration = durationMax
			
		# align peak of tgt and cps segments?
		self.timeInScore = timeInScore
		if alignPeaksBool:
			eventPeak = timeInScore+(self.peaktimeSec*(1./self.transratio))
			tgtPeak = self.tgtsegstart+self.tgtsegpeak
			#print("\n\n", timeInScore, self.peaktimeSec, self.tgtsegstart, self.tgtsegpeak, tgtPeak-eventPeak, "\n\n", )
			self.timeInScore += tgtPeak-eventPeak

		
	####################################	
	def makeCsoundOutputText(self, channelMethod, instru=1):
		if channelMethod == 'mix': channelMethod = 'stereo' # to support deprecated mix option
		return "i%i  %.3f  %.3f  %.3f  \"%s\"  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %.3f  %i  %i  %f  %i  %i  \"%s\"  \"%s\"\n"%(instru, self.timeInScore, self.duration, self.envDb, self.filename, self.sfSkip, self.transposition, self.rmsSeg, self.peaktimeSec, self.effDurSec, self.envAttackSec, self.envDecaySec, self.envSlope, self.voiceID, self.simSelects, self.tgtsegdur, self.tgtsegnumb, self.classification, self.stretchcode, channelMethod)
	####################################	
	def makeLabelText(self):
		if self.metadata != '':
			text=self.metadata
		elif self.sfSkip == 0:
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
		for key in ['timeInScore', 'sfchnls', 'duration', 'envAttackSec', 'envDecaySec', 'envSlope', 'filename', 'peaktimeSec', 'sfSkip', 'transposition', 'tgtsegnumb', 'envDb']:
			dicty[key] = getattr(self, key)
	
		dicty['corpusIdNumber'] = self.voiceID
		dicty['classificationNumber'] = self.classification
		dicty['simultaneousSelectionNumber'] = self.simSelects
		
		dicty['peakRms'] = self.powerSeg
		dicty['peakRmsDb'] = util.ampToDb(self.powerSeg)
		dicty['midiPitch'] = self.midiFromFilename
		dicty['envScaleDb'] = self.envDb
		return dicty
	####################################	
	def makeSegmentationDataText(self):
		return "%.3f  %.3f  %s  %.3f  %s"%(self.timeInScore, self.duration, self.filename, self.sfSkip, self.extraDataFromSegmentationFile)
	####################################	
	def makeMaxMspListOutput(self):
		# time values in milliseconds!
		return [round(self.timeInScore*1000., 1), round(self.duration*1000., 1), self.filename, round(self.sfSkip*1000., 1), self.envDb, self.transposition, round(self.envAttackSec*1000., 1), round(self.envDecaySec*1000., 1)]



def quantizeTime(outputEvents, method, interval, p):
	if method == None:
		'''Does nothing'''
		return
		
	p.pprint('Quantizing selected events into slices of %.2f seconds according to %s\n'%(interval, method))
	
	if method == 'snapToGrid':
		'''Quantize each note's start time to the nearest value
		of OUTPUTEVENT_QUANTIZE_TIME_INTERVAL seconds'''
		for oe in outputEvents:
			oe.timeInScore = (int(oe.timeInScore/interval))*interval
		
	elif method == 'medianAggregate':
		'''Sets each note's start time to the median time
		of notes found in time slices of OUTPUTEVENT_QUANTIZE_TIME_INTERVAL
		length in seconds.'''
		lastEvent = outputEvents[-1].timeInScore
		for oe in outputEvents:
			oe.quantizeInx = int(oe.timeInScore/interval)
		
		for qstep in range(int(lastEvent/interval)+1):
			found = []
			for oe in outputEvents: 
				if oe.quantizeInx == qstep: found.append(oe)
			if len(found) == 0: # nothing here
				continue
			qstepMedianTime = np.median([oe.timeInScore for oe in found])
			for oe in found: oe.timeInScore = qstepMedianTime


	else:
		util.error("QUANTIZATION", "no quantization method called %s"%method)
		
