import sys, os, subprocess
sys.path.insert(0, os.path.dirname(__file__)) # look here first
import pysdif
import numpy as np
import util

try:
	import json as json
except ImportError:
	import simplejson as json


def findbin(userstring, filehead, searchdirectories=['/Applications', os.path.join(os.getenv("HOME"), 'Applications')]):
	if userstring != None and os.path.isabs(userstring) and os.path.exists(userstring): return userstring
	elif userstring != None and os.path.exists(userstring): return os.path.abspath(userstring)
	for possibledir in searchdirectories:
		attempt = os.path.join(possibledir, filehead)
		if os.path.exists(attempt): return os.path.abspath(attempt)
	# didn't find anything
	return None	
	
class SdifInterface:
	def __init__(self, pm2_bin=None, supervp_bin=None, winLengthSec=0.12, hopLengthSec=0.02, resampleRate=12500, windowType='blackman', numbMfccs=23, F0MaxAnalysisFreq=3000, F0MinFrequency=200, F0MaxFrequency=1000, F0AmpThreshold=30, F0Quality=0.2, numbPeaks=12, numbClust=8, clustDescriptDict={'mfcc1': 1, 'mfcc2': 1, 'mfcc3': 1, 'mfcc4': 1, 'mfcc5': 1}, forceAnal=False, p=None, validSfExtensions=['.aiff', '.wav', '.aif'], searchPaths=[]):	
		self.ircamdescriptor_bin = os.path.join( os.path.dirname(__file__), 'ircamdescriptor-2.8.6' )
		
		# check for other bin files #
		self.pm2_bin = findbin(pm2_bin, 'AudioSculpt3.0b7/Kernels/pm2')
		self.supervp_bin = findbin(supervp_bin, 'AudioSculpt3.0b7/Kernels/supervp')
		print self.pm2_bin, self.supervp_bin
		
		# other stuff
		self.forceAnal = forceAnal
		self.p = p
		# anal
		self.winLengthSec = winLengthSec
		self.hopLengthSec = hopLengthSec
		self.resampleRate = resampleRate
		self.windowType = windowType
		self.numbMfccs = numbMfccs
		self.F0MaxAnalysisFreq = F0MaxAnalysisFreq
		self.F0MinFrequency = F0MinFrequency
		self.F0MaxFrequency = F0MaxFrequency
		self.F0AmpThreshold = F0AmpThreshold
		self.F0Quality = F0Quality
		self.numbPeaks = numbPeaks
		# CLUSTER ANALYSIS
		self.numbClust = numbClust
		self.clustDescriptDict = clustDescriptDict			
		# PEAKS SUPERVP ANALYSIS
		self.peaksThreshold = 70
		# PARTIALS PM2
		self.partialThreshold = 70
		self.maxpartials = 12
		self.minParConnectSec = 0.317000001
		self.minParConnectFrqRatio = 1.28920708
		self.minParDuration = 0.0
		self.agDescriptToSdif = agDescriptToSdif
		self.halfWinLengthSec = self.winLengthSec / 2.0
		
		# other linkages
		self.validSfExtensions = validSfExtensions
		self.searchPaths = searchPaths
		# mfccs
		for b in range(self.numbMfccs):
			self.agDescriptToSdif['mfcc%i'%b] = ('descriptors', False, True, '1DSC', '1MFC', b, 0)
		# peaks
		#for p in range(self.numbPeaks):
		#	self.agDescriptToSdif['peakfrq%i'%p] = ('peaks', False, False, '1PIC', '1PIC', p, 0)
		#	self.agDescriptToSdif['peakamp%i'%p] = ('peaks', False, False, '1PIC', '1PIC', p, 1)
		# partials
		#for p in range(self.maxpartials):
		#	self.agDescriptToSdif['partialfrq%i'%p] = ('partials', False, False, '1TRC', '1TRC', p, 1)
		#	self.agDescriptToSdif['partialamp%i'%p] = ('partials', False, False, '1TRC', '1TRC', p, 2)
		# cluster centroids
		#for p in range(len(self.clustDescriptDict)):
		#	self.agDescriptToSdif['cluster_cent%i'%p] = ('cluster', False, True, '1CLT', '1CSD', 0, p+1)

		self.rawData = {} # file, descriptdict
		descriptors = ['SignalZeroCrossingRate', 'AutoCorrelation', 'TotalEnergy', 'SpectralCentroid', 'SpectralSpread', 'SpectralSkewness', 'SpectralKurtosis', 'SpectralSlope', 'SpectralDecrease', 'SpectralRolloff', 'SpectralVariation', 'Loudness', 'Spread', 'Sharpness', 'PerceptualSpectralCentroid', 'PerceptualSpectralSpread', 'PerceptualSpectralSkewness', 'PerceptualSpectralKurtosis', 'PerceptualSpectralSlope', 'PerceptualSpectralDecrease', 'PerceptualSpectralRolloff', 'PerceptualSpectralVariation', 'PerceptualSpectralDeviation', 'PerceptualOddToEvenRatio', 'PerceptualTristimulus', 'MFCC', 'SpectralFlatness', 'SpectralCrest', 'FundamentalFrequency', 'NoiseEnergy', 'Noisiness', 'Inharmonicity', 'HarmonicEnergy', 'HarmonicSpectralCentroid', 'HarmonicSpectralSpread', 'HarmonicSpectralSkewness', 'HarmonicSpectralKurtosis', 'HarmonicSpectralSlope', 'HarmonicSpectralDecrease', 'HarmonicSpectralRolloff', 'HarmonicSpectralVariation', 'HarmonicSpectralDeviation', 'HarmonicOddToEvenRatio', 'HarmonicTristimulus', 'Chroma']
		energydescriptors = ['TemporalIncrease', 'TemporalDecrease', 'TemporalCentroid', 'EffectiveDuration', 'AmplitudeModulation', 'EnergyEnvelope']
		dlist = ';~~~~~~~~~~~~~~~~~~~descriptors~~~~~~~~~~~~~~~~~~~~~\n'
		for d in descriptors: dlist += d+'  = ShortTime\n'
		edlist = ';~~~~~~~~~~~~~~~~energy descriptors~~~~~~~~~~~~~~~~\n'
		for d in energydescriptors: edlist += d+'  = 1\n'
		### setup ircam binary config text file	
		self.sdifdir = os.path.join(os.path.dirname(__file__), 'data_sdif')
		if not os.path.exists(self.sdifdir): os.makedirs(self.sdifdir)
		self.config_loc = os.path.join(self.sdifdir, 'ircamdescriptor.config.txt')
		self.config_text = '''[Parameters]
ResampleTo = %i
NormalizeSignal = 0
SubtractMean = 1
IOBufferSize = 2048
SaveShortTermTMFeatures = 1
WindowType = %s

[StandardDescriptors]
WindowSize = %f
HopSize = %f
TextureWindowsFrames = -1
TextureWindowsHopFrames = -1		
MFCCs = %i
Harmonics = 12
DeviationStopBand = 10
RolloffThreshold = 0.95
DecreaseThreshold = 0.4
NoiseThreshold = 0.15
F0MaxAnalysisFreq = %i
F0MinFrequency = %i
F0MaxFrequency = %i
F0AmpThreshold = %i
F0Quality = %f

%s

[EnergyDescriptors]

WindowSize = %f
HopSize = %f
TextureWindowsFrames = -1
TextureWindowsHopFrames = -1

%s'''%(self.resampleRate, self.windowType, self.winLengthSec, self.hopLengthSec, self.numbMfccs, self.F0MaxAnalysisFreq, self.F0MinFrequency, self.F0MaxFrequency, self.F0AmpThreshold, self.F0Quality, dlist, self.winLengthSec, self.hopLengthSec, edlist)
		# make a list of all possible descriptor objects
		self.allDescriptors = []
		from UserClasses import SingleDescriptor as d
		for desc in self.agDescriptToSdif:
			dobj = d(desc)
			self.allDescriptors.append( dobj )
			if not dobj.seg:
				segmented = d(desc+'-seg')
				self.allDescriptors.append( segmented )
	#############################
	def addDescriptorIfNeeded(self, dobjToCheck, ops, addParents=False):
		from UserClasses import SingleDescriptor as d
		if dobjToCheck.name not in [dn.name for dn in self.requiredDescriptors]:
			self.requiredDescriptors.append(dobjToCheck)
		if addParents:
			for pname in dobjToCheck.parents:
				self.addDescriptorIfNeeded(d(pname, origin=dobjToCheck.origin+'_PARENT'), ops)
	#############################
	def expandDescriptorPackages(self, ops):
		for spass in ops.SEARCH:
			spass.descriptor_list = descriptListPackageExpansion(spass.descriptor_list, ops.IRCAMDESCRIPTOR_NUMB_MFCCS, ops.SUPERVP_NUMB_PEAKS)
	#############################
	def getDescriptorLists(self, ops):
		self.expandDescriptorPackages(ops)
		
		from UserClasses import SingleDescriptor as d
		self.requiredDescriptors = []
		# add SEARCH descriptors
		for spass in ops.SEARCH:
			for dobj in spass.descriptor_list:
				#dobj.origin = 'SEARCH'
				self.addDescriptorIfNeeded(dobj, ops, addParents=True)
		# add target onset descriptors
		for dname, weight in ops.TARGET_ONSET_DESCRIPTORS.items():
			self.addDescriptorIfNeeded(d(dname, weight=weight, origin='TARGET_ONSET'), ops)
		# add limiting descriptors
		if ops.CORPUS_GLOBAL_ATTRIBUTES.has_key('limit'):
			for stringy in ops.CORPUS_GLOBAL_ATTRIBUTES['limit']:
				self.addDescriptorIfNeeded(d(stringy.split()[0], origin='GLOBAL_LIMIT'), ops)
		# add ordering by descriptor
		if None not in [ops.ORDER_CORPUS_BY_DESCRIPTOR, ops.ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH]:
			self.addDescriptorIfNeeded(d(ops.ORDER_CORPUS_BY_DESCRIPTOR, weight=0, origin='ORDER_CORPUS_BY_DESCRIPTOR'), ops, addParents=True)
		for dname, weight in ops.TARGET_ONSET_DESCRIPTORS.items():
			self.addDescriptorIfNeeded(d(dname, weight=weight, origin='TARGET_ONSET'), ops)
		# add internal mectrics if not already used
		internalDescriptorNames = ['power', 'peakTime-seg', 'power-seg', 'power-mean-seg', 'effDur-seg', 'f0-seg', 'MIDIPitch-seg']
		for dname in internalDescriptorNames:
			self.addDescriptorIfNeeded(d(dname, origin='INTERNAL'), ops, addParents=True)
		# make normalisation list!
		self.normalizeDescriptors = []
		for dobj in self.requiredDescriptors:
			if dobj.origin == 'SEARCH': self.normalizeDescriptors.append(dobj)
		# make mixture list!
		self.mixtureDescriptors = []
		tmpmix = ['power']
		for dobj in self.requiredDescriptors:
			if dobj.origin == 'SEARCH' and dobj.is_mixable:
				if dobj.seg: tmpmix.append(dobj.name) # make sure segs are at the end
				else: tmpmix.insert(0, dobj.name)
				for pobjname in dobj.parents: tmpmix.insert(0, pobjname)
		for dname in tmpmix:
			for dobj in self.requiredDescriptors:
				if dobj.name == dname:
					self.mixtureDescriptors.append(dobj)
					break

	########################################################
	########################################################
	def logcommand(self, command):
		return
		if self.p in [None, False]: return
		if type(command) in [list, tuple]:
			encoded = unicode('')			
			for arg in command:
				print arg, type(arg)
				encoded += unicode(arg)
			self.p.write('SDIFLINKAGE: %s\n\n'%encoded)
		else:
			self.p.write('SDIFLINKAGE: %s\n\n'%command)
	########################################################
	########################################################
	def f2s(self, frame):
		'''descriptor frame to time in seconds'''
		#sec = (frame*self.hopLengthSec) + (self.winLengthSec / 2.0)
		sec = (frame*self.hopLengthSec)
		#print "\nFRAME %i to SECOND %f\n\n"%(frame, sec)
		return sec
	########################################################
	########################################################
	def s2f(self, sec, sffile, minimum=0):
		'''time in seconds to time in frames.  need the 
		filename to know the sample rate of the sdif analysis.'''
		hopLengthSamp = int(self.rawData[sffile]['info']['sr']*self.hopLengthSec)
		sampLen = (self.rawData[sffile]['info']['sr'] * sec)
		durf = max(minimum, int((sampLen/hopLengthSamp)-((self.winLengthSec/self.hopLengthSec)-1)) )
		return durf
	########################################################
	########################################################
	def validateSdifResource(self, sffile):
		sffile = os.path.abspath(sffile)
		if not self.rawData.has_key(sffile):
			self.initSdifResource(sffile)
		return self.rawData[sffile]['info']['lengthsec'], self.rawData[sffile]['info']['channels']
	########################################################
	########################################################
	def removeSdifResource(self, sffile):
		sffile = os.path.abspath(sffile)
		if self.rawData.has_key(sffile):
			del self.rawData[sffile]
	########################################################
	########################################################
	def getSdifFileName(self, filetype, sffile, manualCheck=None):
		if manualCheck == None:
			return self.rawData[sffile]['sdiffileroot']+'-'+filetype+'-'+self.rawData[sffile]['checksum']+'.sdif'
		else: 
			return self.rawData[sffile]['sdiffileroot']+'-'+filetype+'-'+manualCheck+'.sdif'
	########################################################
	########################################################
	def initSdifResource(self, sffile):
		'''if analysis files don't exist, this function automatically makes
		the ircamdescriptor SDIF analysis because it is required for all
		sound files used.  then checks to see if we need other sdif files
		made -- such as peaks with supervp or partials with pm2.'''
		self.rawData[sffile] = {}
		sfroot, sfhead = os.path.split(sffile)
		sfheadroot, sfheadext = os.path.splitext(sfhead)
		jsondir = os.path.join(os.path.dirname(__file__), 'data_json')
		if not os.path.exists(jsondir): os.makedirs(jsondir)
		self.rawData[sffile]['sdiffileroot'] = os.path.join(self.sdifdir, sfheadroot)
		self.rawData[sffile]['jsonfileroot'] = os.path.join(jsondir, sfheadroot)
		self.rawData[sffile]['checksum'] = listToCheckSum([sffile, self.resampleRate, self.windowType, self.numbMfccs, self.numbMfccs, self.winLengthSec, self.hopLengthSec, self.F0MaxAnalysisFreq, self.F0MinFrequency, self.F0MaxFrequency, self.F0AmpThreshold, self.F0Quality])

		descriptorfile = self.getSdifFileName('descriptors', sffile)
		infofile = '%s-%s.json'%(self.rawData[sffile]['jsonfileroot'], listToCheckSum([sffile]))
		
		self.rawData[sffile]['info'] = {}
		if os.path.exists(infofile) and os.path.exists(descriptorfile) and not util.checkIfFileIsNewer(sffile, infofile) and not self.forceAnal:
			if self.p != None: self.p.log("SDIF DATA: loading %s"%descriptorfile)
			self.rawData[sffile]['info'].update(json.load(open(infofile, 'r')))
		else:	# then we need to run ircam descriptor analysis
			# write tmp config files
			fh = open(self.config_loc, 'w')
			fh.write(self.config_text)
			fh.close()
			command = [self.ircamdescriptor_bin, sffile, self.config_loc, '-o'+descriptorfile]
			self.logcommand(command)
			if self.p != None:
				self.p.log("SDIF DATA: creating SDIF FILE '%s'"%command)
			self.rawData[sffile]['info'] = util.popen_execute_command(command, stdoutReturnDict={('sr', 0): ('sr', 2, int), ('samples', 0): ('lengthsamples', 2, int), ('channel(s):', 0): ('channels', 1, int)})
			
			self.rawData[sffile]['info']['lengthsec'] = self.rawData[sffile]['info']['lengthsamples']/float(self.rawData[sffile]['info']['sr'])
			jh = open(infofile, 'w')
			json.dump(self.rawData[sffile]['info'], jh)
			jh.close()
		
		self.rawData[sffile]['arraylen'] = self.s2f(self.rawData[sffile]['info']['lengthsec'], sffile, minimum=1)

		self.rawData[sffile]['loaded'] = False
	########################################################
	########################################################
	def PartialAnalysis(self, sffile):
		analfile = self.getSdifFileName('partials', sffile)
		if not os.path.exists(analfile) and not self.forceAnal:
			windowsize = self.winLengthSec*self.rawData[sffile]['info']['sr']
			oversamp = self.winLengthSec/self.hopLengthSec
			command = '%s --quiet -t -S%s -Apar  -N%i -M%i --oversamp=%i -Whamming  -OS -p1 --mode=0 -q%i -m%i -a0 -r0 -Ct%f -Cf%f --devFR=0.059463143 --devFC=0 --devA=0.5 --devM=1 --devK=3 -L%f %s'%(self.pm2_bin, sffile, windowsize, windowsize, oversamp, self.maxpartials, self.partialThreshold, self.minParConnectSec, self.minParConnectFrqRatio, self.minParDuration, analfile)
			print
			print
			print command
			print
			print 
			self.logcommand(command)

			util.popen_execute_command(command.split()) 
	########################################################
	########################################################
	def PeakAnalysis(self, sffile):
		analfile = self.getSdifFileName('peaks', sffile)
		if not os.path.exists(analfile) and not self.forceAnal:
			windowsize = self.winLengthSec*self.rawData[sffile]['info']['sr']
			oversamp = self.winLengthSec/self.hopLengthSec
			command = [self.supervp_bin, '-quiet', '-t', '-ns', '-U', '-S'+sffile, '-Apic', '25', 'n%i'%self.numbPeaks, '-Np0', '-M%fs'%self.winLengthSec, '-oversamp', '%i'%oversamp, '-Whamming', '-OS0', analfile]
			self.logcommand(command)
			util.popen_execute_command(command, exitOnError=False) 
			# supervp is fucked up and streams A LOT of data to stderr.  why would those mofos do something like that?
	########################################################
	########################################################
