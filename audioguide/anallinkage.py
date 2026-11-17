############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os, subprocess, time, json, tempfile
sys.path.insert(0, os.path.dirname(__file__)) # look here first
import numpy as np
import audioguide.util as util
import audioguide.descriptordata as descriptors
import audioguide.descriptoranalysis as descriptoranalysis





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

	def __init__(self, resampleRate=11025, userFftSize=512, userHopSize=128, userRmsFftSize=256, userRmsHopSize=64, F0MinFrequency=200, F0MaxFrequency=5000, numbMfccs=13, numbMels=20, forceAnal=False, p=None, searchPaths=[], dataDirectoryLocation=None):
		self.desc_manager = descriptors.descriptor_manager(numbMfccs=numbMfccs, numbMels=numbMels)
		# establish data directory
		if dataDirectoryLocation == None:
			self.dataDirectory = os.path.dirname(__file__)
		else:
			self.dataDirectory = os.path.abspath(dataDirectoryLocation)
			if not os.path.exists(self.dataDirectory): os.makedirs(self.dataDirectory)

		self.rawData = {} # file, descriptdict
		self.p = p
		# anal
		self.resampleRate = resampleRate
		self.userFftSize = userFftSize
		self.userHopSize = userHopSize
		self.userRmsFftSize = userRmsFftSize
		self.userRmsHopSize = userRmsHopSize
		self.winLengthSec = userFftSize/self.resampleRate
		self.hopLengthSec = userHopSize/self.resampleRate # used by anal.f2s!!

		self.F0MinFrequency = F0MinFrequency
		self.F0MaxFrequency = F0MaxFrequency
		self.numbMfccs = numbMfccs
		self.numbMels = numbMels
		# other stuff
		self.forceAnal = forceAnal
		self.searchPaths = searchPaths

		### setup ircam binary config text file	
		self.analdir = os.path.join(self.dataDirectory, 'data')

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
		# make a list of all possible descriptor objects, needed by agGetDescriptors.py
		self.allDescriptors = []
		from userclasses import SingleDescriptor as d
		_, cols = descriptoranalysis.get_feature_list(self.numbMels, self.numbMfccs)
		for desc in cols:
			dobj = d(desc)
			self.allDescriptors.append( dobj )
			if not dobj.seg:
				self.allDescriptors.append( d(desc+'-seg') )
		for desc in self.internalDescriptorNames:
			self.allDescriptors.append( d(desc) )
		# write log
		if self.p != None: 
			self.p.log("ANALYSIS CONFIG: using analysis window of %.3f (%i samples @ %isr)"%(self.winLengthSec, self.userFftSize, self.resampleRate))
			self.p.log("ANALYSIS CONFIG: using analysis overlap of %.3f (%i samples @ %isr)"%(self.hopLengthSec, self.userHopSize, self.resampleRate))
	########################################################
	def setupDescriptors(self, ops):
		####################################################
		## global variables for filename -> dynamic -> dB ##
		####################################################
		self.dynToDbDict = ops.DYNAMIC_TO_DECIBEL
		TMP_FILENAMESTRING_TO_DYN = {
		'ppp': ['ppp'],
		'pp': ['pianissimo', 'pp'],
		'p': ['piano', 'p', 'p1', 'p2', 'pianissimo'],
		'mp': ['mezzo-piano', 'mp'],
		'mf': ['mezzo-forte', 'mf', 'ppmfpp'],
		'f': ['forte', 'f', 'fp', 'pfp'],
		'ff': ['fortissimo', 'ff', 'ffp', 'f-ff', 'ppff', 'ffpp', 'sfz'],
		'fff': ['fff'],
		}
		self.stringToDynDict = {}
		for k, v in TMP_FILENAMESTRING_TO_DYN.items():
			for i in v: self.stringToDynDict[i] = k
		self.stringToDynDict.update(ops.FILENAMESTRING_TO_DYNAMICS)
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
	def __createLibrosaDescriptorsFile__(self, sffile, analdir, npypath, jsonpath, debug=False):
		import descriptoranalysis
		# test to see if audio file could not be opened
		if not descriptoranalysis.is_valid_audiofile(sffile):
			util.error('commandline', 'Could not read "%s" as it doesn\'t seem to be a vaild audio file. Please remove from your corpus.'%(sffile))	
		librosa_array, infodict = descriptoranalysis.extract_all_descriptors(sffile, resampled_sr=self.resampleRate, n_fft_features=self.userFftSize, hop_length_features=self.userHopSize, n_win_rms=self.userRmsFftSize, n_hop_rms=self.userRmsHopSize, n_mels_for_mfccs=128, n_mels_feature=self.numbMels, n_mfcc=self.numbMfccs, funda_min_hz=self.F0MinFrequency, funda_max_hz=self.F0MaxFrequency)
		infodict['librosad']['filehead'] = os.path.split(npypath)[1]
		# write files
		f = open(jsonpath, "w")
		json.dump(infodict, f)
		f.close()
		np.save(npypath, librosa_array)
		return infodict, librosa_array
	########################################################
	########################################################
	def validateAnalResource(self, sffile):
		sffile = os.path.abspath(sffile)
		if not sffile in self.rawData:
			self.initAnalResource(sffile)
		return self.rawData[sffile]['info']['lengthsec'], self.rawData[sffile]['info']['channels']
	########################################################
	########################################################
	def getSegmentFrameLength(self, segmentStartSec, segmentDurationSec, sffile):
		start_f = self.s2f(segmentStartSec, sffile, minimum=1)
		length = self.s2f(segmentDurationSec, sffile, minimum=1)
		if start_f+length > self.rawData[sffile]['info']['librosad']['framelength']:
			length = self.rawData[sffile]['info']['librosad']['framelength'] - start_f
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
		a librosa analysis because it is required for all
		sound files used.'''
		self.rawData[sffile] = {'info': {}}
		sfroot, sfhead = os.path.split(sffile)
		sfheadroot, sfheadext = os.path.splitext(sfhead)
		self.rawData[sffile]['fileroot'] = os.path.join(self.analdir, sfheadroot)
		
		self.rawData[sffile]['checksum'] = util.listToCheckSum([sffile, self.resampleRate, self.winLengthSec, self.hopLengthSec, self.F0MinFrequency, self.F0MaxFrequency, self.numbMfccs, 'librosad'])[:12]
		filehead = '%s-%s'%(sfheadroot, self.rawData[sffile]['checksum'])
		descriptorfile = os.path.join(self.analdir, '%s-librosad.npy'%(filehead))
		infofile = os.path.join(self.analdir, '%s.json'%(filehead))
		
		if not os.path.exists(descriptorfile) or not os.path.exists(infofile) or util.checkIfFileIsNewer(sffile, descriptorfile) or util.checkIfFileIsNewer(sffile, infofile) or self.forceAnal:
			# do analysis
			if self.p != None:
				self.p.log("ANAL DATA: creating NPY FILE '%s'"%descriptorfile)
			# create files
			self.rawData[sffile]['info'], self.rawData[sffile]['librosad'] = self.__createLibrosaDescriptorsFile__(sffile, self.analdir, descriptorfile, infofile)
		else:
			# load files
			f = open(infofile, "r")
			self.rawData[sffile]['info'].update(json.load(f))
			f.close()
			self.rawData[sffile]['librosad'] = np.load(descriptorfile)
		self.rawData[sffile]['arraylen'] = self.rawData[sffile]['librosad'].shape[0]
		# touch file in data registry
		self.dataRegistry[filehead] = time.time(), os.stat(sffile).st_size
	########################################################
	########################################################
	def getDescriptorMatrix(self, sffile):
		return self.rawData[sffile]['librosad']
	########################################################
	########################################################
	def getDescriptorColumn(self, sffile, dname):
		return self.rawData[sffile]['librosad'][:,self.rawData[sffile]['info']['librosad_columns'][dname]]
	########################################################
	########################################################
	def analize_spectralPeaks(self, filepath, minamp=0.001, fftsize=2048, hop_length=2048, min_midi=20, max_midi=108):
		import librosa
		import peakutils
		checksum = util.listToCheckSum([filepath, fftsize, hop_length, minamp, min_midi, max_midi, 'peaks'])[:12]
		filehead = '%s-%s'%(os.path.splitext(os.path.split(filepath)[1])[0], checksum)
		outputpath = os.path.join(self.analdir, '%s-peaks.json'%(filehead))
	
		if os.path.exists(outputpath):
			fh = open(outputpath, 'r')
			return json.load(fh)
		y, sr = librosa.load(filepath, sr=None, mono=True)
		outputdata = {'sr': sr, 'fftsize': fftsize, 'peaks': []}
		halfwin = int(fftsize/2)
		binsize = sr/float(fftsize)
		lins = np.linspace(0, halfwin-1, num=halfwin+1)
	
		S = np.abs(librosa.stft(y, n_fft=fftsize, hop_length=hop_length))

		for fidx, frame in enumerate(np.rot90(S)):
			indexes = peakutils.indexes(frame, thres=minamp, min_dist=10)
			# interpolate indexes for better frq accuracy
			interp_indexes = peakutils.interpolate(lins, frame, ind=indexes)
			timesec = fidx*(float(hop_length)/sr)
			framepeaks = []
			for ii in interp_indexes:
				if ii < 0: continue
				midi = util.frq2Midi(ii * binsize)
				if midi < min_midi or midi > max_midi: continue
				iamp = util.ampToDb(np.interp(ii, lins, frame)*(2./float(fftsize)))
				framepeaks.append( [iamp, midi] )
			framepeaks.sort(reverse=True)
			outputdata['peaks'].append([timesec, framepeaks])

		fh = open(outputpath, 'w')
		json.dump(outputdata, fh)
		return outputdata



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
		removedCount = 0
		for timestamp, bytes, filehead in timeordered:
			timediff = currenttimestamp-timestamp
			# if total bytes is over 1 gb and file hasn't been used for a week...
			if timediff > secondLimit and totalBytes > byteLimit:
				listToRemove.append(filehead)
				del self.dataRegistry[filehead]
				#os.remove(os.path.join(self.analdir, filehead+'.npy'))
				#os.remove(os.path.join(self.analdir, filehead+'.json'))
				removedCount += 2
				#print("RM "+os.path.join(self.analdir, filehead+'.npy'))
				#print("RM "+os.path.join(self.analdir, filehead+'.json'))
			totalBytes += bytes
		if removedCount > 0:
			print("deleted %i outdated analysis files"%removedCount)
		fh = tempfile.NamedTemporaryFile(mode='w', suffix='.json', delete=False)
		dataRegistryPathTmp = fh.name
		json.dump(self.dataRegistry, fh)
		fh.close()
		try:
			import shutil
			shutil.copy(dataRegistryPathTmp, self.dataRegistryPath)
		finally:
			os.remove(dataRegistryPathTmp)

########################################################
########################################################








#############################
## PACKAGES OF DESCRIPTORS ##
#############################
def parseOptionPackages(optionname, optionvalue, numbMfccs=13):
	if optionname == 'SEARCH':
		for spass in optionvalue:
			spass.descriptor_list = descriptListPackageExpansion(spass.descriptor_list, numbMfccs)
			if spass.submethod in ['closest','closest_percent','farthest','farthest_percent',]:
				for idx in range(len(spass.parse_choiceargs)):
					spass.parse_choiceargs[idx] = descriptListPackageExpansion(spass.parse_choiceargs[idx], numbMfccs)
	elif optionname == 'EXPERIMENTAL':
		for k, v in optionvalue.items():
			if isinstance(v, spass):
				optionvalue = descriptListPackageExpansion(optionvalue, numbMfccs)
	return optionvalue



def equally_weighted_package(dobjname, dobjweight):
	packages = [('chromas', 'chroma', 12), ('contrasts', 'contrast', 7), ('poly_features', 'poly_features', 2), ('tonnetz', 'tonnetz', 6), ]
	foundit = False
	descriptors_to_add = []
	
	for searchname, usename, number in packages:
		if not dobjname.startswith(searchname): continue
		foundit = True
		for n in range(number):
			newd = dobjname.replace(searchname, '%s%i'%(usename, n))
			descriptors_to_add.append( (newd, dobjweight/float(number)) )
		break

	return foundit, descriptors_to_add


def descriptListPackageExpansion(initialListOfDescriptorObjs, numbMfccs, numbMels=20):
	from userclasses import SingleDescriptor as d
	newListOfDescriptorObjs = []
	packages = ''

	for dobj in initialListOfDescriptorObjs:
		metricsToWrite = []
		is_package, desc_list = equally_weighted_package(dobj.name, dobj.weight)

		if is_package:
			metricsToWrite.extend(desc_list)
		elif dobj.name.find('mfccs') != -1:
			mfccWeightMask = np.power(np.linspace(1., 0.05, num=numbMfccs-1), 0.5)
			for i in range(numbMfccs-1):
				metricsToWrite.append(('mfcc'+str(i+1)+dobj.name[5:], dobj.weight*(mfccWeightMask[i]/sum(mfccWeightMask)) ))
		elif dobj.name.find('mels') != -1:
			melSpectrumMask = np.power(np.linspace(1., 0.05, num=numbMels-1), 0.5)
			for i in range(numbMels-1):
				metricsToWrite.append(('mel'+str(i+1)+dobj.name[4:], dobj.weight*(melSpectrumMask[i]/sum(melSpectrumMask)) ))


		
		elif dobj.name.find('stats') != -1:
			stats = ['-seg', '-minseg', '-maxseg', '-stdseg', '-kurtseg', '-skewseg']
			for i, stat in enumerate(stats):
				metricsToWrite.append( [ dobj.name[:-6]+stat, dobj.weight/float(len(stats))] )
		# add original if not a package, add package elements otherwise
		if len(metricsToWrite) == 0:
			newListOfDescriptorObjs.append(dobj)
		else:
			for name, weight in metricsToWrite:
				newdobj = d(name, weight=weight, norm=dobj.norm, normmethod=dobj.normmethod, distance=dobj.distance, limit=dobj.limit, energyWeight=dobj.energyWeight, origin=dobj.origin, neededBy=dobj.neededBy, packagename=dobj.name)
				#print "ADDING", newdobj, newdobj.weight
				newListOfDescriptorObjs.append(newdobj)
	return newListOfDescriptorObjs





descriptIsAmp = ["power", "rms", "spectralpower", "noiseenergy", "loudness", "harmonicenergy", "energyenvelope"]

descriptNotMixable = ["f0", "f0flag", "f0prob", "zeroCross", "effDur-seg"]