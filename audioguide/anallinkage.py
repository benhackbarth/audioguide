############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os, subprocess, time, json
sys.path.insert(0, os.path.dirname(__file__)) # look here first
import numpy as np
import audioguide.util as util


def findbin(userstring, filehead, searchdirectories=['/Applications', os.path.join(os.getenv("HOME"), 'Applications')]):
	if userstring != None and os.path.isabs(userstring) and os.path.exists(userstring): return userstring
	elif userstring != None and os.path.exists(userstring): return os.path.abspath(userstring)
	for possibledir in searchdirectories:
		attempt = os.path.join(possibledir, filehead)
		if os.path.exists(attempt): return os.path.abspath(attempt)
	# didn't find anything
	return None	




class AnalInterface:
	# when loading a directory, skip files without these extensions; not case sensative
	validSfExtensions = ['.aiff', '.aif', '.wav', '.au'] 
	tgtOnsetDescriptors = {'power-odf-7': 1}
	global descriptToFiles

	def __init__(self, pm2_bin=None, supervp_bin=None, userWinLengthSec=0.12, userHopLengthSec=0.02, userEnergyHopLengthSec=0.005, resampleRate=12500, windowType='blackman', F0MaxAnalysisFreq=3000, F0MinFrequency=200, F0MaxFrequency=1000, F0AmpThreshold=30, numbMfccs=13, forceAnal=False, p=None, searchPaths=[], dataDirectoryLocation=None):
		global descriptToFiles

		# establish data directory
		if dataDirectoryLocation == None:
			self.dataDirectory = os.path.dirname(__file__)
		else:
			self.dataDirectory = os.path.abspath(dataDirectoryLocation)
			if not os.path.exists(self.dataDirectory): os.makedirs(self.dataDirectory)

		self.rawData = {} # file, descriptdict
		self.p = p
		self.ircamdescriptor_bin = os.path.join( os.path.dirname(__file__), 'ircamdescriptor-2.8.6', 'ircamdescriptor-2.8.6' )
		assert os.path.exists(self.ircamdescriptor_bin)
		# check for other bin files #
		self.pm2_bin = findbin(pm2_bin, 'AudioSculpt3.0b7/Kernels/pm2')
		self.supervp_bin = findbin(supervp_bin, 'AudioSculpt3.0b7/Kernels/supervp')
		# anal
		self.resampleRate = resampleRate
		#############################################################################
		## ensure that window and hop sizes are powers of two of the resample rate ##
		#############################################################################
		powersOfTwo = np.array([2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288])
		closestWinSize = powersOfTwo[np.argmin(np.abs(powersOfTwo-(userWinLengthSec*float(self.resampleRate))))]
		closestHopSize = powersOfTwo[np.argmin(np.abs(powersOfTwo-(userHopLengthSec*float(self.resampleRate))))]
		#self.winLengthSec = closestWinSize/float(self.resampleRate) # adjusted value to esure its a power of two in the resample rate!
		#self.hopLengthSec = closestHopSize/float(self.resampleRate) # adjusted value to esure its a power of two in the resample rate!
		self.winLengthSec = userWinLengthSec
		self.hopLengthSec = userHopLengthSec

		self.userEnergyWinLengthSec = userEnergyHopLengthSec*2
		self.userEnergyHopLengthSec = userEnergyHopLengthSec
		self.IOBufferSize = min(4096, closestWinSize*4, self.userEnergyWinLengthSec*float(self.resampleRate)*4)
		self.windowType = windowType
		self.F0MaxAnalysisFreq = F0MaxAnalysisFreq
		self.F0MinFrequency = F0MinFrequency
		self.F0MaxFrequency = F0MaxFrequency
		self.F0AmpThreshold = F0AmpThreshold
		# set up mfccs
		self.numbMfccs = numbMfccs
		for i in range(self.numbMfccs):
			descriptToFiles.append(("mfcc%i"%i,                  'ircamd', False, True,  'MFCC', self.numbMfccs, i))
		# other stuff
		self.forceAnal = forceAnal
		self.searchPaths = searchPaths

		### setup ircam binary config text file	
		self.analdir = os.path.join(self.dataDirectory, 'data')
		self.ircamd_infofile = os.path.join(self.analdir, 'ircamd-info.json')
		self.ircamd_info = {}

		if not os.path.exists(self.analdir): os.makedirs(self.analdir)
		### setup anal registry
		self.dataRegistryPath = os.path.join(self.analdir, 'data_registry.json')
		if os.path.exists(self.dataRegistryPath):
			fh = open(self.dataRegistryPath)
			self.dataRegistry = json.load(fh)
			fh.close()
		else:
			self.dataRegistry = {}

		self.internalDescriptorNames = ['power', 'peakTime-seg', 'power-seg', 'power-mean-seg', 'effDurFrames-seg', 'effDur-seg','f0-seg', 'MIDIPitch-seg']
		self.config_loc = os.path.join(self.analdir, 'ircamdescriptor.config.txt')
		self.config_text = '''; DO NOT EDIT - AUTOMATICALLY GENERATED BY anallinkage.py
[Parameters]
ResampleTo = %i
NormalizeSignal = 0
SubtractMean = 1
IOBufferSize = %i
SaveShortTermTMFeatures = 1
WindowType = %s
OutputFormat = raw

F0MaxAnalysisFreq = %i
F0MinFrequency = %i
F0MaxFrequency = %i
F0AmpThreshold = %i

MFCCs = %i

[StandardDescriptors]
WindowSize = %f
HopSize = %f
TextureWindowsFrames = -1
TextureWindowsHopFrames = -1		
Harmonics = 20
DeviationStopBand = 10
RolloffThreshold = 0.95
DecreaseThreshold = 0.4
NoiseThreshold = 0.15

;~~~~~~~~~~~~~~~~~~~descriptors~~~~~~~~~~~~~~~~~~~~~
SignalZeroCrossingRate  = ShortTime
;AutoCorrelation  = ShortTime
TotalEnergy  = ShortTime
SpectralCentroid  = ShortTime
SpectralSpread  = ShortTime
SpectralSkewness  = ShortTime
SpectralKurtosis  = ShortTime
SpectralSlope  = ShortTime
SpectralDecrease  = ShortTime
SpectralRolloff  = ShortTime
SpectralVariation  = ShortTime
Loudness  = ShortTime
Spread  = ShortTime
Sharpness  = ShortTime
PerceptualSpectralCentroid  = ShortTime
PerceptualSpectralSpread  = ShortTime
PerceptualSpectralSkewness  = ShortTime
PerceptualSpectralKurtosis  = ShortTime
PerceptualSpectralSlope  = ShortTime
PerceptualSpectralDecrease  = ShortTime
PerceptualSpectralRolloff  = ShortTime
PerceptualSpectralVariation  = ShortTime
PerceptualSpectralDeviation  = ShortTime
PerceptualOddToEvenRatio  = ShortTime
PerceptualTristimulus  = ShortTime
MFCC  = ShortTime
SpectralFlatness  = ShortTime
SpectralCrest  = ShortTime
FundamentalFrequency  = ShortTime
NoiseEnergy  = ShortTime
Noisiness  = ShortTime
Inharmonicity  = ShortTime
HarmonicEnergy  = ShortTime
HarmonicSpectralCentroid  = ShortTime
HarmonicSpectralSpread  = ShortTime
HarmonicSpectralSkewness  = ShortTime
HarmonicSpectralKurtosis  = ShortTime
HarmonicSpectralSlope  = ShortTime
HarmonicSpectralDecrease  = ShortTime
HarmonicSpectralRolloff  = ShortTime
HarmonicSpectralVariation  = ShortTime
HarmonicSpectralDeviation  = ShortTime
HarmonicOddToEvenRatio  = ShortTime
HarmonicTristimulus  = ShortTime
Chroma  = ShortTime


[EnergyDescriptors]
WindowSize = %f
HopSize = %f
TextureWindowsFrames = -1
TextureWindowsHopFrames = -1
;~~~~~~~~~~~~~~~~energy descriptors~~~~~~~~~~~~~~~~
EnergyEnvelope  = 1
'''%(self.resampleRate, self.IOBufferSize, self.windowType, self.F0MaxAnalysisFreq, self.F0MinFrequency, self.F0MaxFrequency, self.F0AmpThreshold, self.numbMfccs, self.winLengthSec, self.hopLengthSec, self.userEnergyWinLengthSec, self.userEnergyHopLengthSec)
		# make a list of all possible descriptor objects
		self.allDescriptors = []
		from userclasses import SingleDescriptor as d
		for desc in descriptToFiles:
			dobj = d(desc[0])
			self.allDescriptors.append( dobj )
			if not dobj.seg: self.allDescriptors.append( d(desc[0]+'-seg') )
		
		for desc in self.internalDescriptorNames:
			self.allDescriptors.append( d(desc) )
		# print all descriptors
		#print (', '.join(["d('%s')"%d.name for d in self.allDescriptors if d.seg]))
		# write log
		if self.p != None: 
			self.p.log("ANALYSIS CONFIG: using analysis window of %.3f (%i samples)"%(self.winLengthSec, closestWinSize))
			self.p.log("ANALYSIS CONFIG: using analysis overlap of %.3f (%i samples)"%(self.hopLengthSec, closestHopSize))
	#############################
	def addDescriptorIfNeeded(self, dobjToCheck, ops, addParents=False):
		from userclasses import SingleDescriptor as d
		if dobjToCheck.name not in [dn.name for dn in self.requiredDescriptors]:
			self.requiredDescriptors.append(dobjToCheck)
		if addParents:
			for pname in dobjToCheck.parents:
				self.addDescriptorIfNeeded(d(pname, origin=dobjToCheck.origin+'_PARENT'), ops)
	#############################
	def expandDescriptorPackages(self, ops):
		for spass in ops.SEARCH:
			spass.descriptor_list = descriptListPackageExpansion(spass.descriptor_list, self.numbMfccs)
			if spass.parse:
				spass.parselists[0] = descriptListPackageExpansion(spass.parselists[0], self.numbMfccs)
				spass.parselists[1] = descriptListPackageExpansion(spass.parselists[1], self.numbMfccs)
		# add EXPERIMENTAL spass entries 
		from audioguide.userclasses import SearchPassOptionsEntry as spassObj
		for k, v in ops.EXPERIMENTAL.items():
			if isinstance(v, spassObj):
				v.descriptor_list = descriptListPackageExpansion(v.descriptor_list, self.numbMfccs)

	#############################
	def getDescriptorLists(self, ops):
		self.expandDescriptorPackages(ops)
		from userclasses import SingleDescriptor as d
		from audioguide.userclasses import SearchPassOptionsEntry as spassObj
		self.requiredDescriptors = []
		# add SEARCH descriptors
		for spass in ops.SEARCH:
			for dobj in spass.descriptor_list:
				#dobj.origin = 'SEARCH'
				self.addDescriptorIfNeeded(dobj, ops, addParents=True)
		# add target onset descriptors
		for dname, weight in self.tgtOnsetDescriptors.items():
			self.addDescriptorIfNeeded(d(dname, weight=weight, origin='TARGET_ONSET'), ops)
		# add limiting descriptors
		if 'limit' in ops.CORPUS_GLOBAL_ATTRIBUTES:
			for stringy in ops.CORPUS_GLOBAL_ATTRIBUTES['limit']:
				print(stringy.split()[0], 'GLOBAL_LIMIT')
				self.addDescriptorIfNeeded(d(stringy.split()[0], origin='GLOBAL_LIMIT'), ops, addParents=True)
		if hasattr(ops, 'CORPUS'):
			for csfObj in ops.CORPUS:
				for stringy in csfObj.limit:
					self.addDescriptorIfNeeded(d(stringy.split()[0], origin='LOCAL_LIMIT'), ops, addParents=True)

		# add EXPERIMENTAL spass entries 
		for k, v in ops.EXPERIMENTAL.items():
			if isinstance(v, spassObj):
				for dobj in v.descriptor_list:
					dobj.origin = 'EXPERIMENTAL'
					self.addDescriptorIfNeeded(dobj, ops, addParents=True)

		# add CLUSTER descriptors
		if 'descriptors' in ops.CLUSTER_MAPPING:
			for s in ops.CLUSTER_MAPPING['descriptors']:
				self.addDescriptorIfNeeded(d(s+'-seg', origin='CLUSTER_MAPPING'), ops, addParents=True)
		# add segmentation data descriptor
		if ops.SEGMENTATION_FILE_INFO != 'logic':
			self.addDescriptorIfNeeded(d(ops.SEGMENTATION_FILE_INFO, weight=0, origin='SEGMENTATION_DATA'), ops, addParents=True)
		# add ordering by descriptor
		if None not in [ops.ORDER_CORPUS_BY_DESCRIPTOR]:
			self.addDescriptorIfNeeded(d(ops.ORDER_CORPUS_BY_DESCRIPTOR, weight=0, origin='ORDER_CORPUS_BY_DESCRIPTOR'), ops, addParents=True)
		for dname, weight in self.tgtOnsetDescriptors.items():
			self.addDescriptorIfNeeded(d(dname, weight=weight, origin='TARGET_ONSET'), ops)
		# add internal mectrics if not already used
		for dname in self.internalDescriptorNames:
			self.addDescriptorIfNeeded(d(dname, origin='INTERNAL'), ops, addParents=True)
		#
		#
		# make normalisation list!
		self.normalizeDescriptors = []
		for dobj in self.requiredDescriptors:
			if dobj.origin in ['SEARCH', 'EXPERIMENTAL']: self.normalizeDescriptors.append(dobj)
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
				print(arg, type(arg))
				encoded += unicode(arg)
			self.p.write('ANALLINKAGE: %s\n\n'%encoded)
		else:
			self.p.write('ANALLINKAGE: %s\n\n'%command)
	########################################################
	########################################################
	def f2s(self, frame):
		'''descriptor frame to time in seconds'''
		return frame*self.hopLengthSec
	########################################################
	########################################################
	def s2f(self, sec, sffile, minimum=1):
		'''descriptor frame to time in seconds'''
		return int(sec/self.hopLengthSec)
	########################################################
	########################################################
	def __createDescriptorsFile__(self, sffile, analdir, npypath, jsonpath, ircam_bin, ircamd_configfile, debug=False):
		global descriptToFiles
		STAGING_DIRECTORY = os.path.join(analdir, 'tmp')
		if not os.path.exists(STAGING_DIRECTORY): os.makedirs(STAGING_DIRECTORY)
		command = [ircam_bin, sffile, ircamd_configfile]
		if self.p != None: self.p.log("\tRUNNING COMMAND: '"+' '.join(command)+"'")
		stdoutReturnDict={('sr', 0): ('sr', 2, int), ('samples', 0): ('lengthsamples', 2, int), ('channel(s):', 0): ('channels', 1, int)}
		try:
			p = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=STAGING_DIRECTORY)
		except OSError:
			print('commandline', 'Command line call failed: \n\n"%s"'%' '.join(command))
		out, err = p.communicate()
		out = out.decode('utf-8')
		# test for bad exit status
		if err not in [0, b'']:
			util.error('commandline', 'AudioGuide command line call failed: \n"%s"%s%s'%(' '.join(command), '\n--------\n\n', out))	
		infodict = {'ircamd_columns': {'power': 0}}
		# fill output dict if requested
		for o in out.split('\n'):
			#print o
			o = o.split()
			if len(o) > 1:
				for (str, loc), (key, valloc, valtype) in stdoutReturnDict.items():
					if o[loc] == str:
						infodict[key] = o[valloc]
						if valtype == int: infodict[key] = int(infodict[key])
						if valtype == float: infodict[key] = float(infodict[key])
		
		# get number of frames of shorttime centroid
		f = open(os.path.join(STAGING_DIRECTORY, 'SpectralCentroid_ShortTermFeature_space2.info.txt'))
		framelength = int(f.readlines()[2].split()[2])
		f.close()
		infodict['ircamd'] = {'framelength': framelength, 'filehead': os.path.split(npypath)[1]}
		
		if debug:
			print(sffile+'\n')
			print(infodict)
			print("Array=", (framelength, len(descriptToFiles)+1))

		# set up descriptor matrix
		ircamd_array = np.empty((framelength, len(descriptToFiles)+1)) # plus one for power, added separately due to separate framerate
		# get number of frames of shorttime energy envelope
		f = open(os.path.join(STAGING_DIRECTORY, 'EnergyEnvelope_ShortTermFeature_space1.info.txt'))
		energyframelength = int(f.readlines()[2].split()[2])
		f.close()
		myarray = np.fromfile(os.path.join(STAGING_DIRECTORY, 'EnergyEnvelope_ShortTermFeature_space1.raw'), dtype=np.float, count=-1, sep='')
		newarray = util.interpArray(myarray, framelength)
		newarray = np.reshape(newarray, (framelength, 1))
		ircamd_array[:,0] = newarray[:,0] # power is first column
		infodict['lengthsec'] = infodict['lengthsamples']/float(infodict['sr'])
		
		for idx, (agId, source, isAmp, isMixable, rawFilename, matrixSize, matrixLocation) in enumerate(descriptToFiles):
			filename = os.path.join(STAGING_DIRECTORY, rawFilename+'_ShortTermFeature_space2.raw')
			myarray = np.fromfile(filename, dtype=np.float, count=-1, sep='')
			#print source, rawFilename, matrixSize, len(myarray), framelength, matrixSize, framelength*matrixSize
			myarray = np.reshape(myarray, (framelength, matrixSize))
			ircamd_array[:,idx+1] = myarray[:,matrixLocation]
			infodict['ircamd_columns'][agId] = idx+1
		# write files
		f = open(jsonpath, "w")
		json.dump(infodict, f)
		f.close()
		np.save(npypath, ircamd_array)
		return infodict, ircamd_array
	########################################################
	########################################################
	def validateAnalResource(self, sffile):
		sffile = os.path.abspath(sffile)
		if not sffile in self.rawData:
			self.initAnalResource(sffile)
		return self.rawData[sffile]['info']['lengthsec'], self.rawData[sffile]['info']['channels']
	########################################################
	########################################################
	def getSegmentFrameLength(self, segmentDurationSec, sffile):
		length = self.s2f(segmentDurationSec, sffile, minimum=1)
		if length > self.rawData[sffile]['info']['ircamd']['framelength']:
			length = self.rawData[sffile]['info']['ircamd']['framelength']
		return length
	########################################################
	########################################################
	def getSegmentStartInFrames(self, sffile, startsec, endsec, lengthInFrames):
		start = self.s2f(startsec, sffile, minimum=1)
		return start
	########################################################
	########################################################
	def removeAnalResource(self, sffile):
		sffile = os.path.abspath(sffile)
		if sffile in self.rawData:
			del self.rawData[sffile]
	########################################################
	########################################################
	def initAnalResource(self, sffile):
		'''if analysis files don't exist, this function automatically makes
		an ircamdescriptor analysis because it is required for all
		sound files used.'''
		self.rawData[sffile] = {'info': {}}
		sfroot, sfhead = os.path.split(sffile)
		sfheadroot, sfheadext = os.path.splitext(sfhead)
		self.rawData[sffile]['fileroot'] = os.path.join(self.analdir, sfheadroot)
		
		self.rawData[sffile]['checksum'] = util.listToCheckSum([sffile, self.resampleRate, self.windowType, self.winLengthSec, self.hopLengthSec, self.F0MaxAnalysisFreq, self.F0MinFrequency, self.F0MaxFrequency, self.F0AmpThreshold, self.numbMfccs, 'ircamd'])[:12]
		filehead = '%s-%s'%(sfheadroot, self.rawData[sffile]['checksum'])
		descriptorfile = os.path.join(self.analdir, '%s-ircamd.npy'%(filehead))
		infofile = os.path.join(self.analdir, '%s.json'%(filehead))
		ircamd_dict = {}
		
		if not os.path.exists(descriptorfile) or not os.path.exists(infofile) or util.checkIfFileIsNewer(sffile, descriptorfile) or util.checkIfFileIsNewer(sffile, infofile) or self.forceAnal:
			# do analysis
			if self.p != None:
				self.p.log("ANAL DATA: creating NPY FILE '%s'"%descriptorfile)
			# write tmp config files
			fh = open(self.config_loc, 'w')
			fh.write(self.config_text)
			fh.close()
			# create files
			self.rawData[sffile]['info'], self.rawData[sffile]['ircamd'] = self.__createDescriptorsFile__(sffile, self.analdir, descriptorfile, infofile, self.ircamdescriptor_bin, self.config_loc)
			if not os.path.exists(descriptorfile):
				print(util.ladytext("Oh noos! The ircamdescriptor binary has fialed to create the requested output files.  See the binary's output below for details."))
		else:
			# load files
			f = open(infofile, "r")
			self.rawData[sffile]['info'].update(json.load(f))
			f.close()
			self.rawData[sffile]['ircamd'] = np.load(descriptorfile)
		self.rawData[sffile]['arraylen'] = self.rawData[sffile]['ircamd'].shape[0]
		# touch file in data registry
		self.dataRegistry[filehead] = time.time(), os.stat(sffile).st_size
	########################################################
	########################################################
	def getDescriptorColumn(self, sffile, dname):
		return self.rawData[sffile]['ircamd'][:,self.rawData[sffile]['info']['ircamd_columns'][dname]]
	########################################################
	########################################################
	def getDescriptorForsfsegment(self, sffile, startf, lengthinframes, descriptor, envelopeMask):
		global descriptIsAmp
		endf = startf+lengthinframes
		#print ("getDescriptorForsfsegment", startf, endf)
		data = self.getDescriptorColumn(sffile, descriptor.name)[startf:endf]
		# use envelope mask if requested and if this descriptor deals with power
		if type(envelopeMask) != type(None) and descriptor.name in descriptIsAmp:
			data *= envelopeMask
		return data
	########################################################
	########################################################
	def done(self, dataGbLimit=1, dataDayLimit=7):
		byteLimit = dataGbLimit*125000000
		secondLimit = dataDayLimit*24*60*60
		
		timeordered = []
		for filename, (timestamp, bytes) in self.dataRegistry.items():
			timeordered.append( (timestamp, bytes, filename) )
		timeordered.sort(reverse=True)
		totalBytes = 0
		currenttimestamp = time.time()
		listToRemove = []
		for timestamp, bytes, filehead in timeordered:
			timediff = currenttimestamp-timestamp
			# if total bytes is over 1 gb and file hasn't been used for a week...
			if timediff > secondLimit and totalBytes > byteLimit:
				listToRemove.append(filehead)
				del self.dataRegistry[filehead]
				print("RM "+os.path.join(self.analdir, filehead+'.npy'))
			totalBytes += bytes
		dataRegistryPathTmp = '/tmp/tmp.json'
		fh = open(dataRegistryPathTmp, 'w')
		json.dump(self.dataRegistry, fh)
		fh.close()
		# move into place
		os.rename(dataRegistryPathTmp, self.dataRegistryPath)
