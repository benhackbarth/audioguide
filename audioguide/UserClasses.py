import sys, os
sys.path.append('/Users/ben/Documents/audioGuide/0-new')
import sdiflinkage, util, sdiflinkage, metrics, descriptorData, util
import numpy as np



class TargetOptionsEntry:
	def __init__(self, filename, start=None, end=None, thresh=-40, rise=1.5, scaleDb=0, minSegLen=0.05, maxSegLen=1000, midiPitchMethod='composite', stretch=1):
		self.filename = filename
		self.start = start
		self.end = end
		self.thresh = thresh
		self.rise = rise
		self.minSegLen = minSegLen
		self.maxSegLen = maxSegLen
		self.scaleDb = scaleDb
		self.midiPitchMethod = midiPitchMethod
		self.stretch = stretch




class CorpusOptionsEntry:
	def __init__(self, name,  allowRepetition=True, concatFileName=None,  end=None,  envelopeSlope=1,  excludeStr=None,  excludeTimes=[], hasParams=False, includeStr=None,  includeTimes=[],  limit={},  limitDur=None,  midiPitchMethod='composite',  offsetLen='30%',  onsetLen=0.01,  recursive=True,  restrictInTime=0,  restrictOverlaps=None,  restrictRepetition=0.1,  scaleDb=0.0,  scaleDistance=1,  postSelectAmpBool=False, postSelectAmpMin=-12, postSelectAmpMax=+12, postSelectAmpMethod='power-mean-seg', segmentationExtension='.txt',  segmentationFile=None,  start=None,  superimposeRule=None,  transMethod=None,  transQuantize=0,  wholeFile=False, MWinstrName=None,  MWtext=None, MWnotehead='.'):
		self.name = name
		self.start = start
		self.end = end
		self.envelopeSlope = envelopeSlope
		self.excludeStr = excludeStr
		self.excludeTimes = excludeTimes
		self.hasParams = hasParams
		self.includeStr = includeStr
		self.includeTimes = includeTimes
		self.limit = limit
		self.wholeFile = wholeFile
		self.limitDur = limitDur
		self.midiPitchMethod = midiPitchMethod
		self.recursive = recursive
		self.allowRepetition = allowRepetition
		self.restrictInTime = restrictInTime
		self.restrictOverlaps = restrictOverlaps
		self.restrictRepetition = restrictRepetition
		self.scaleDb = scaleDb
		self.onsetLen = onsetLen
		self.offsetLen = offsetLen
		self.postSelectAmpBool = postSelectAmpBool
		self.postSelectAmpMin = postSelectAmpMin
		self.postSelectAmpMax = postSelectAmpMax
		self.postSelectAmpMethod = postSelectAmpMethod
		self.scaleDistance = scaleDistance
		self.segmentationExtension = segmentationExtension
		self.segmentationFile = segmentationFile
		self.concatFileName = concatFileName
		self.superimposeRule = superimposeRule
		self.transMethod = transMethod
		self.transQuantize = transQuantize
		self.MWinstrName = MWinstrName
		self.MWnotehead = MWnotehead
		self.MWtext = MWtext
		 

		


class SearchPassOptionsEntry:
	def __init__(self, *args, **kwargs):	
		self._all_args = args
		self.method = args[0]
		self.descriptor_list = args[1:]
		_defaults = {'percent': None, 'minratio': None, 'maxratio': None, 'complete_results': False}
		for k in kwargs:
			if not _defaults.has_key(k):
				print('options', 'csf object does not have a keyword argument "%s"'%k)
		for k, v in _defaults.iteritems(): setattr(self, k, kwargs.get(k, v))
		#####
		if self.method == 'closest': self.complete_results = True
		#self.seg = []
		#self.timevary = []
	########################################





