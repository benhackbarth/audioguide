############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os
import audioguide.anallinkage as anallinkage
import audioguide.descriptordata as descriptordata
import audioguide.util as util
import numpy as np





def getClassChecksum(classinstance, also=[]):
	check_me = []
	for a in dir(classinstance):
		if a.startswith('__'): continue
		if a == 'descriptor_list': check_me.extend([a._checksum for a in getattr(classinstance, a)])
		else: check_me.append(str(getattr(classinstance, a)))
	return util.listToCheckSum(check_me)










class TargetOptionsEntry(object):
	def __init__(self, filename, start=None, end=None, thresh=-40, offsetRise=1.5, offsetThreshAdd=+12, offsetThreshAbs=-80, scaleDb=0, minSegLen=0.1, maxSegLen=1000, midiPitchMethod='composite', stretch=1, segmentationFilepath=None, multiriseBool=False, multirisePercentDev=20, multiriseSteps=5, decompose={}, partials=None):
		self.filename = filename
		self.start = start
		self.end = end
		self.thresh = thresh
		self.offsetRise = offsetRise
		self.offsetThreshAdd = offsetThreshAdd
		self.offsetThreshAbs = offsetThreshAbs
		self.minSegLen = minSegLen
		self.maxSegLen = maxSegLen
		self.scaleDb = scaleDb
		self.midiPitchMethod = midiPitchMethod
		self.stretch = stretch
		self.segmentationFilepath = segmentationFilepath
		self.multiriseBool = multiriseBool
		self.multirisePercentDev = multirisePercentDev
		self.multiriseSteps = multiriseSteps
		self.decompose = decompose
		self.partials = partials
		
		self._checksum = getClassChecksum(self)
	# equality test function for interactive mode
	def __eq__(self, other): return type(self) == type(other) and self._checksum == other._checksum
	def __ne__(self, other): return not self.__eq__(other)
		



class CorpusOptionsEntry(object):
	def __init__(self, name,  allowRepetition=True, concatFileName=None, end=None, envelopeSlope=1, excludeStr=None,  excludeTimes=[], includeStr=None, includeTimes=[], limit={}, pitchfilter={}, limitDur=None,  midiPitchMethod='composite', offsetLen='30%', onsetLen=0.01, recursive=True, restrictInTime=0, restrictOverlaps=None,  restrictRepetition=0.5,  scaleDb=0.0,  scaleDistance=1,  segmentationExtension='.txt',  segmentationFile=None,  start=None,  superimposeRule=None,  transMethod=None,  transQuantize=0, wholeFile=False, wholeFileMinStart=0, wholeFileMaxEnd=None, metadata=[], maxPercentTargetSegments=None, instrTag=None, instrParams={}, clipDurationToTarget=False):
		self.name = name
		self.start = start
		self.end = end
		self.envelopeSlope = envelopeSlope
		self.excludeStr = excludeStr
		self.excludeTimes = excludeTimes
		self.includeStr = includeStr
		self.includeTimes = includeTimes
		self.limit = limit
		self.pitchfilter = pitchfilter
		self.wholeFile = wholeFile
		self.wholeFileMinStart = wholeFileMinStart
		self.wholeFileMaxEnd = wholeFileMaxEnd
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
		self.scaleDistance = scaleDistance
		self.segmentationExtension = segmentationExtension
		self.segmentationFile = segmentationFile
		self.concatFileName = concatFileName
		self.superimposeRule = superimposeRule
		self.transMethod = transMethod
		self.transQuantize = transQuantize
		self.metadata = metadata
		self.maxPercentTargetSegments = maxPercentTargetSegments
		self.clipDurationToTarget = clipDurationToTarget
		self.instrTag = instrTag
		self.instrParams = instrParams
		# test if limit is a string make it a list
		if type(self.limit) == type(""): self.limit = [self.limit]
		# see if pitch filter has pitch strings that need to be converted into floats...
		if self.pitchfilter != {}:
			for pidx in range(len(self.pitchfilter['pitches'])):
				if isinstance(self.pitchfilter['pitches'][pidx], str):
					self.pitchfilter['pitches'][pidx] = descriptordata.getMidiPitchFromString(self.pitchfilter['pitches'][pidx])

		self._checksum = getClassChecksum(self)
	# equality test function for interactive mode
	def __eq__(self, other): return type(self) == type(other) and self._checksum == other._checksum
	def __ne__(self, other): return not self.__eq__(other)




class Score(object):
	def __init__(self, *args, **kwargs):
		assert len(args) >= 1
		self.instrumentobjs = args
		self.params = { 
		'tempo': 60,
		'meter': '4/4',
		}
		self.params.update(kwargs)
		# CUSTOM CHECKSOME
		self._checksum = util.listToCheckSum([i._checksum for i in self.instrumentobjs] + [str(self.params)])
	# equality test function for interactive mode
	def __eq__(self, other):
		return type(self) == type(other) and self._checksum == other._checksum
	def __ne__(self, other): return not self.__eq__(other)



