############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, operator, random
import numpy as np
from . import util



class BreakIt(Exception):
	pass




class distanceCalculations:
	def __init__(self, superimposeObj, randomseed, AnalInterface, tgtsegs, p):
		random.seed(randomseed)
		self.p = p
		self.searchResults = []
		self.paramScore = []
		self.f2s = AnalInterface.f2s
		self.segmentDensityAmpScalers = [None, None]
		if superimposeObj.minFrame != None:
			self.segmentDensityAmpScalers[0] = 1/float(superimposeObj.minFrame)
		else:
			self.segmentDensityAmpScalers[0] = 1/1.
		if superimposeObj.maxFrame != None:
			self.segmentDensityAmpScalers[0] = 1/float(superimposeObj.maxFrame)
		else:
			self.segmentDensityAmpScalers[0] = 1/8.
	##############################
	def setTarget(self, spassList, tgtsegs):
		# check to see if spasses need min/max
		for spassobj in spassList:
			if spassobj.needMinMax:
				assert spassobj.parsedescriptor.seg
				# loop through target handles again, but only happens once per unique limit string
				tmp_data = [ts.desc.get(spassobj.parsedescriptor.name) for ts in tgtsegs]
				tmp_data.sort()
				# overwrite value with correct descriptor value
				spassobj.parsevalue = tmp_data[ int((spassobj.parsevalue/100.)*(len(tmp_data)-1)) ]
				del tmp_data
				spassobj.needMinMax = False

	##############################
	def setCorpus(self, cpssegs):
		self.corpusObjs = cpssegs
	##############################
	def executeSearch(self, tgtseg, tgtSeek, seach_pass_objs, superimposeObj):	
		self.searchMinMax = []
		self.logTextOutput = ''
		self.lengthAtPasses = ['%i'%len(self.corpusObjs)] # start with initial size for printing
		self.lengthAtPassesVerbose = [] 
		for spidx, spassobj in enumerate(seach_pass_objs):
			mind = sys.maxsize
			maxd = -1*sys.maxsize
			lastPass = spidx == len(seach_pass_objs)-1				
			
			if len(self.corpusObjs) < 1: return False


			####################
			## parser methods ##
			####################
			if spassobj.method == 'parser':
				newList = []
				parseTest = eval("%f %s %f"%(tgtseg.desc.get(spassobj.parsedescriptor.name), spassobj.parseSymbol, float(spassobj.parsevalue)))						
				#############################################
				## select corpus ids based on feature test ##
				#############################################
				if spassobj.submethod == 'corpus_select':
					for c in self.corpusObjs:
						if parseTest and c.voiceID in spassobj.parse_choiceargs[0]:
							newList.append(c)
						elif not parseTest and c.voiceID in spassobj.parse_choiceargs[1]:
							newList.append(c)

				##############################################
				## select descriptors based on feature test ##
				##############################################
				elif spassobj.submethod in ['closest', 'closest_percent', 'farthest', 'farthest_percent']:
					if parseTest: dlist = spassobj.parse_choiceargs[0]
					else: dlist = spassobj.parse_choiceargs[1]
					mind, maxd = self.getFeatureDifferences(tgtseg, tgtSeek, dlist, spassobj.submethod, True, superimposeObj)
					newList = self.selectFromSortedList(spassobj.submethod, spassobj.percent)




			##########################
			## partial pitch filter ##
			##########################
			elif spassobj.method == 'target_partial_filter':
				newList = []
				
				for c in self.corpusObjs:
					matches = []
					c.db = util.ampToDb(c.desc.get('power-seg')) + c.envDb
					for par in tgtseg.partials:
						pitchdiff = par['avg_midi'] - c.desc.get('MIDIPitch-seg')
						dbdiff = par['peak_db'] - c.db
						abspitchdiff = abs(pitchdiff)
						absdbdiff = abs(dbdiff)
						if spassobj.pitchtolerance != None and abspitchdiff > spassobj.pitchtolerance: continue
						if spassobj.pitchtolerance != None and absdbdiff > spassobj.dbtolerance: continue
						matches.append([abspitchdiff, absdbdiff, pitchdiff, dbdiff, par])
					if len(matches) > 0:
						matches.sort()
						wabspitchdiff, wabsdbdiff, wpitchdiff, wdbdiff, wpar = matches[0]
						c.partial_data = {'pobj': wpar, 'pitchdiff': wpitchdiff, 'dbdiff': wdbdiff}
						newList.append(c)
					
					
					
					
					
					
					

			###############################
			## limit descriptor by ratio ##
			###############################
			elif spassobj.method == 'ratio_limit': # uses un-normalised descriptor values
				assert len(spassobj.descriptor_list) == 1 and spassobj.descriptor_list[0].seg
				ratioDobj = spassobj.descriptor_list[0]
				newList = []
				for c in self.corpusObjs:
					denominator = float(tgtseg.desc.get(ratioDobj.name))
					if denominator == 0: denominator = 0.0001 # avoid divide by zero
					ratio = c.desc.get(ratioDobj.name)/denominator
					# so ratio=1.1 of corpus is 110% of target
					if ratio > maxd: maxd = ratio
					if ratio < mind: mind = ratio
					if spassobj.minratio != None and ratio < spassobj.minratio: continue
					if spassobj.maxratio != None and ratio > spassobj.maxratio: continue
					newList.append(c)






			########################################################
			## search segmented and timevarying feature distances ##
			########################################################		
			elif spassobj.method in ['closest', 'farthest', 'closest_percent', 'farthest_percent']:
				mind, maxd = self.getFeatureDifferences(tgtseg, tgtSeek, spassobj.descriptor_list, spassobj.method, spassobj.complete_results, superimposeObj)
				
				# clip corpus list to reflect search results and scope
				newList = self.selectFromSortedList(spassobj.method, spassobj.percent)
			
			#print (spassobj.method, spassobj.submethod, len(newList))
			if len(newList) < 1:
				self.lengthAtPassesVerbose.append( '%i -> %i (none passed)'%(len(self.corpusObjs), len(newList)) )
				return False
			### if this is the last pass
			elif lastPass: # make a random choice
				self.lengthAtPassesVerbose.append( '%i -> %i (random)'%(len(self.corpusObjs), len(newList)) )
				newList = [random.choice(newList)]
			else:
				self.lengthAtPassesVerbose.append( '%i -> %i'%(len(self.corpusObjs), len(newList)) )
			if spassobj.method == 'parser':
				self.lengthAtPassesVerbose[-1] = "%s %s"%(parseTest, self.lengthAtPassesVerbose[-1])

			self.lengthAtPasses.append('%i'%(len(newList)))
			self.corpusObjs = newList
		# done with loop
		assert len(self.corpusObjs) == 1
		self.searchResults.append( self.corpusObjs[0] )
		self.searchMinMax.append( [mind, maxd] )
		return True
	##############################
	def returnSearch(self):	
		return self.searchResults[-1]
	##############################
	def returnSearchPassText(self):	
		return self.logTextOutput
	##############################
	def getSimCalcStartAndLength(self, cpsseg, tgtseg, tgtstart, superimposeObj):
		if superimposeObj.peakAlign: # align peaks
			tgtstart += int(tgtseg.desc.get('peakTime-seg')-cpsseg.desc.get('peakTime-seg')) 
		#print("after", tgtstart, tgtseg.lengthInFrames, cpsseg.lengthInFrames, tgtseg.desc['peakTime-seg'].get(0, None), cpsseg.desc['peakTime-seg'].get(0, None))
		tgt_len = tgtseg.lengthInFrames-tgtstart
		if superimposeObj.simCalcDur == "corpusDur":	
			cps_len = cpsseg.lengthInFrames
		else:
			cps_len = cpsseg.desc.get('effDurFrames-seg')
		array_len = min(tgt_len, cps_len)
		return tgtstart, array_len
	##############################
	def getFeatureDifferences(self, tgtseg, tgtSeek, descriptor_list, spassMethod, complete_results, superimposeObj):
		min_accum = sys.maxsize
		for c in self.corpusObjs:
			#print c.filename, c.scaleDistance
			c.sim_accum = 0.
			c.sim_data = []
			tgt_start, array_len = self.getSimCalcStartAndLength(c, tgtseg, tgtSeek, superimposeObj)
			try:
				for d in descriptor_list:
					tgtvals, cpsvals = getValuesForSimCalc( tgtseg, tgt_start, array_len, c, d, superimposeObj )
					if d.seg:
						dist = ((tgtvals-cpsvals)**2)*(d.weight*c.scaleDistance)
						#print "\t", dist
						c.sim_accum += dist
						if c.sim_accum > min_accum and not complete_results: raise BreakIt
					else:
						peaks = tgtseg.desc.get('peakTime-seg'), c.desc.get('peakTime-seg')
						dist, distance_data = timeVaryingDistance(tgtvals, cpsvals, dist=d.distance, envelopeMask=c.envelopeMask, energyWeight=d.energyWeight, energies=c.desc.get('power'), peaks=peaks)
						c.sim_data.append(distance_data)
						c.sim_accum += dist*d.weight*c.scaleDistance
						if c.sim_accum > min_accum and not complete_results and spassMethod == 'closest': raise BreakIt
				if c.sim_accum < min_accum: min_accum = c.sim_accum
			except BreakIt: pass
		# sort by accum distance
		self.corpusObjs.sort(key=operator.attrgetter('sim_accum'))
		#for cidx, c in enumerate(self.corpusObjs[:1]):
		#	print(cidx, c.desc.get('centroid-seg'), tgtseg.desc.get('centroid-seg'), c.sim_accum)
		
		mind = self.corpusObjs[0].sim_accum
		maxd = self.corpusObjs[-1].sim_accum

		return mind, maxd
	##############################
	def selectFromSortedList(self, method, percent):
		if method == 'closest':
			newList = [self.corpusObjs[0]]
		elif method == 'farthest':
			newList = [self.corpusObjs[-1]]
		else:
			assert percent != None
			numb_entries = max(2, int(len(self.corpusObjs)*(percent/100.))) # two!
			if method == 'closest_percent':
				newList = self.corpusObjs[:numb_entries]
			elif method == 'farthest_percent':
				newList = self.corpusObjs[numb_entries:]
		return newList





