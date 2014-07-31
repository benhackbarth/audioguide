import sys, random, operator
import numpy as np
import metrics, sfSegment, util



#def printString(tgtTime, overlapNumber, passLengths):
#	clockTime = (6-len(str(util.trunc(ag.f2s(tgtTime), 2))))*' '+str(util.trunc(ag.f2s(tgtTime), 2))
#	firstHalfString = 'Searching: Target @ %s x %i'%(clockTime, overlapNumber+1)
#	firstHalfString += ' '*(32-len(firstHalfString))
#	if len(passLengths) == 1:
#		secondHalf = '-   Search size: '
#	else:
#		secondHalf = '-   Search pass sizes: '
#	for p in passLengths:
#		secondHalf += '%s%i'%(' '*(6-len(str(p))), p)
#	wholeString = firstHalfString+secondHalf
#	return wholeString


class BreakIt(Exception):
	pass

class distanceCalculations:
	def __init__(self, superimposeObj, SdifInterface, p):
		self.p = p
		self.searchResults = []
		self.paramScore = []
		self.segmentDensityAmpScalers = [None, None]
		if superimposeObj.minOnset != None:
			self.segmentDensityAmpScalers[0] = 1/float(superimposeObj.minOnset)
		else:
			self.segmentDensityAmpScalers[0] = 1/1.
		if superimposeObj.maxOnset != None:
			self.segmentDensityAmpScalers[0] = 1/float(superimposeObj.maxOnset)
		else:
			self.segmentDensityAmpScalers[0] = 1/8.		
	##############################
	def setCorpus(self, cpssegs):
		self.corpusObjs = cpssegs
	##############################
	def executeSearch(self, tgtseg, tgtSeek, seach_pass_objs, superimposeObj, randomizeAmpForSimSelection):	
		self.searchMinMax = []
		self.logTextOutput = ''
		passedLengths = [len(self.corpusObjs)] # start with initial size for printing
		for spidx, spassobj in enumerate(seach_pass_objs):
			mind = sys.maxint
			maxd = -1*sys.maxint
			if len(self.corpusObjs) < 1: return False
			
			if spassobj.method == 'ratio_limit': # uses un-normalised descriptor values
				###############################
				## limit descriptor by ratio ##
				###############################
				assert len(spassobj.descriptor_list) == 1 and spassobj.descriptor_list[0].seg
				ratioDobj = spassobj.descriptor_list[0]
				newList = []
				for c in self.corpusObjs:
					ratio = c.desc[ratioDobj.name].get(0, None)/float(tgtseg.desc[ratioDobj.name].get(0, None))
					# so ratio=1.1 of corpus is 110% of target
					if ratio > maxd: maxd = ratio
					if ratio < mind: mind = ratio
					#print "\t", spassobj.maxratio, ratio
					
					if spassobj.minratio != None and ratio < spassobj.minratio: continue
					if spassobj.maxratio != None and ratio > spassobj.maxratio: continue
					newList.append(c)
				self.corpusObjs.sort(key=operator.attrgetter('sim_accum'))
				self.corpusObjs = newList
				passedLengths.append(len(newList))
			else:
				########################################################
				## search segmented and timevarying feature distances ##
				########################################################		
				min_accum = sys.maxint
				for c in self.corpusObjs:
					c.sim_accum = 0.
					tgt_start, array_len = self.getSimCalcStartAndLength(c, tgtseg, tgtSeek, superimposeObj)
					try:
						for d in spassobj.descriptor_list:
							tgtvals, cpsvals = c.getValuesForSimCalc( tgtseg, tgt_start, array_len, d, superimposeObj )
							if d.seg:
								# SPECIAL EXCEPTION IF MANIPULATING POWER FOR SIMULTANEOUS LAYERING:
								if d.name == 'power-seg' and randomizeAmpForSimSelection and self.segmentDensityAmpScalers[0]!= self.segmentDensityAmpScalers[1]:
									tgtvals *= random.uniform(self.segmentDensityAmpScalers[0], self.segmentDensityAmpScalers[1])							
								dist = ((tgtvals-cpsvals)**2)*(d.weight*c.scaleDistance)
								c.sim_accum += dist
								if c.sim_accum > min_accum and not spassobj.complete_results: raise BreakIt
							else:
								peaks = tgtseg.desc['peakTime-seg'].get(0, None), c.desc['peakTime-seg'].get(0, None)
								dist = timeVaryingDistance(tgtvals, cpsvals, dist=d.distance, envelopeMask=c.envelopeMask, energyWeight=d.energyWeight, energies=c.desc['power'], peaks=peaks)
								c.sim_accum += dist*d.weight*c.scaleDistance
								if c.sim_accum > min_accum and not spassobj.complete_results: raise BreakIt
						if c.sim_accum < min_accum: min_accum = c.sim_accum
					except BreakIt: pass
				# sort by accum distance
				self.corpusObjs.sort(key=operator.attrgetter('sim_accum'))
				mind = self.corpusObjs[0].sim_accum
				maxd = self.corpusObjs[-1].sim_accum
				lastPass = spidx == len(seach_pass_objs)-1				

				# clip corpus list to reflect search results and scope
				if spassobj.method == 'closest':
					newList = [self.corpusObjs[0]]
				elif spassobj.method == 'farthest':
					newList = [self.corpusObjs[-1]]
				else:
					assert spassobj.percent != None
					numb_entries = max(2, int(len(self.corpusObjs)*(spassobj.percent/100.))) # two!
					if spassobj.method == 'closest_percent':
						newList = self.corpusObjs[:numb_entries]
					elif spassobj.method == 'farthest_percent':
						newList = self.corpusObjs[numb_entries:]
				
				### if this is the last pass
				if lastPass and len(newList) > 1: # make a random choice
					newList = [random.choice(newList)]
				self.logTextOutput += "\tdistance calc pass #%i - %s - %i -> %i ( %2.2f <-> %2.2f )\n"%(spidx+1, spassobj.method, len(self.corpusObjs), len(newList), mind, maxd)
				self.corpusObjs = newList
				
				passedLengths.append(len(newList))
		# done with loop
		print "\tsearch pass output lengths", passedLengths
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
			tgtstart += int(tgtseg.desc['peakTime-seg'].get(0, None)-cpsseg.desc['peakTime-seg'].get(0, None)) 
		tgt_len = tgtseg.lengthInFrames-tgtstart
		if superimposeObj.simCalcDur == "corpusDur":	
			cps_len = cpsseg.lengthInFrames
		else:
			cps_len = cpsseg.desc['effDur-seg'].get(0, None)
		array_len = min(tgt_len, cps_len)
		return tgtstart, array_len

















