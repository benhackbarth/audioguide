import numpy as np
np.seterr(invalid='ignore')
import sys, os
import util
sys.path.append('/Users/ben/Documents/audioGuide/0-new')
sys.path.append('/Users/ben/Documents/audioGuide/0-new/pylib2.7-darwin-64')



class container:
	def __init__(self, dobjList, sfSegHandle):
		self.len = sfSegHandle.lengthInFrames
		self.dobjList = dobjList
		self.nameToObjMap = {}
		for dobj in dobjList:
			if dobj.seg:
				self.nameToObjMap[dobj.name] = segmentedDescriptorData(dobj, sfSegHandle)
			else:
				self.nameToObjMap[dobj.name] = timeVaryingDescriptorData(dobj)
	##########
	def getDescriptorOrigins(self):
		'''Find out which descriptors get loaded from disk,
		which are transformed, which are averaged.'''
		loadDesc = []
		onflyDesc = [] # computed after diskn read
		onflyDescSeg = [] # computed when needed
		for dobj in self.dobjList:
			if dobj.type == 'rawsdif':
				loadDesc.append(dobj)
			else:
				if dobj.seg: onflyDescSeg.append(dobj)
				else: onflyDesc.append(dobj)
		return loadDesc, onflyDesc, onflyDescSeg
	##########
	def __getitem__(self, item):
		if isinstance(self.nameToObjMap[item], timeVaryingDescriptorData):
			return self.nameToObjMap[item]
		elif isinstance(self.nameToObjMap[item], segmentedDescriptorData):
			return self.nameToObjMap[item]
	##########
	def __setitem__(self, name, vals):
		if isinstance(self.nameToObjMap[name], timeVaryingDescriptorData):
			self.nameToObjMap[name].data = vals
		elif isinstance(self.nameToObjMap[name], segmentedDescriptorData):
			print "ERROR, cannot 'setitem' an averaged descriptor"
			sys.exit(1)
	##########
	def __str__(self):
		printStr = ''
		for name, obj in self.nameToObjMap.items():
			if obj.dobj.seg:
				printStr += "\t%s : %.2f\n"%(name, obj.get(0, None))
			else:
				printStr += "\t%s : %i value array\n"%(name, len(obj))
		return '<descriptor data container class>\n%s\n'%printStr
	##########
	def getdict(self):
		output = {}
		for name, obj in self.nameToObjMap.items():
			if name.find('-seg') != -1:
				obj.get(0, self.len) # force a seg calc for output
				writable = {}
				for key, val in obj.calced.items():
					writable["%s-%s"%(key[0], key[1])] = val
				output[name] = writable
			else:
				output[name] = list(obj.data)
		return output
		
		
		
class timeVaryingDescriptorData:
	def __init__(self, dobj):
		self.dobj = dobj
		self.data = None # gets set in SfSegment class
		self.datanorm = None # gets created when values are requested
		self.normSubtract = None # gets set by self.setNorm()
		self.normDivide = None # gets set by self.setNorm()
	##########
	def __len__(self):
		return len(self.data)
	##########
	def setNorm(self, subtract, divide):
		self.normSubtract = subtract
		self.normDivide = divide
	##########
	def __getitem__(self, *args):
		if len(args) == 0: # return it all
			return self.data
		elif len(args) == 1: # just a single value
			return self.data[args[0]]
		else: # returna slice
			return self.data[slice(args[0], args[1])]
	##########
	def __setitem__(self, *args):
		if len(args) == 1: # set whole array
			self.data = args[0]
		elif len(args) == 2: # set a slice of the array
			self.data[ args[0] ] = args[1]
	##########
	def getnorm(self, *args):
		if self.datanorm == None: # do it!
			self.datanorm = (self.data-self.normSubtract)/self.normDivide
		if len(args) == 0: # return it all
			return self.datanorm
		elif len(args) == 1: # return a single value
			return self.datanorm[args[0]]
		else: # return a slice
			return self.datanorm[slice(args[0], args[1])]