def getValuesForSimCalc(tgtseg, tgtSeek, array_len, cpsseg, dobj, superimposeObj):
	tgtvals = tgtseg.desc.get(dobj.name, start=tgtSeek, stop=tgtSeek+array_len, norm=True)	
	if superimposeObj.calcMethod == "mixture" and dobj.is_mixable and tgtseg.has_been_mixed:
		if dobj.seg: d = dobj.parents[0]
		else:  d = dobj.name
		#############################
		## USE DESCRIPTOR MIXTURES ##
		#############################
		tgtrawvals = tgtseg.desc.get(d, start=tgtSeek, stop=tgtSeek+array_len, mixture=True)
		cpsrawvals = cpsseg.desc.get(d, stop=array_len)
		if dobj.describes_energy:
			mixedvals = tgtrawvals + cpsrawvals
		else:
			tgtrawpowers = tgtseg.desc.get('power', start=tgtSeek, stop=tgtSeek+array_len, mixture=True)
			cpsrawpowers = cpsseg.desc.get('power', stop=array_len)
			mixedpowers = (tgtrawpowers + cpsrawpowers)
			mixedvals = ((tgtrawvals*tgtrawpowers) + (cpsrawvals*cpsrawpowers)) / mixedpowers

		if dobj.seg: # segmented
			if dobj.describes_energy:
				averagedVal = np.average(mixedvals)
			else:
				try: averagedVal = np.average(mixedvals, weights=mixedpowers)
				except ZeroDivisionError: averagedVal = 0
			normedVal = cpsseg.desc.on_the_fly_data_norm(dobj.name, averagedVal)
			return tgtvals, normedVal
		else: # time-varying
			normedvals = cpsseg.desc.on_the_fly_data_norm(dobj.name, mixedvals)
			return tgtvals, normedvals
	else: # not mixed
		return tgtvals, cpsseg.desc.get(dobj.name, norm=True)	









