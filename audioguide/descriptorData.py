import sys, os
import metrics
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
			print name
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
			self.calced[(start, end)] = metrics.DescriptorComputation(self.dobj, self.sfseghandle, start, end)
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