#	def ClusterIdAnalysis(self, sffile):
#		import numpy as np
#		ops = self.ops
#
#
#		tgtchecksumlist = [ops.TARGET.name, ops.TARGET.start, ops.TARGET.end, ops.TARGET_SEGMENT_OFFSET_DB_ABS_THRESH, ops.TARGET_SEGMENT_OFFSET_DB_REL_THRESH, ops.CLUSTERANAL_NUMB_CLUSTS]
#		tgtchecksumlist.extend(ops.CLUSTERANAL_DESCRIPTOR_DIM)
#
#
#		needDescriptors = ['power']
#		needDescriptors.extend(ops.CLUSTERANAL_DESCRIPTOR_DIM)
#		# target cluster
#		tmpData = {ops.TARGET.name: {}}
#		self.getDescriptorSegment(ops.TARGET.name, ops.TARGET.start, ops.TARGET.end, needDescriptors, tmpData[ops.TARGET.name], None)
#		minP = min(tmpData[ops.TARGET.name]['power'])
#		if minP < util.dbToAmp(ops.TARGET_SEGMENT_OFFSET_DB_ABS_THRESH): # use absolute threshold
#			powerOffsetValue = util.dbToAmp(ops.TARGET_SEGMENT_OFFSET_DB_ABS_THRESH)
#		else:
#			powerOffsetValue = minP*util.dbToAmp(ops.TARGET_SEGMENT_OFFSET_DB_REL_THRESH)
#		valididxs = []
#		for pidx in range(len(tmpData[ops.TARGET.name]['power'])):
#			if not tmpData[ops.TARGET.name]['power'][pidx] > powerOffsetValue: continue
#			valididxs.append(pidx)
#		# fill target array
#		tgtCoors = np.empty((len(valididxs), len(ops.CLUSTERANAL_DESCRIPTOR_DIM)))
#		tgtClusterIds = np.empty(len(tmpData[ops.TARGET.name]['power']))
#		tgtClusterIds.fill(-1)
#		for idx, tidx in enumerate(valididxs):
#			for didx, d in enumerate(ops.CLUSTERANAL_DESCRIPTOR_DIM):
#				tgtCoors[idx][didx] = tmpData[ops.TARGET.name][d][tidx]
#		tcAssignment, targetCentroids, targetlens = clusterAnalysis(tgtCoors, ops.CLUSTERANAL_NUMB_CLUSTS)
#		#print tcAssignment, targetCentroids, targetlens
#		# fill in valid frames to total array
#		for idx, tidx in enumerate(valididxs):
#			tgtClusterIds[tidx] = tcAssignment[idx]
#		# done target
#		for sf in ag.preLimitCpsHandles:
#			print sf.name
#		
#		
#
#		# alter target and corpus entries so that they include full paths.
#		allOps = {}
#		outputFile = '/tmp/ag-sdifanal.config.py'
#		# make full paths for corpus and target entries so that we find the right file on an outboard analysis
#		allOps.update(self.ops.userOps)
#		del allOps['AG_PATH']
#		del allOps['DEFAULT_PATH']
#		del allOps['OPS_PATH']
#		del allOps['SCRIPT_PATH']
#		allOps['SEARCH'] = []
#		for anal in self.ops.CLUSTERANAL_DESCRIPTOR_DIM:
#			allOps['SEARCH'].append('d("%s", weight=1)'%(anal))
#		allOps['SEARCH'] = '[spass("closest", %s)]'%', '.join(allOps['SEARCH'])
#		allOps['VERBOSITY'] = 0
#		allOps['LOG_FILEPATH'] = None
#		allOps['TARGET_SEGMENT_LABELS_FILEPATH'] = None
#		checksumlist = []
#		outputh = open(outputFile, 'w')
#		for k, v in allOps.iteritems():
#			checksumlist.extend((k, str(v)))
#			if type(v) == str and k != 'SEARCH':
#				outputh.write('%s = "%s"\n'%(k, v))
#			else:
#				outputh.write('%s = %s\n'%(k, v))
#		outputh.close()
#		
#		manual_checksum = listToCheckSum([checksumlist])
#
#		analfile = self.getSdifFileName('cluster', sffile, manualCheck=manual_checksum)
#		if os.path.exists(analfile) and not self.forceAnal: return analfile
#		print "\n\nMAKING A CLUSTER-ID SDIF ANALYSIS"
#		print "\tTARGET: %s"%self.ops.userOps['TARGET'].name
#		#print "\tCORPUS: %s"%self.ops.userOps['CORPUS']
#		print "\tCLUSTER DIMENSIONS: %s"%self.ops.CLUSTERANAL_DESCRIPTOR_DIM
#		print "\tNUMBER OF CLUSTERS: %s\n\n"%self.ops.CLUSTERANAL_NUMB_CLUSTS
#		command = '%s %s %s %s'%(os.path.join(self.ops.userOps['AG_PATH'], 'scripts', 'make_clusterid_sdif.py'), self.ops.userOps['AG_PATH'], outputFile, manual_checksum)
#		print command
#		self.logcommand(command)
#		executeCommand(command)
#		return analfile
	########################################################
	########################################################
	def loadDescriptorSdifData(self, sffile, descriptList):
		sffile = os.path.abspath(sffile)
		self.rawData[sffile]['neededfiles'] = {}
		self.rawData[sffile].update({ 'load': {}, 'load_cnt': {} })
		for d in descriptList:	
			if type(d) == str: name = d
			else: name = d.name
			# find out which files to query
			filetype, energyBool, mixBool, frame, matrix, row, col = agDescriptToSdif[name]
			if filetype not in self.rawData[sffile]['neededfiles']: self.rawData[sffile]['neededfiles'][filetype] = {}
			self.rawData[sffile]['neededfiles'][filetype][name] = frame, matrix, row, col
			# make data space
			self.rawData[sffile]['load'][name] = np.zeros(self.rawData[sffile]['arraylen'])
			self.rawData[sffile]['load_cnt'][name] = 0
		# done alloc memory	
		# make peak of partials analysis if neede byt the descriptrs that the user wants
		customNames = {}
		if self.rawData[sffile]['neededfiles'].has_key('partials'): # need pm2 analysis!
			self.PartialAnalysis(sffile)
		if self.rawData[sffile]['neededfiles'].has_key('peaks'): # need supervp analysis!
			self.PeakAnalysis(sffile)