def timeVaryingDistance(array1, array2, dist=None, envelopeMask=None, energyWeight=False, energies=None, peaks=None):
	# slices are NOT copies in numpy!!!!
	l = min([len(array1), len(array2)])
	if dist == 'euclidean': # the default
		distances = np.power((array1[0:l]-array2[0:l]), 2)
		if energyWeight: distances *= energies[0:l]
		return np.sum(distances)/float(l), None # divided by the length
	elif dist == 'pearson':
		return pearsonCorr(array1[0:l], array2[0:l])
	elif dist == 'kullback':
		return kullback(array1, array2)
	elif dist == "dtw":
		return dtwDist(array1, array2)
	elif dist.find('fixedSize') != -1: # written as fixedSize-2, fixedSize-4, etc.
		return fixedSizeDigest(array1, array2, dist, peaks) # divided by the length
	else:
		util.error('function', "unknown method for timeVaryingDistance:", dist)



def fixedSizeDigest(array1, array2, dist, peaks):
	''' after philippe esling... takes normalised continuously valued features and creates
	a interpolated fixed size version of fixedSizes[0] peak and fixedSizes[1] points'''
	userSize = int(dist.split('-')[1])
	fixedSizes = (1, userSize-1) # points pre-atk, after-atk ; additional point added for peak itself
	if peaks[0] != None and peaks[1] != None and peaks != None: # interpolate arrays according to peak times...
		lenMask = fixedSizes[0]+fixedSizes[1]+1
		interpMask1 = np.zeros(lenMask)
		interpMask2 = np.zeros(lenMask)
		interpMask1[fixedSizes[0]] = peaks[0] # assign peak time idx
		interpMask2[fixedSizes[0]] = peaks[1] # assign peak time idx
		for idx in range(fixedSizes[0]): # pre peak time
			interpMask1[idx] = peaks[0]/float(fixedSizes[0]+1)
			interpMask2[idx] = peaks[1]/float(fixedSizes[0]+1)
		for idx in range(fixedSizes[0]+1, lenMask): # post peak time
			scalarBetweenPeakAndEnd = ((idx-1)/float(fixedSizes[1]+1))
			interpMask1[idx] = scalarBetweenPeakAndEnd*(l-peaks[0])+peaks[0]
			interpMask2[idx] = scalarBetweenPeakAndEnd*(l-peaks[1])+peaks[1]
		array1Fixed = util.interpArray(array1, lenMask, interpMask=interpMask1)
		array2Fixed = util.interpArray(array2, lenMask, interpMask=interpMask2)
	else: # no peak data, flat interpolation
		lenMask = fixedSizes[0]+fixedSizes[1]+1
		array1Fixed = util.interpArray(array1, lenMask)
		array2Fixed = util.interpArray(array2, lenMask)
	distances = np.power((array1Fixed-array2Fixed), 2)
	return np.sum(distances)/float(l), None # divided by the length