def timeVaryingDistance(array1, array2, dist=None, envelopeMask=None, energyWeight=False, energies=None, peaks=None):
	# slices are NOT copies in numpy!!!!
	l = min([len(array1), len(array2)])
	if dist == 'euclidean': # the default
		distances = np.power((array1[0:l]-array2[0:l]), 2)
		if energyWeight: distances *= energies[0:l]
		return np.sum(distances)/float(l) # divided by the length
	elif dist == 'pearson':
		return pearsonCorr(array1[0:l], array2[0:l])
	elif dist == 'kullback':
		return kullback(array1, array2)
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
		#print "#1", array1Fixed
		#print "#2", array2Fixed
	else: # no peak data, flat interpolation
		lenMask = fixedSizes[0]+fixedSizes[1]+1
		array1Fixed = util.interpArray(array1, lenMask)
		array2Fixed = util.interpArray(array2, lenMask)
	distances = np.power((array1Fixed-array2Fixed), 2)
	return np.sum(distances)/float(l) # divided by the length


def kullback(array1, array2):
	from scipy.stats import norm 
	l = len(array1)
	a1 = norm.cdf(array1[0:l])
	return (a1 * np.log2(a1/norm.cdf(array2[0:l]))).sum() / float(l) # should i divide by length here?


def pearsonCorr(x,y):
	'''pearson correlation, return between -1,1
	-1 if inversely corrlated, 0 if no correlation
	+1 if identically correlated'''
	from itertools import imap
	n = len(x)
	sum_x = sum(x)
	sum_y = sum(y)
	sum_x_sq = sum(map(lambda x: pow(x, 2), x))
	sum_y_sq = sum(map(lambda x: pow(x, 2), y))
	psum = sum(imap(lambda x, y: x * y, x, y))
	num = psum - (sum_x * sum_y/n)
	den = pow((sum_x_sq - pow(sum_x, 2) / n) * (sum_y_sq - pow(sum_y, 2) / n), 0.5)
	if den == 0: return 0
	return num / den
	