#		if self.rawData[sffile]['neededfiles'].has_key('cluster'): # need supervp analysis!
#			customnamed = self.ClusterIdAnalysis(sffile)
#			customNames['cluster'] = customnamed

		# loop over needed files
		for filetype in self.rawData[sffile]['neededfiles']:
			reqFrameTypes = []
			frameMatrixDict = {}
			for name, (frame, matrix, row, col) in self.rawData[sffile]['neededfiles'][filetype].iteritems():
				if frame not in reqFrameTypes: reqFrameTypes.append(frame)
				if not frameMatrixDict.has_key((frame, matrix)):
					frameMatrixDict[(frame, matrix)] = []
				frameMatrixDict[(frame, matrix)].append((name, row, col))
			#print "READ", filetype, frameMatrixDict, reqFrameTypes
			if customNames.has_key(filetype):
				file = customNames[filetype]
			else:
				file = self.getSdifFileName(filetype, sffile)
			if not os.path.exists(file):
				print "CANNOT FIND", file
				sys.exit()
			
			sdfh = pysdif.SdifFile(file)
			#self.sdif_testprint(file)
			valid_f = 0
			for f in sdfh:
				if f.signature not in reqFrameTypes: continue
				if len(f) <= 1: continue
				for m in f:
					if not frameMatrixDict.has_key((f.signature, m.signature)): continue
					for name, col, row in frameMatrixDict[(f.signature, m.signature)]:
						self.rawData[sffile]['load'][name][valid_f] = m.get_data(copy=False)[col][row]
						#if name == 'power':
						#	print "power %f at %f"%(m.get_data(copy=False)[col][row], f.time)
				valid_f += 1
				if valid_f > self.rawData[sffile]['arraylen']-1: break
			sdfh.close()
			self.logcommand("read %i frames from %s"%(valid_f, file))
			#sys.exit()
		self.rawData[sffile]['loaded'] = True
	########################################################
	########################################################
	def getDescriptorSegment(self, sffile, startsec, endsec, descriptList, dataDest, envelopeMask):
		sffile = os.path.abspath(sffile)
		# load THE WHOLE file's data -- only happens on the first call
		if not self.rawData[sffile]['loaded']: self.loadDescriptorSdifData(sffile, descriptList)

		if startsec in [None]: startsec = 0.0 # use begining of file
		if endsec in [None, 'end']: endsec = self.rawData[sffile]['info']['lengthsec'] # use end of file
		durf = self.s2f(endsec-startsec, sffile, minimum=1)
		startf = int(startsec/self.hopLengthSec)
		#print "\n\n\TTTTTTTTTTT", startf, durf, len(self.rawData[sffile]['load']['power']), self.rawData[sffile]['arraylen']
		#sys.exit()
		for d in self.rawData[sffile]['load']:
			dataDest[d] = self.rawData[sffile]['load'][d][startf:startf+durf]
		if envelopeMask != None:
			for d in dataDest: 
				filetype, energyBool, mixBool, frame, matrix, row, col = agDescriptToSdif[d]
				if energyBool: dataDest[d] *= envelopeMask
		#print "\n\n", startsec, endsec, startf, durf, "\n\n"
		return startsec, endsec, startf, durf # startsec, endsec may have changed !!
	########################################################
	########################################################
	def sdif_testprint(self, sdfifile):
		# first "time" is win_sec/2.0
		sdfh = pysdif.SdifFile(sdfifile)
		print sdfifile
		for f in sdfh:
			print f.time, f.signature
			for m in f:
				print '\t', m.signature, m.get_data(copy=False)
			print
		# close this sdif file handle
		sdfh.close()
		sys.exit()