class SuperimpositionOptionsEntry:
	def __init__(self, minSegment=None, maxSegment=None, minOnset=None, maxOnset=None, minOverlap=None, maxOverlap=None, overlapAmpThresh=-70, searchOrder='power', subtractScale=1, subtractDur='corpusDur', ampDur='corpusDur', overlapDur='corpusEffDur', calcMethod='mixture', simCalcDur='corpusEffDur', peakAlign=False, peakAlignEnvelope='subtracted', incr=1):
		self.minSegment = minSegment
		self.maxSegment = maxSegment
		self.minOnset = minOnset
		self.maxOnset = maxOnset
		self.minOverlap = minOverlap
		self.maxOverlap = maxOverlap
		self.searchOrder = searchOrder
		self.subtractScale = subtractScale
		self.calcMethod = calcMethod
		self.subtractDur = subtractDur
		self.simCalcDur = simCalcDur
		self.ampDur = ampDur
		self.overlapDur = overlapDur
		self.overlapAmpThresh = overlapAmpThresh
		self.incr = incr

		self.peakAlign = peakAlign
		self.peakAlignEnvelope = peakAlignEnvelope
		



	########################################



class SingleDescriptor:
	def __init__(self, name, weight=1., norm=2., normmethod='stddev', distance='euclidean', limit=False, simultaneous=None, energyWeight=False, origin='SEARCH', neededBy=['target', 'corpus'], packagename=None):
		singleNumberDescriptors = ['effDur-seg', 'peakTime-seg', 'MIDIPitch-seg', 'percentInFile-seg', 'temporalIncrease-seg', 'temporalDecrease-seg', 'logAttackTime-seg', 'temporalCentroid-seg']
		#neverRecalculate = ['zeroCross', 'f0', 'peakamp', 'peakfrq']
		self.name = name
		self.weight = weight
		self.norm = norm
		self.normmethod = normmethod
		self.distance = distance
		self.limit = limit
		self.neededBy = neededBy
		self.origin = origin
		self.energyWeight = energyWeight
		self.tgt_modify = []
		self.packagename = packagename
		if name.find('-slope-seg') != -1:
			self.type = 'slope-regression'
			self.seg = True
		elif name.find('-mean-seg') != -1:
			self.type = 'mean'
			self.seg = True
		elif name.find('-seg') != -1:
			self.type = 'segmented'
			self.seg = True
		elif name.find('-odf-') != -1:
			self.type = 'onsetdetection'
			self.seg = False
		elif name.find('-delta') != -1:
			self.type = 'delta'
			self.seg = False
		elif name.find('-deltadelta') != -1:
			self.type = 'deltadelta'
			self.seg = False
		else:
			self.type = 'rawsdif'
			self.seg = False
		if self.seg:
			if self.type == 'slope-regression': self.seg_method = 'slope'
			elif self.type == 'mean': self.seg_method = 'mean'
			elif self.name in ["power-seg", "rms-seg"]: self.seg_method = 'max'
			elif self.name in singleNumberDescriptors: self.seg_method = 'single_number'
			else: self.seg_method = 'weighted_mean'
		# get the "parent descriptors" which this descriptor depend upon
		namesplit = self.name.split('-')
		self.parents = []
		if self.name in singleNumberDescriptors: pass
		elif self.type in ['slope-regression', 'onsetdetection', 'delta', 'deltadelta', 'mean']:
			self.parents = [namesplit[0]]
		elif self.type == 'segmented':
			self.parents = []
			cnt = 1
			while True:
				if cnt > len(namesplit)-1: break
				self.parents.append( '-'.join(namesplit[:cnt]) )
				cnt += 1
		self.describes_energy = False
		self.is_mixable = False
		if sdiflinkage.agDescriptToSdif.has_key(name):
			filetype, energyBool, mixBool, frame, matrix, row, col = sdiflinkage.agDescriptToSdif[name]
			self.describes_energy = energyBool
			self.is_mixable = mixBool
		else:
			for pname in self.parents:
				filetype, energyBool, mixBool, frame, matrix, row, col = sdiflinkage.agDescriptToSdif[pname]
				if energyBool: self.describes_energy = True
				if mixBool: self.is_mixable = True
	########################################
	def __repr__(self):
		return self.name
	########################################
	