def kullback(array1, array2):
	from scipy.stats import norm 
	l = len(array1)
	a1 = norm.cdf(array1[0:l])
	return (a1 * np.log2(a1/norm.cdf(array2[0:l]))).sum() / float(l), None # should i divide by length here?


def pearsonCorr(x,y):
	'''pearson correlation, return between -1,1
	-1 if inversely corrlated, 0 if no correlation
	+1 if identically correlated'''
	try:
		 from itertools import imap
	except ImportError:
		 # Python 3...
		 imap=map
	n = len(x)
	sum_x = sum(x)
	sum_y = sum(y)
	sum_x_sq = sum(map(lambda x: pow(x, 2), x))
	sum_y_sq = sum(map(lambda x: pow(x, 2), y))
	psum = sum(imap(lambda x, y: x * y, x, y))
	num = psum - (sum_x * sum_y/n)
	den = pow((sum_x_sq - pow(sum_x, 2) / n) * (sum_y_sq - pow(sum_y, 2) / n), 0.5)
	if den == 0: return 0, None
	return num / den, None



def dtwDist(x,y):
	try:
		from fastdtw import fastdtw
	except ImportError:
		util.missing_module('fastdtw')
	try:
		from scipy.spatial.distance import euclidean
	except ImportError:
		util.missing_module('scipy')
	"""Dynamic Time Warping Distance"""
	dist, path_data = fastdtw(x, y, dist=euclidean)
	#print('\n\n', path_data, '\n\n')
	return dist, path_data


	