########################################################
########################################################


def listToCheckSum(items):
	import hashlib
	m = hashlib.md5()
	for item in items:
		m.update(str(item))
	output = m.hexdigest()[:12] # ahh, fuck it
	return output



agDescriptToSdif = {
###############################################################################################
## descriptorname : sdif-Id, isAmp?, isMixable?, sdifFrame, sdifMatrix, matrixCol, matrixRow ##
###############################################################################################
# cluster_cents get automatically added here based on numbClust
#"clusterid":                     ('cluster',     False, True,  '1CLT', '1CSD', 0, 0),
#"clusterlen":                    ('cluster',     False, True,  '1CLT', '1CSD', 0, 1),
#"clustercendist":                ('cluster',     False, True,  '1CLT', '1CSD', 0, 2),
# mfccs get automatically added here based on numbBands
# peakfrqs get automatically added here based on numbPeaks
# peakamps get automatically added here based on numbPeaks
# partialfrqs get automatically added here based on maxpartials
# partialamps get automatically added here based on maxpartials
"autocorr0":                     ('descriptors', False, True,  '1DSC', '1ARR', 0, 0),
"autocorr1":                     ('descriptors', False, True,  '1DSC', '1ARR', 1, 0),
"autocorr2":                     ('descriptors', False, True,  '1DSC', '1ARR', 2, 0),
"autocorr3":                     ('descriptors', False, True,  '1DSC', '1ARR', 3, 0),
"autocorr4":                     ('descriptors', False, True,  '1DSC', '1ARR', 4, 0),
"autocorr5":                     ('descriptors', False, True,  '1DSC', '1ARR', 5, 0),
"autocorr6":                     ('descriptors', False, True,  '1DSC', '1ARR', 6, 0),
"autocorr7":                     ('descriptors', False, True,  '1DSC', '1ARR', 7, 0),
"autocorr8":                     ('descriptors', False, True,  '1DSC', '1ARR', 8, 0),
"autocorr9":                     ('descriptors', False, True,  '1DSC', '1ARR', 9, 0),
"autocorr10":                    ('descriptors', False, True,  '1DSC', '1ARR', 10, 0),
"autocorr11":                    ('descriptors', False, True,  '1DSC', '1ARR', 11, 0),
"bandflux":                      ('descriptors', True,  True,  '1DSC', '1BFL', 0, 0),
"bandroughness":                 ('descriptors', False, True,  '1DSC', '1BRG', 0, 0),
"centroid":                      ('descriptors', False, True,  '1DSC', '1SCN', 0, 0),
"chroma0":                       ('descriptors', False, True,  '1DSC', '1CHR', 0, 0),
"chroma1":                       ('descriptors', False, True,  '1DSC', '1CHR', 1, 0),
"chroma2":                       ('descriptors', False, True,  '1DSC', '1CHR', 2, 0),
"chroma3":                       ('descriptors', False, True,  '1DSC', '1CHR', 3, 0),
"chroma4":                       ('descriptors', False, True,  '1DSC', '1CHR', 4, 0),
"chroma5":                       ('descriptors', False, True,  '1DSC', '1CHR', 5, 0),
"chroma6":                       ('descriptors', False, True,  '1DSC', '1CHR', 6, 0),
"chroma7":                       ('descriptors', False, True,  '1DSC', '1CHR', 7, 0),
"chroma8":                       ('descriptors', False, True,  '1DSC', '1CHR', 8, 0),
"chroma9":                       ('descriptors', False, True,  '1DSC', '1CHR', 9, 0),
"chroma10":                      ('descriptors', False, True,  '1DSC', '1CHR', 10, 0),
"chroma11":                      ('descriptors', False, True,  '1DSC', '1CHR', 11, 0),
"crest0":                        ('descriptors', False, True,  '1DSC', '1SCM', 0, 0),
"crest1":                        ('descriptors', False, True,  '1DSC', '1SCM', 1, 0),
"crest2":                        ('descriptors', False, True,  '1DSC', '1SCM', 2, 0),
"crest3":                        ('descriptors', False, True,  '1DSC', '1SCM', 3, 0),
"decrease":                      ('descriptors', False, True,  '1DSC', '1SDE', 0, 0),
"energyenvelope":                ('descriptors', True,  True,  '1DSC', '1EEV', 0, 0),
"f0":                            ('descriptors', False, False, '1DSC', '1FQ0', 0, 0),
"flatness0":                     ('descriptors', False, True,  '1DSC', '1SFM', 0, 0),
"flatness1":                     ('descriptors', False, True,  '1DSC', '1SFM', 1, 0),
"flatness2":                     ('descriptors', False, True,  '1DSC', '1SFM', 2, 0),
"flatness3":                     ('descriptors', False, True,  '1DSC', '1SFM', 3, 0),
"flux":                          ('descriptors', True,  True,  '1DSC', '1FLS', 0, 0),
"harmoniccentroid":              ('descriptors', False, True,  '1DSC', '1HCN', 0, 0),
"harmonicdecrease":              ('descriptors', False, True,  '1DSC', '1HDE', 0, 0),
"harmonicdeviation":             ('descriptors', False, True,  '1DSC', '1HSD', 0, 0),
"harmonicenergy":                ('descriptors', False, True,  '1DSC', '1HEN', 0, 0),
"harmonickurtosis":              ('descriptors', False, True,  '1DSC', '1HKU', 0, 0),
"harmonicoddevenratio":          ('descriptors', False, True,  '1DSC', '1HOE', 0, 0),
"harmonicrolloff":               ('descriptors', False, True,  '1DSC', '1HRO', 0, 0),
"harmonicskewness":              ('descriptors', False, True,  '1DSC', '1HSK', 0, 0),
"harmonicslope":                 ('descriptors', False, True,  '1DSC', '1HSL', 0, 0),
"harmonicspread":                ('descriptors', False, True,  '1DSC', '1HSP', 0, 0),
"harmonictristimulus0":          ('descriptors', False, True,  '1DSC', '1HTR', 0, 0),
"harmonictristimulus1":          ('descriptors', False, True,  '1DSC', '1HTR', 1, 0),
"harmonictristimulus2":          ('descriptors', False, True,  '1DSC', '1HTR', 2, 0),
"harmonicvariation":             ('descriptors', False, True,  '1DSC', '1HVA', 0, 0),
"inharmonicity":                 ('descriptors', False, True,  '1DSC', '1INH', 0, 0),
"kurtosis":                      ('descriptors', False, True,  '1DSC', '1SKU', 0, 0),
"loudness":                      ('descriptors', True,  True,  '1DSC', '1LDN', 0, 0),
"noisecentroid":                 ('descriptors', False, True,  '1DSC', '1NCN', 0, 0),
"noisedecrease":                 ('descriptors', False, True,  '1DSC', '1NDE', 0, 0),
"noiseenergy":                   ('descriptors', False, True,  '1DSC', '1NEN', 0, 0),
"noisekurtosis":                 ('descriptors', False, True,  '1DSC', '1NKU', 0, 0),
"noiserolloff":                  ('descriptors', False, True,  '1DSC', '1NRO', 0, 0),
"noiseskewness":                 ('descriptors', False, True,  '1DSC', '1NSK', 0, 0),
"noiseslope":                    ('descriptors', False, True,  '1DSC', '1NSL', 0, 0),
"noisespread":                   ('descriptors', False, True,  '1DSC', '1NSP', 0, 0),
"noisevariation":                ('descriptors', False, True,  '1DSC', '1NVA', 0, 0),
"noisiness":                     ('descriptors', False, True,  '1DSC', '1NSN', 0, 0),
"perceptualcentroid":            ('descriptors', False, True,  '1DSC', '1PCN', 0, 0),
"perceptualdecrease":            ('descriptors', False, True,  '1DSC', '1PDE', 0, 0),
"perceptualdeviation":           ('descriptors', False, True,  '1DSC', '1PSD', 0, 0),
"perceptualkurtosis":            ('descriptors', False, True,  '1DSC', '1PKU', 0, 0),
"perceptualoddtoevenratio":      ('descriptors', False, True,  '1DSC', '1POE', 0, 0),
"perceptualrolloff":             ('descriptors', False, True,  '1DSC', '1PRO', 0, 0),
"perceptualskewness":            ('descriptors', False, True,  '1DSC', '1PSK', 0, 0),
"perceptualslope":               ('descriptors', False, True,  '1DSC', '1PSL', 0, 0),
"perceptualspread":              ('descriptors', False, True,  '1DSC', '1PSP', 0, 0),
"perceptualtristimulus0":        ('descriptors', False, True,  '1DSC', '1PTR', 0, 0),
"perceptualtristimulus1":        ('descriptors', False, True,  '1DSC', '1PTR', 1, 0),
"perceptualtristimulus2":        ('descriptors', False, True,  '1DSC', '1PTR', 2, 0),
"perceptualvariation":           ('descriptors', False, True,  '1DSC', '1PVA', 0, 0),
"power":                         ('descriptors', True,  True,  '1DSC', '1NRG', 0, 0),
#"relativespecificloudness":      ('descriptors', True,  True,  '1DSC', '1RSL', 0, 0),
"rolloff":                       ('descriptors', False, True,  '1DSC', '1SRO', 0, 0),
"roughness":                     ('descriptors', False, True,  '1DSC', '1RGH', 0, 0),
"sharpness":                     ('descriptors', False, True,  '1DSC', '1SHA', 0, 0),
"skewness":                      ('descriptors', False, True,  '1DSC', '1SSK', 0, 0),
"slope":                         ('descriptors', False, True,  '1DSC', '1SSL', 0, 0),
"spread":                        ('descriptors', False, True,  '1DSC', '1SSP', 0, 0),
#"temporalCentroid-seg":          ('descriptors', False, True,  '1TCN', '1EEV', 0, 0),
#"temporalDecrease-seg":          ('descriptors', False, True,  '1TDE', '1EEV', 0, 0),
#"temporalIncrease-seg":          ('descriptors', False, True,  '1TIN', '1EEV', 0, 0),
"variation":                     ('descriptors', False, True,  '1DSC', '1SVA', 0, 0),
"zeroCross":                     ('descriptors', False, False, '1DSC', '1ZCR', 0, 0),
#'logAttackTime-seg': ('descriptors', '1LAT', 'IDSC', 0, 0),
#'temporalIncrease-seg': ('descriptors', '1TIN', '1EEV', 0, 0),
#'temporalDecrease-seg': ('descriptors', '1TDE', '1EEV', 0, 0),
#'temporalCentroid-seg': ('descriptors', '1TCN', '1EEV', 0, 0),
#'effDur-seg': ('1EFD', '1EEV', 0, 0),
}