########################################################
########################################################








#############################
## PACKAGES OF DESCRIPTORS ##
#############################
def descriptListPackageExpansion(initialListOfDescriptorObjs, numbMfccs):
	from userclasses import SingleDescriptor as d
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



descriptToFiles = [
########################################################################################
## descriptorname,  analId, isAmp, isMixable, rawFilename, matrixSize, matrixLocation ##
########################################################################################
#("autocorr0",              'ircamd', False, True,  'AutoCorrelation', 12, 0),
#("autocorr1",              'ircamd', False, True,  'AutoCorrelation', 12, 1),
#("autocorr2",              'ircamd', False, True,  'AutoCorrelation', 12, 2),
#("autocorr3",              'ircamd', False, True,  'AutoCorrelation', 12, 3),
#("autocorr4",              'ircamd', False, True,  'AutoCorrelation', 12, 4),
#("autocorr5",              'ircamd', False, True,  'AutoCorrelation', 12, 5),
#("autocorr6",              'ircamd', False, True,  'AutoCorrelation', 12, 6),
#("autocorr7",              'ircamd', False, True,  'AutoCorrelation', 12, 7),
#("autocorr8",              'ircamd', False, True,  'AutoCorrelation', 12, 8),
#("autocorr9",              'ircamd', False, True,  'AutoCorrelation', 12, 9),
#("autocorr10",              'ircamd', False, True,  'AutoCorrelation', 12, 10),
#("autocorr11",              'ircamd', False, True,  'AutoCorrelation', 12, 11),
("chroma0",                'ircamd', False, True,  'Chroma', 12, 0),
("chroma1",                'ircamd', False, True,  'Chroma', 12, 1),
("chroma2",                'ircamd', False, True,  'Chroma', 12, 2),
("chroma3",                'ircamd', False, True,  'Chroma', 12, 3),
("chroma4",                'ircamd', False, True,  'Chroma', 12, 4),
("chroma5",                'ircamd', False, True,  'Chroma', 12, 5),
("chroma6",                'ircamd', False, True,  'Chroma', 12, 6),
("chroma7",                'ircamd', False, True,  'Chroma', 12, 7),
("chroma8",                'ircamd', False, True,  'Chroma', 12, 8),
("chroma9",                'ircamd', False, True,  'Chroma', 12, 9),
("chroma10",                'ircamd', False, True,  'Chroma', 12, 10),
("chroma11",                'ircamd', False, True,  'Chroma', 12, 11),
("f0",                     'ircamd', False, True,  'FundamentalFrequency', 1, 0),
("harmonicenergy",         'ircamd', False, True,  'HarmonicEnergy', 1, 0),
("harmonicoddevenratio",   'ircamd', False, True,  'HarmonicOddToEvenRatio', 3, 0),
("harmoniccentroid",       'ircamd', False, True,  'HarmonicSpectralCentroid', 6, 0),
("harmonicdecrease",       'ircamd', False, True,  'HarmonicSpectralDecrease', 1, 0),
("harmonicdeviation",      'ircamd', False, True,  'HarmonicSpectralDeviation', 3, 0),
("harmonickurtosis",       'ircamd', False, True,  'HarmonicSpectralKurtosis', 6, 0),
("harmonicrolloff",        'ircamd', False, True,  'HarmonicSpectralRolloff', 1, 0),
("harmonicskewness",       'ircamd', False, True,  'HarmonicSpectralSkewness', 6, 0),
("harmonicslope",          'ircamd', False, True,  'HarmonicSpectralSlope', 6, 0),
("harmonicspread",         'ircamd', False, True,  'HarmonicSpectralSpread', 6, 0),
("harmonicvariation",      'ircamd', False, True,  'HarmonicSpectralVariation', 3, 0),
#("harmonictristimulus0",   'ircamd', False, True,  'HarmonicTristimulus', 3, 0),
#("harmonictristimulus1",   'ircamd', False, True,  'HarmonicTristimulus', 3, 1),
#("harmonictristimulus2",   'ircamd', False, True,  'HarmonicTristimulus', 3, 2),
("inharmonicity",          'ircamd', False, True,  'Inharmonicity', 1, 0),
("loudness",               'ircamd', False, True,  'Loudness', 1, 0),
#("mfcc0",                  'ircamd', False, True,  'MFCC', 13, 0), # MFCCS GET ADDED IN BY ANALLINKAGE INIT
#("mfcc1",                  'ircamd', False, True,  'MFCC', 13, 1), # MFCCS GET ADDED IN BY ANALLINKAGE INIT
#("mfcc2",                  'ircamd', False, True,  'MFCC', 13, 2), # MFCCS GET ADDED IN BY ANALLINKAGE INIT
#("mfcc3",                  'ircamd', False, True,  'MFCC', 13, 3), # MFCCS GET ADDED IN BY ANALLINKAGE INIT
#("mfcc4",                  'ircamd', False, True,  'MFCC', 13, 4), # MFCCS GET ADDED IN BY ANALLINKAGE INIT
#("mfcc5",                  'ircamd', False, True,  'MFCC', 13, 5),
#("mfcc6",                  'ircamd', False, True,  'MFCC', 13, 6),
#("mfcc7",                  'ircamd', False, True,  'MFCC', 13, 7),
#("mfcc8",                  'ircamd', False, True,  'MFCC', 13, 8),
#("mfcc9",                  'ircamd', False, True,  'MFCC', 13, 9),
#("mfcc10",                 'ircamd', False, True,  'MFCC', 13, 10),
#("mfcc11",                 'ircamd', False, True,  'MFCC', 13, 11),
#("mfcc12",                 'ircamd', False, True,  'MFCC', 13, 12),
("noiseenergy",            'ircamd', False, True,  'NoiseEnergy', 1, 0),
("noisiness",              'ircamd', False, True,  'Noisiness', 1, 0),
("perceptualoddtoevenratio",'ircamd',False, True,  'PerceptualOddToEvenRatio', 3, 0),
("perceptualcentroid",     'ircamd', False, True,  'PerceptualSpectralCentroid', 6, 0),
("perceptualdecrease",     'ircamd', False, True,  'PerceptualSpectralDecrease', 1, 0),
("perceptualdeviation",    'ircamd', False, True,  'PerceptualSpectralDeviation', 3, 0),
("perceptualkurtosis",     'ircamd', False, True,  'PerceptualSpectralKurtosis', 6, 0),
("perceptualrolloff",      'ircamd', False, True,  'PerceptualSpectralRolloff', 1, 0),
("perceptualskewness",     'ircamd', False, True,  'PerceptualSpectralSkewness', 6, 0),
("perceptualslope",        'ircamd', False, True,  'PerceptualSpectralSlope', 6, 0),
("perceptualspread",       'ircamd', False, True,  'PerceptualSpectralSpread', 6, 0),
("perceptualvariation",    'ircamd', False, True,  'PerceptualSpectralVariation', 3, 0),
#("perceptualtristimulus0", 'ircamd', False, True,  'PerceptualTristimulus', (3, 3), (0, 1)),
#("perceptualtristimulus1", 'ircamd', False, True,  'PerceptualTristimulus', (3, 3), (0, 2)),
#("perceptualtristimulus2", 'ircamd', False, True,  'PerceptualTristimulus', (3, 3), (0, 3)),
("sharpness",              'ircamd', False, True,  'Sharpness', 1, 0),
("zeroCross",              'ircamd', False, True,  'SignalZeroCrossingRate', 1, 0),
("centroid",               'ircamd', False, True,  'SpectralCentroid', 6, 0),
("crest0",                 'ircamd', False, True,  'SpectralCrest', 4, 0),
("crest1",                 'ircamd', False, True,  'SpectralCrest', 4, 1),
("crest2",                 'ircamd', False, True,  'SpectralCrest', 4, 2),
("crest3",                 'ircamd', False, True,  'SpectralCrest', 4, 3),
("decrease",               'ircamd', False, True,  'SpectralDecrease', 1, 0),
("flatness0",              'ircamd', False, True,  'SpectralFlatness', 4, 0),
("flatness1",              'ircamd', False, True,  'SpectralFlatness', 4, 1),
("flatness2",              'ircamd', False, True,  'SpectralFlatness', 4, 2),
("flatness3",              'ircamd', False, True,  'SpectralFlatness', 4, 3),
("kurtosis",               'ircamd', False, True,  'SpectralKurtosis', 6, 0),
("rolloff",                'ircamd', False, True,  'SpectralRolloff', 1, 0),
("skewness",               'ircamd', False, True,  'SpectralSkewness', 6, 0),
("slope",                  'ircamd', False, True,  'SpectralSlope', 6, 0),
("spectralspread",         'ircamd', False, True,  'SpectralSpread', 6, 0),
("variation",              'ircamd', False, True,  'SpectralVariation', 3, 0),
("spread",                 'ircamd', False, True,  'Spread', 1, 0),
("spectralpower",          'ircamd', False, True,  'TotalEnergy', 1, 0),
]

descriptIsAmp = ["power", "spectralpower", "noiseenergy", "loudness", "harmonicenergy", "energyenvelope"]

descriptNotMixable = ["f0", "zeroCross", "effDur-seg"]