class segmentedDescriptorData:
	def __init__(self, dobj, sfseghandle):
		self.dobj = dobj
		self.sfseghandle = sfseghandle
		self.normSubtract = None
		self.normDivide = None
		self.clear()
		self.v = False
	##########
	def clear(self):
		self.calced = {}
		self.calcednorm = {}	
	##########
	def __len__(self):
		return len(self.calced)
	##########
	def setNorm(self, subtract, divide):
		self.normSubtract = subtract
		self.normDivide = divide
	##########
	def get(self, start, end):
		if not self.calced.has_key((start, end)):
			self.calced[(start, end)] = DescriptorComputation(self.dobj, self.sfseghandle, start, end)
			if self.v: print "averaged: %s from %s-%s == %.3f"%(self.dobj.name, start, end, self.calced[(start, end)])
		return self.calced[(start, end)]
	##########
	def getnorm(self, start, end):
		if not self.calcednorm.has_key((start, end)):
			self.calcednorm[(start, end)] = (self.get(start, end)-self.normSubtract)/self.normDivide
			if self.v: print "averaged and normalised: %s from %s-%s == %.3f"%(self.dobj.name, start, end, self.calcednorm[(start, end)])
		return self.calcednorm[(start, end)]
	##########
	def rawvalues(self):
		'''gives back all calculated raw values of a 
		particular descriptor.  useful for obtaining
		normailization coefficients.'''
		return self.calced.values()







def peakTimeSeg(powers):
	return np.argmax(powers)+0.5 # the middle of the peak window, reduces error to +/-0.5

def logAttackTime(powers):
	idx = np.argmax(powers)
	time = np.clip(ag.f2s(idx), 0.0001, sys.maxint)
	return np.log(time) # the middle of the peak window, reduces error to +/-0.5

def f0Seg(f0s):
	idxs = np.nonzero(f0s)[0]
	tmp = []
	for idx in idxs: tmp.append(f0s[idx])
	if len(tmp) == 0: return 0. # 0 means f0 didn't find an estimate!
	return np.median(tmp)

def descriptorSlope(handle, descriptName, start, NORMALIZE_FOR_DURATION=True):
	# with Norbert Schnell
	if start == None: effStart = 0
	else: effStart = start
	effDur = handle.desc['effDur-seg'].get(effStart, None)
	descript = handle.desc[descriptName][effStart:effStart+effDur]
	start = int((len(descript))*0.2) # only take descriptor from %20-%80 
	end = int((len(descript))*0.8)
	values = np.array(descript[start:end])
	if len(values) < 2: return 0.
	if NORMALIZE_FOR_DURATION: cmpLine = np.linspace(0, 1, num=len(values))
	else: cmpLine = np.linspace(0, len(values), num=len(values))
	return np.polyfit(cmpLine, values, 1)[0]




def MIDIPitchByFileName(name, midiPitchMethod, handle, notfound=-1):
	# midiPitchMethod == 'filename' || int/float || yin-seg || centroid-seg
	if midiPitchMethod == 'filename':
		fileHead = os.path.splitext(os.path.split(name)[1])[0]
		test = getMidiPitchFromString(fileHead)
		if test != False: return test
		else: return notfound
	elif midiPitchMethod == 'composite':
		test = getMidiPitchFromString( os.path.splitext(os.path.split(name)[1])[0] )
		if test != False:
			return test
		else:
			return MIDIPitchByFileName(name, 'f0-seg', handle)
	elif type(midiPitchMethod) in [float, int]:
		return midiPitchMethod
	elif midiPitchMethod == 'centroid-seg':
		return util.frq2Midi(handle.desc['centroid-seg'].get(0, None))
	elif midiPitchMethod == 'f0-seg':
		if handle.desc['f0-seg'].get(0, None) != 0:
			return util.frq2Midi(handle.desc['f0-seg'].get(0, None))
		else:
			return notfound



FILENAME_PITCH_DICT = {} # save string results here so it doesn't have to reevaulate..
def getMidiPitchFromString(string):
	import os, re
	global FILENAME_PITCH_DICT
	if FILENAME_PITCH_DICT.has_key(string): return FILENAME_PITCH_DICT[string]
	pitchDict = {"c": 0,"cs": 1,"db": 1,"d": 2,"ds": 3,"eb": 3,"e": 4, 'fb': 4, "f": 5,"fs": 6,"gb": 6,"g": 7,"gs": 8,"ab": 8,"a": 9,"as": 10,"bb": 10, "b": 11, 'cb': 11}
	results = []
	results.extend(re.compile(r'[a-gA-G][sb\#][0123456789]').findall(string)) # re command for searching three element pattern
	results.extend(re.compile(r'[a-gA-G][0123456789]').findall(string)) # no accidentals!!
	if len(results) > 0: # found something
		result = results[0]
		if len(result) == 2: 
			pch = result[0].lower()
			octv = result[1]
		else:
			pch = result[0:2].lower().replace('#', 's')
			octv = result[2]
		returnPitch = pitchDict[pch]+(int(octv)+1)*12
		FILENAME_PITCH_DICT[string] = returnPitch
		return returnPitch
	else:
		FILENAME_PITCH_DICT[string] = False
		return False # could'nt find one