def clusterAnalysis(clusteringMatrix, numb_clusters):# cluster analysis		
	import numpy as np
	import hcluster
	Y = hcluster.pdist(clusteringMatrix)
	Z = hcluster.linkage(Y, method='average')
	clusterAssignment = hcluster.fcluster(Z, numb_clusters, criterion='maxclust') 
	clusterAssignment -= 1
	# get cluster centroids
	# Sum the vectors in each cluster
	lens = {}      # will contain the lengths for each cluster
	centroids = {} # will contain the centroids of each cluster
	for idx, clno in enumerate(clusterAssignment):
		centroids.setdefault(clno, np.zeros(clusteringMatrix.shape[1])) 
		centroids[clno] += clusteringMatrix[idx,:]
		lens.setdefault(clno,0)
		lens[clno] += 1
	# Divide by number of observations in each cluster to get the centroid
	for clno in centroids:
		centroids[clno] /= float(lens[clno])
	return clusterAssignment, centroids, lens




#############################
## PACKAGES OF DESCRIPTORS ##
#############################



def descriptListPackageExpansion(initialListOfDescriptorObjs, numbMfccs, numbSupervpPeaks):
	from UserClasses import SingleDescriptor as d
	newListOfDescriptorObjs = []
	
	for dobj in initialListOfDescriptorObjs:
		metricsToWrite = []
		if dobj.name.find('mfccs') != -1:
			mfccWeightMask = np.power(np.linspace(1., 0.05, num=numbMfccs-1), 0.5)
			for i in range(numbMfccs-1): metricsToWrite.append(('mfcc'+str(i+1)+dobj.name[5:], dobj.weight*(mfccWeightMask[i]/sum(mfccWeightMask)) ))
		elif dobj.name.find('chromas') != -1:
			for i in range(12): metricsToWrite.append( ( 'chroma'+str(i)+dobj.name[9:], dobj.weight/12. ) )
		elif dobj.name.find('autocorrs') != -1:
			for i in range(12): metricsToWrite.append( ( 'autocorr'+str(i)+dobj.name[9:], dobj.weight/12. ) )
		elif dobj.name.find('cluster_cents') != -1:
			numb = len(ops.CLUSTERANAL_DESCRIPTOR_DIM)
			for i in range(numb):
				metricsToWrite.append( ( 'cluster_cent'+str(i)+dobj.name[13:], dobj.weight/float(numb) ) )
			#print metricsToWrite
		elif dobj.name.find('peakfrqs') != -1:
			for i in range(ops.SUPERVP_NUMB_PEAKS):
				metricsToWrite.append( ('peakfrq'+str(i)+dobj.name[10:], dobj.weight*((numbSupervpPeaks)/float(numbSupervpPeaks)) ) )
				metricsToWrite.append( ('peakamp'+str(i)+dobj.name[10:], 0) )
		elif dobj.name.find('crests') != -1:
			for i in range(4):
				metricsToWrite.append( [ 'crest'+str(i)+dobj.name[6:], dobj.weight/4. ] )
		elif dobj.name.find('flatnesses') != -1:
			for i in range(4):
				metricsToWrite.append( [ 'flatness'+str(i)+dobj.name[10:], dobj.weight/4. ] )
		elif dobj.name.find('harmonictristimuluses') != -1:
			for i in range(3):
				metricsToWrite.append( [ 'harmonictristimulus'+str(i)+dobj.name[21:], dobj.weight/3. ] )
		elif dobj.name.find('perceptualtristimuluses') != -1:
			for i in range(3):
				metricsToWrite.append( [ 'perceptualtristimulus'+str(i)+dobj.name[23:], dobj.weight/3. ] )
		
		# add original if not a package, add package elements otherwise
		if len(metricsToWrite) == 0:
			newListOfDescriptorObjs.append(dobj)
		else:
			for name, weight in metricsToWrite:
				newdobj = d(name, weight=weight, norm=dobj.norm, normmethod=dobj.normmethod, distance=dobj.distance, limit=dobj.limit, energyWeight=dobj.energyWeight, origin=dobj.origin, neededBy=dobj.neededBy, packagename=dobj.name)
				#print "ADDING", newdobj, newdobj.weight
				newListOfDescriptorObjs.append(newdobj)
	return newListOfDescriptorObjs
	