class Instrument(object):
	def __init__(self, *args, **kwargs):
		assert len(args) == 1
		self.name = args[0]
		self.params = { 
		# VARIABLES THAT CAN BE OVERRIDDEN BY CSF instrParams={}
		# handle temporality
		'temporal_mode': 'sus', # dictates how duration is handled for this technique
		'minspeed': 0.075,
		# handle polyphony
		'polyphony_max_voices': 1, 		
		'polyphony_minspeed': None,
		'polyphony_min_range': None,
		'polyphony_max_range': None,
		#'polyphony_interval_tests': [], # good idea, not implemented yet :(
		'polyphony_permit_unison': False,
		'polyphony_max_db_difference': 4,
		# handle pitch across time
		#'interval_exclude': [], # 	the difference in semitones between two adjectent notes may not be found in this list
		'interval_limit_breakpoints': [], # [(0, 7), (1, 12)]
		'interval_limit_range_per_sec': None,
		# handle dynamics
		'dynamics': ('pp', 'p', 'mp', 'mf', 'f', 'ff'),
		# INSTRUMENT_ONLY VARIABLES
		'technique_switch_delay_map': [], # 
		'clef': 'G', 
		'key': 'CM', 
		}
		self.params.update(kwargs)
		# if 'tags' not given, it is the name of the instrument..
		if 'cpsTags' not in self.params: self.params['cpsTags'] = [self.name]

		self._checksum = getClassChecksum(self)
	# equality test function for interactive mode
	def __eq__(self, other): return type(self) == type(other) and self._checksum == other._checksum
	def __ne__(self, other): return not self.__eq__(other)



class SearchPassOptionsEntry(object):
	def __init__(self, *args, **kwargs):	
		self.method = args[0]
		if self.method == 'parser':
			self.parsetest = args[1]
			self.submethod = args[2]
			self.parse_choiceargs = list(args[3:])
			self.parsedescriptor, self.parseSymbol, self.parsevalue = util.parseEquationString(self.parsetest, ['==', '!=', '<', '<=', '>', '>='])
			self.parsedescriptor = SingleDescriptor(self.parsedescriptor)
			self.descriptor_list = [self.parsedescriptor]
			# test to see if it is a percentage
			if self.parsevalue.find('%') == -1:
				self.needMinMax = False
			else: # its a percentage
				self.needMinMax = True
				self.parsevalue = float(self.parsevalue.replace('%', ''))
			
			if self.submethod == 'corpus_select':
				pass
			else:
				self.descriptor_list += args[3] + args[4] # add other descriptors for loading
			#print(self.parsetest, self.submethod, self.parsedescriptor, self.parseSymbol, self.parsevalue, self.needMinMax, self.descriptor_list)
			_defaults = {}
		elif self.method == 'target_partial_filter':
			self.submethod = None
			self.needMinMax = False
			_defaults = {'bypass': False, 'pitchtolerance': 4, 'dbtolerance': 12}
			self.descriptor_list = []
		else:
			self.submethod = None
			self.needMinMax = False
			self.descriptor_list = args[1:]
			_defaults = {'percent': None, 'minratio': None, 'maxratio': None, 'complete_results': False, 'number': 10}
		
		for k in kwargs:
			if not k in _defaults:
				print('options', 'csf object does not have a keyword argument "%s"'%k)
		for k, v in _defaults.items(): setattr(self, k, kwargs.get(k, v))
		#####
		if self.method == 'closest': self.complete_results = True
		self._checksum = getClassChecksum(self)
	# equality test function for interactive mode
	def __eq__(self, other): return type(self) == type(other) and self._checksum == other._checksum
	def __ne__(self, other): return not self.__eq__(other)



class SuperimpositionOptionsEntry(object):
	def __init__(self, minSegment=None, maxSegment=None, minFrame=None, maxFrame=None, minOverlap=None, maxOverlap=None, overlapAmpThresh=-70, searchOrder='power', subtractScale=1, subtractDur='corpusDur', ampDur='corpusDur', overlapDur='corpusEffDur', calcMethod='mixture', simCalcDur='corpusEffDur', peakAlign=False, peakAlignEnvelope='subtracted', incr=1):
		self.minSegment = minSegment
		self.maxSegment = maxSegment
		self.minFrame = minFrame
		self.maxFrame = maxFrame
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
		self._checksum = getClassChecksum(self)
	# equality test function for interactive mode
	def __eq__(self, other): return type(self) == type(other) and self._checksum == other._checksum
	def __ne__(self, other): return not self.__eq__(other)



class SingleDescriptor(object):
	def __init__(self, name, weight=1., norm=2., normmethod='stddev', distance='euclidean', limit=False, simultaneous=None, energyWeight=False, origin='SEARCH', neededBy=['target', 'corpus'], packagename=None):
		singleNumberDescriptors = ['effDur-seg', 'dur-seg', 'effDurFrames-seg', 'peakTime-seg', 'MIDIPitch-seg', 'percentInFile-seg', 'temporalIncrease-seg', 'temporalDecrease-seg', 'logAttackTime-seg', 'temporalCentroid-seg']
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
		namedict = descriptordata.descriptor_string_parse(name)
		self.type = namedict['type']
		self.seg = namedict['isseg']
		self.seg_method = namedict['seg_method']
		if namedict['parent'] == None: self.parents = []
		else: self.parents = [namedict['parent']]
		self.describes_energy = namedict['describes_energy']
		self.is_mixable = namedict['is_mixable']
		self._checksum = getClassChecksum(self)
	# equality test function for interactive mode
	def __eq__(self, other): return type(self) == type(other) and self._checksum == other._checksum
	def __ne__(self, other): return not self.__eq__(other)