def percentInFile(handle, start, end):
	if handle.typed == 'target':
		output = (start/float(handle.lengthInFrames))*100. # computed in frames
	else:
		output = (handle.startSec/float(readsf.fileDuration(handle.filename)))*100. # computed in seconds
	return output

def effectiveDur(handle, time, absThreshScalar=-60):
	# RETURN SEGMENT LENGTH IN FRAMES
	counter = handle.lengthInFrames-1
	while True: # count from the end
		if util.ampToDb(handle.desc['power'][counter]) > absThreshScalar: break
		counter -= 1
		if counter < 0: return handle.lengthInFrames
	#realDur = handle.endSec-handle.startSec
	#time = ops.DESCRIPTOR_HOP_SIZE_SEC*(counter+1)
	return counter+1

def delta(vals):
	if len(vals) > 1:
		output = np.diff(vals)
		output = np.insert(output, -1, 0)
		return output
	else:
		return vals

def odf(data, numberAvg): 
	# with Norbert Schnell
	# 	an averaged delta function
	dataLen = len(data)
	matrix = np.zeros((numberAvg,dataLen)) # matrix of length x number average
	for frame in range(len(data)):
		for i in range(1,numberAvg+1):
			if frame-i >= 0: matrix[i-1][frame] = data[frame-i] # fill it
	medians = np.median(matrix, axis=0)
	return data-medians

def hannWin(size):
	n = np.arange(size)
	w = 0.5*(1.0-np.cos(2*np.pi*n/(float(size-1))))
	return w







def DescriptorComputation(d, handle, start, end):
	if d.seg:
		# SINGLE-NUMBER METHODS
		if d.name == "dur-seg": # raw segment duration
			output = handle.lengthInFrames
		elif d.name == "effDur-seg": # perceived segment duration
			output = effectiveDur(handle, start)
		elif d.name == "MIDIPitch-seg":
			output = MIDIPitchByFileName( handle.printName, handle.midiPitchMethod, handle )
		elif d.name == "peakTime-seg":
			output = peakTimeSeg(handle.desc['power'][start:end])
		elif d.name == "logAttackTime-seg":
			output = logAttackTime(handle.desc['power'][start:end])
		elif d.name == "percentInFile-seg":
			output = percentInFile(handle, start, end)
		elif d.name == "f0-seg":
			output = f0Seg(handle.desc['f0'][start:end])
		# DESCRIPTOR SLOPE
		elif d.type == 'slope-regression':
			output = descriptorSlope(handle, d.parents[0], start)
		# FLAT MEAN - NOT ENERGY WEIGHTED
		elif d.type  == 'mean':
			output = np.average(handle.desc[d.parents[0]][start:end])
		# SEGMENT-AVERAGE METHODS
		elif d.seg_method  == 'max':
			output = np.max(handle.desc[d.parents[0]][start:end])
		elif d.seg_method  == 'median':
			output = np.median(handle.desc[d.parents[0]][start:end])
		else: # 'weighted_mean'
			try:
				output = np.average(handle.desc[d.parents[0]][start:end], weights=handle.desc['power'][start:end])
			except ZeroDivisionError: # in case all powers are zero
				output = np.average(handle.desc[d.parents[0]][start:end])
	else:
		# DELTA
		if d.type == 'delta':
			output = delta(handle.desc[d.parents[0]][start:end])
		# DELTA DELTA
		elif d.type == 'deltadelta':
			output = delta(delta(handle.desc[d.parents[0]][start:end]))
		# ONSET DETECTION FUNCTION CALL
		elif d.type == 'onsetdetection':
			analSplit = d.name.split('-')
			output = odf(handle.desc[d.parents[0]][start:end], int(analSplit[2]))
		else:
			print "No method for %s, Quitting..." % anal
			util.exit()
	return output
