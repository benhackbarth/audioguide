############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################
import numpy as np
np.seterr(invalid='ignore')
import sys, os
import audioguide.util as util




class expandable_matrix:
	def __init__(self):
		self.inited = False
		self.column_dnames = []
		self.column_data = []
		
	def has_column(self, dname):
		return dname in self.column_dnames

	def get_columns(self, dnames, rowslice=None):
		'''returns a copy of the matrix with specificed named columns'''
		try:
			if len(dnames) == 1: cols = self.column_dnames.index(dnames[0])
			else: cols = [self.column_dnames.index(d) for d in dnames]
		except ValueError: 
			print("descriptordata ERROR: No known descriptor", dnames)
			sys.exit(1)
		if rowslice == None: return self.matrix[:, cols]
		else: return self.matrix[rowslice, cols]

	def add_columns(self, values, dnames):
		# reshape array to make 2D
		if values.ndim == 1: values = values.reshape(values.shape[0],-1)
		if not self.inited:
			self.matrix = values
			self.inited = True
		else:
			self.matrix = np.append(self.matrix, values, axis=1)
		self.column_dnames.extend(dnames)
		self.column_data.extend([{'dname': dname, 'need_recalc': False, 'dtype': 1 } for dname in dnames])

	def calculate_new_column(self, dname, type, parentname):
		newdata = TimevaryingDescriptorComputation(self.get_columns([parentname]), dname, type)
		self.add_columns(newdata, [dname])

	def recalculate_column(self, dname, type, parentname):
		# for subtraction
		newdata = TimevaryingDescriptorComputation(self.get_columns([parentname]), dname, type)
		self.matrix[:, self.column_dnames.index(dname)] = newdata



singleNumberDescriptors = ['effDur-seg', 'effDurFrames-seg', 'peakTime-seg', 'MIDIPitch-seg', 'percentInFile-seg', 'temporalIncrease-seg', 'temporalDecrease-seg', 'logAttackTime-seg', 'temporalCentroid-seg']
descriptIsAmp = ["power", "spectralpower", "noiseenergy", "loudness", "harmonicenergy", "energyenvelope"]
descriptNotMixable = ["f0", "zeroCross", "effDur-seg"]


def descriptor_string_parse(dname):
	global singleNumberDescriptors, descriptIsAmp, descriptNotMixable
	if dname.find('-slope-seg') != -1: type, seg = 'slope-regression', True
	elif dname.find('-minseg') != -1: type, seg = 'min', True
	elif dname.find('-maxseg') != -1: type, seg = 'max', True
	elif dname.find('-meanseg') != -1: type, seg = 'mean', True
	elif dname.find('-stdseg') != -1: type, seg = 'std', True
	elif dname.find('-skewseg') != -1: type, seg = 'skew', True
	elif dname.find('-kurtseg') != -1: type, seg = 'kurt', True
	elif dname.find('-seg') != -1: type, seg = 'segmented', True
	elif dname.find('-odf-') != -1: type, seg = 'onsetdetection', False
	elif dname.find('-deltadelta') != -1: type, seg = 'deltadelta', False
	elif dname.find('-delta') != -1: type, seg = 'delta', False
	else: type, seg = 'raw', False
	if seg and type == 'slope-regression': seg_method = 'slope'
	elif seg and type == 'mean': seg_method = 'mean'
	elif seg and type == 'min': seg_method = 'min'
	elif seg and type == 'max': seg_method = 'max'
	elif seg and type == 'std': seg_method = 'std'
	elif seg and type == 'skew': seg_method = 'skew'
	elif seg and type == 'kurt': seg_method = 'kurt'
	elif seg and dname in ["power-seg", "rms-seg"]: seg_method = 'max'
	elif seg and dname in singleNumberDescriptors: seg_method = 'single_number'
	elif seg: seg_method = 'weighted_mean'
	else: seg_method = None
	# get the "parent descriptors" which this descriptor depend upon
	dnamesplit = dname.split('-')
	parent = None
	if dname not in singleNumberDescriptors and len(dnamesplit) > 1: parent = dnamesplit[0]
	return {'type': type, 'isseg': seg, 'seg_method': seg_method, 'parent': parent, 'describes_energy': dname in descriptIsAmp or parent in descriptIsAmp, 'is_mixable': dname not in descriptNotMixable}






class descriptor_manager:
	def __init__(self):
		self.descriptor_string_to_params = {}
		self.sffile2matrix = {}
	########################################
	def descriptor_string_digest(self, dname):
		if dname not in self.descriptor_string_to_params: self.descriptor_string_to_params[dname] = descriptor_string_parse(dname)
		return self.descriptor_string_to_params[dname]
	########################################
	def normalize(self, segment_objs, dobj_list):
		self.norm_timevarying_matrix = expandable_matrix()
		# make a list of all desc objects in order by tag...
		self.desc_objs = [o.desc for o in segment_objs]
		self.desc_objs.sort(key=lambda x: x.tag)
		self.desc_obj_tags = [o.tag for o in self.desc_objs]
		self.norm_tags = list(set(self.desc_obj_tags))
		self.norm_tags.sort() # make sure they are ordered!
		self.norm_coeff_tag_dict = {t: {} for t in self.norm_tags}
		self.tv_length = sum([o.get('effDurFrames-seg') for o in self.desc_objs])
		self.seg_length = len(self.desc_objs)
		# find tag change idxes
		tag_change_seg_indxs = list(np.where(np.roll(self.desc_obj_tags, 1) != self.desc_obj_tags)[0])
		cnt = 0
		tag_change_tv_indxs = []
		for idx, o in enumerate(self.desc_objs):
			o.efflen = o.get('effDurFrames-seg')
			if idx in tag_change_seg_indxs: tag_change_tv_indxs.append(cnt)
			cnt += o.efflen
		tag_change_seg_indxs.append(self.seg_length)
		tag_change_tv_indxs.append(self.tv_length)
		# make tag to slice dict
		self.norm_segtag_to_slice = {}
		self.norm_tvtag_to_slice = {}
		for idx, tag in enumerate(self.norm_tags):	
			self.norm_segtag_to_slice[tag] = slice(tag_change_seg_indxs[idx], tag_change_seg_indxs[idx+1])
			self.norm_tvtag_to_slice[tag] = slice(tag_change_tv_indxs[idx], tag_change_tv_indxs[idx+1])
		seg_list = [dobj for dobj in dobj_list if dobj.seg]
		# get seg data coeffs
		for didx, dobj in enumerate(seg_list):
			column = np.array([o.get(dobj.name) for o in self.desc_objs])
			# get norm coeffs
			if dobj.norm == 1: # normalize all data together
				coeffs = self._normalize_coeffs(dobj.name, column, dobj.normmethod)
				for tag in self.norm_tags: self.norm_coeff_tag_dict[tag][dobj.name] = coeffs
			elif dobj.norm == 2: # normalize data separately
				for tag in self.norm_tags: self.norm_coeff_tag_dict[tag][dobj.name] = self._normalize_coeffs(dobj.name, column[self.norm_segtag_to_slice[tag]], dobj.normmethod)
		# get tv data coeffs and make a matrix
		tv_list = [dobj for dobj in dobj_list if not dobj.seg]
		for didx, dobj in enumerate(tv_list):
			dparams = self.descriptor_string_digest(dobj.name)
			# build column
			column = np.empty(self.tv_length)
			cnt = 0
			for o in self.desc_objs:
				m, s, e = o.get_matrix_location(dobj.name, dparams, 0, o.efflen)
				column[cnt:cnt+o.efflen] = m.get_columns([dobj.name], rowslice=slice(s, e))
				o.norm_start = cnt
				cnt += o.efflen
				o.norm_end = cnt
			if dobj.norm == 1: # normalize all data together
				coeffdict = self._normalize_coeffs(dobj.name, column, dobj.normmethod)
				column = self.normalize_data(column, coeffdict)
				for tag in self.norm_tags: self.norm_coeff_tag_dict[tag][dobj.name] = coeffdict
			elif dobj.norm == 2: # normalize data separately
				for tag in self.norm_tags:
					self.norm_coeff_tag_dict[tag][dobj.name] = self._normalize_coeffs(dobj.name, column[self.norm_tvtag_to_slice[tag]], dobj.normmethod)
					column[self.norm_tvtag_to_slice[tag]] = self.normalize_data(column[self.norm_tvtag_to_slice[tag]], self.norm_coeff_tag_dict[tag][dobj.name])
			self.norm_timevarying_matrix.add_columns(column, [dobj.name])
	########################################
	def _normalize_coeffs(self, dname, dataarray, dnormmethod, std_degree_of_freedom=0.):
		if dnormmethod == 'stddev':
			return {'method': dnormmethod, 'mean': np.mean(dataarray), 'std': np.std(dataarray, ddof=std_degree_of_freedom)}
		elif dnormmethod == 'minmax':
			m = np.min(dataarray)
			return {'method': dnormmethod, 'min': m, 'range': np.max(dataarray)-m}
		elif dnormmethod == 'sigmoid':
			m = np.max(dataarray)
			return {'method': dnormmethod, 'max': m}
	########################################
	def normalize_data(self, dataarray, coeffDict):
		if coeffDict['method'] == 'stddev':
			return (dataarray-coeffDict['mean'])/coeffDict['std']
		elif coeffDict['method'] == 'minmax':
			return (dataarray-coeffDict['min'])/coeffDict['range']
		elif coeffDict['method'] == 'sigmoid':
			return 1/(1+np.exp(-dataarray/coeffDict['max']))
	########################################
	def create_sf_descriptor_obj(self, sfseghandle, rawmatrix, startframe_in_matrix, length_in_matrix, tag=None, envelope=None):
		'''this function gets a new class sf_segment_descriptors and links it to the overlord'''
		if sfseghandle.filename not in self.sffile2matrix:
			self.sffile2matrix[sfseghandle.filename] = expandable_matrix()
			self.sffile2matrix[sfseghandle.filename].add_columns(rawmatrix, ['power', 'chroma0', 'chroma1', 'chroma2', 'chroma3', 'chroma4', 'chroma5', 'chroma6', 'chroma7', 'chroma8', 'chroma9', 'chroma10', 'chroma11', 'f0', 'harmonicenergy', 'harmonicoddevenratio', 'harmoniccentroid', 'harmonicdecrease', 'harmonicdeviation', 'harmonickurtosis', 'harmonicrolloff', 'harmonicskewness', 'harmonicslope', 'harmonicspread', 'harmonicvariation', 'inharmonicity', 'loudness', 'noiseenergy', 'noisiness', 'perceptualoddtoevenratio', 'perceptualcentroid', 'perceptualdecrease', 'perceptualdeviation', 'perceptualkurtosis', 'perceptualrolloff', 'perceptualskewness', 'perceptualslope', 'perceptualspread', 'perceptualvariation', 'sharpness', 'zeroCross', 'centroid', 'crest0', 'crest1', 'crest2', 'crest3', 'decrease', 'flatness0', 'flatness1', 'flatness2', 'flatness3', 'kurtosis', 'rolloff', 'skewness', 'slope', 'spectralspread', 'variation', 'spread', 'spectralpower', 'mfcc0', 'mfcc1', 'mfcc2', 'mfcc3', 'mfcc4', 'mfcc5', 'mfcc6', 'mfcc7', 'mfcc8', 'mfcc9', 'mfcc10', 'mfcc11', 'mfcc12'])
		return self.sf_segment_descriptors(self, sfseghandle, startframe_in_matrix, length_in_matrix, tag=tag, envelope=envelope)
	########################################
	########################################
	class sf_segment_descriptors:
		#####################################	
		def __init__(self, overlord, sfseghandle, startframe_in_matrix, length_in_matrix, tag=None, envelope=None):
			self.overlord = overlord
			self.sfseghandle = sfseghandle
			self.start = startframe_in_matrix
			self.len = length_in_matrix
			self.end = self.start + self.len
			self.tag = tag
			self.envelope = envelope
			self.has_envelope = self.envelope is not None
			self.segmented_dataspace = {} # averaged descriptors unique to this segment
			self.rewind()
		#####################################	
		def rewind(self):
			# resets internal data spaces for a new concatenation
			self.private_energy_descriptors = expandable_matrix()
			self.segmented_norm_dataspace = {} # averaged descriptors unique to this segment
		#####################################	
		def get_matrix_location(self, dname, dparams, start, stop, norm=False, mixture=False):
			# there are three possible arrays that we may need to access to get timevarying descriptor values
			#		1. the main, raw descriptor array loaded from disk. these descriptors are unnormalized, and the array is shared between multiple instances of sf_segment_descriptors()
			#		2. the main normalized descriptor array. self.overlord.norm_timevarying_matrix, also shared among objects. this is one long array regardless of obj file origins
			#		3. this obj's private_energy_descriptors, which are not shared. this is for things like envelopped descriptors which describe energy and may differ for sf segments sharing the same frames
			if stop == None: length = self.len
			else: length = stop-start
			if norm:
				st = "norm matrix"
				mat = self.overlord.norm_timevarying_matrix
				idx = self.norm_start
				length = min(length, self.efflen)
			elif mixture:
				st = "mixture matrix"
				mat = self.private_mixture_descriptors
				idx = start
			elif dparams['describes_energy'] and self.has_envelope:
				st = "private matrix"
				mat = self.private_energy_descriptors
				idx = start
				if not mat.has_column(dname):
					# check to see if mat has the parent column...
					# if so, the envelope is already applied
					if mat.has_column(dparams['parent']):
						mat.calculate_new_column(dname, dparams['type'], dparams['parent'])
					else:
						# otherwise we need to read from the raw matrix and apply the envelope
						pmat = self.overlord.sffile2matrix[self.sfseghandle.filename]
						if not pmat.has_column(dname):
							pmat.calculate_new_column(dname, dparams['type'], dparams['parent'])
						energydesc = pmat.get_columns([dname], rowslice=slice(self.start, self.end))
						#if self.tag == 'tgt': print("TGT NEW COLUMN get_matrix_location", self.sfseghandle.idx, dname, energydesc)
						#if self.tag == 'cps':
						#	print(self.start, self.end, self.end-self.start, len(np.array(energydesc, copy=True)),  len(self.envelope), [dname])
						mat.add_columns(np.array(energydesc, copy=True) * self.envelope, [dname])
			else:
				st = "raw matrix"
				mat = self.overlord.sffile2matrix[self.sfseghandle.filename]
				if not mat.has_column(dname):
					if dparams['parent'] == None:
						print("\nDescriptordata Error: No known descriptor", dname, "\n\n")
						sys.exit(1)
					# on demand calculation of new columns - delta, deltadelta, odf
					mat.calculate_new_column(dname, dparams['type'], dparams['parent'])
				idx = start + self.start
			return mat, idx, idx+length
		#####################################	
		def get(self, dname, start=0, stop=None, norm=False, mixture=False, copy=False):
			'''the user calls this when they want desriptor data. normalization
			and internal concatenation calculations are done with other funcitons'''
			dparams = self.overlord.descriptor_string_digest(dname)
			if dparams['isseg']:
				k = (start, stop)
				if dname not in self.segmented_dataspace: self.segmented_dataspace[dname] = {}
				if k not in self.segmented_dataspace[dname]:
					self.segmented_dataspace[dname][k] = SegmentedDescriptorComputation(self, dname, dparams, self.sfseghandle, start, stop)
				if not norm:
					return self.segmented_dataspace[dname][k]
				else: 
					if dname not in self.segmented_norm_dataspace: self.segmented_norm_dataspace[dname] = {}
					if k not in self.segmented_norm_dataspace[dname]:
						self.segmented_norm_dataspace[dname][k] = self.overlord.normalize_data(self.segmented_dataspace[dname][k], self.overlord.norm_coeff_tag_dict[self.tag][dname])			
					return self.segmented_norm_dataspace[dname][k]
			# otherwise this is time varying
			matrix_pointer, start_array, stop_array = self.get_matrix_location(dname, dparams, start, stop, norm=norm, mixture=mixture)
			output = matrix_pointer.get_columns([dname], rowslice=slice(start_array, stop_array))
			if copy: output = np.array(output, copy=True)
			return output
		#####################################	
		def on_the_fly_data_norm(self, dname, dataValueOrArray):
			return self.overlord.normalize_data(dataValueOrArray, self.overlord.norm_coeff_tag_dict[self.tag][dname])
		#####################################	
		def _edit_tv_data(self, dname, dataarray, minLen, start=0, norm=False, mixture=False):
			dparams = self.overlord.descriptor_string_digest(dname)
			mat, st, ed = self.get_matrix_location(dname, dparams, start, start+minLen, norm=norm, mixture=mixture)
			mat.matrix[st:ed,mat.column_dnames.index(dname)] = dataarray
		#####################################	
		def init_mixture(self, descriptorList):
			'''initalize a mixture space for this segment'''
			self.private_mixture_descriptors = expandable_matrix()
			tv_list = []
			for d in descriptorList:
				dparams = self.overlord.descriptor_string_digest(d.name)
				if dparams['isseg']: continue
				tv_list.append(d.name)
			self.private_mixture_descriptors.add_columns(np.zeros((self.len, len(tv_list))), tv_list)
		#####################################	
		def mixture_subtract(self, cpsseg, ampscale, minLen, verbose=True):
			tgtseg = self.sfseghandle
			preSubtractPeak = util.ampToDb(np.max(self.get('power', start=tgtseg.seek, stop=tgtseg.seek+minLen)))
			rawSubtraction = tgtseg.desc.get('power', start=tgtseg.seek, stop=tgtseg.seek+minLen)-(cpsseg.desc.get('power', stop=minLen)*ampscale)
			rawSubtraction = np.clip(rawSubtraction, 0, None)
			postSubtractPeak = util.ampToDb(np.max(rawSubtraction))
			
			self._edit_tv_data('power', rawSubtraction, minLen, start=tgtseg.seek, norm=False, mixture=False)
			for d in self.private_energy_descriptors.column_dnames:
				if d == 'power': continue
				dparams = self.overlord.descriptor_string_digest(d)
				self.private_energy_descriptors.recalculate_column(d, dparams['type'], dparams['parent'])

			# clear segmentation dicts
			self.segmented_dataspace.clear()
			self.segmented_norm_dataspace.clear()
		#####################################	
		def mixture_mix(self, cpsseg, ampscale, minLen, descriptors, verbose=True):
			mix_dur = min(self.len-self.sfseghandle.seek, cpsseg.lengthInFrames)
			tgtseek = self.sfseghandle.seek
			for d in descriptors:
				dparams = self.overlord.descriptor_string_digest(d.name)
				if dparams['isseg']:
					continue
				tgtvalues = self.get(d.name, mixture=True, start=tgtseek, stop=tgtseek+mix_dur)
				cpsvalues = cpsseg.desc.get(d.name, stop=mix_dur)
				if dparams['describes_energy']:
					mixture = tgtvalues + cpsvalues	# simple sum
				else:	
					tgtpowers = self.get('power', mixture=True, start=tgtseek, stop=tgtseek+mix_dur)
					cpspowers = cpsseg.desc.get('power', stop=mix_dur)
					mixture = ((tgtvalues*tgtpowers)+(cpsvalues*cpspowers))/(tgtpowers + cpspowers)	# weighted average
					mixture = ((tgtvalues*tgtpowers)+(cpsvalues*cpspowers))/(tgtpowers + cpspowers)	
				#if dparams['describes_energy']:
				#	print("ENERGY", self.sfseghandle.seek)
				self._edit_tv_data(d.name, mixture, mix_dur, start=tgtseek, mixture=True)
		#####################################	
		def getdict(self, dobjlist):
			return {d.name: list(self.get(d.name)) if not d.seg else self.get(d.name) for d in dobjlist}
		#####################################	
		def writedict(self, outputfile, AnalInterface):
			dicty = self.getdict(AnalInterface.allDescriptors)
			descriptorData['f2s'] = AnalInterface.f2s(1)
			fh = open(outputfile, 'w')
			json.dump(descriptorData, fh)
			fh.close()










def SegmentedDescriptorComputation(sfdescobj, dname, dparams, handle, start, end):
	# SINGLE-NUMBER METHODS
	if dname == "dur-seg": # raw segment duration
		output = handle.lengthInFrames
	elif dname == "effDur-seg": # perceived segment duration in seconds
		output = effectiveDur(handle, start) * handle.f2s
	elif dname == "effDurFrames-seg": # perceived segment duration in frames
		output = effectiveDur(handle, start)
	elif dname == "MIDIPitch-seg":
		output = handle.midipitch
	elif dname == "peakTime-seg":
		output = peakTimeSeg(sfdescobj.get('power', start=start, stop=end))
	elif dname == "logAttackTime-seg":
		output = logAttackTime(sfdescobj.get('power', start=start, stop=end))
	elif dname == "percentInFile-seg":
		output = percentInFile(handle, start, end)
	elif dname == "f0-seg":
		output = f0Seg(handle.desc.get('f0', start=start, stop=end), sfdescobj.get('power', start=start, stop=end))
	# FLAT MEAN - NOT ENERGY WEIGHTED
	elif dparams['type']  == 'mean':
		output = np.average(sfdescobj.get(dparams['parent'], start=start, stop=end))
	# SEGMENT-AVERAGE METHODS
	elif dparams['type']  == 'min':
		output = np.min(sfdescobj.get(dparams['parent'], start=start, stop=end))
	elif dparams['seg_method']  == 'max':
		output = np.max(sfdescobj.get(dparams['parent'], start=start, stop=end))
	elif dparams['seg_method']  == 'std': 
		output = np.std(sfdescobj.get(dparams['parent'], start=start, stop=end))
	# STATISTICS
	elif dparams['type'] == 'slope-regression':
		output = descriptorSlope(handle, dparams['parent'], start)
	elif dparams['type'] == 'skew':
		try:
			from scipy.stats import skew
		except ImportError:
			print(ImportError, "scipy package needs to be installed to compute skewness.")
		output = skew(sfdescobj.get(dparams['parent'], start=start, stop=end))
	elif dparams['type'] == 'kurt':
		try:
			from scipy.stats import kurtosis
		except ImportError:
			print(ImportError, "scipy package needs to be installed to compute kurtosis.")
		output = kurtosis(sfdescobj.get(dparams['parent'], start=start, stop=end))
		
	else: # 'weighted_mean'
		try:
			#if dname == 'mfcc1-seg':
			#	print(dname, dparams)
			output = np.average(sfdescobj.get(dparams['parent'], start=start, stop=end), weights=sfdescobj.get('power', start=start, stop=end))
		except ZeroDivisionError: # in case all powers are zero
			output = np.average(sfdescobj.get(dparams['parent'], start=start, stop=end))
	return output



def TimevaryingDescriptorComputation(origdata, dname, type):
	if type == 'delta':
		newdata = np.diff(origdata)
		newdata = np.insert(newdata, -1, newdata[-1])
	elif type == 'deltadelta':
		newdata = np.diff(origdata)
		newdata = np.diff(newdata)
		newdata = np.insert(newdata, -1, newdata[-1])
		newdata = np.insert(newdata, -1, newdata[-1])
	elif type == 'onsetdetection':
		numberAvg = int(dname.split('-')[2])
		newdata = odf(origdata, numberAvg)
	else:
		print("ERROR TimevaryingDescriptorComputation: No known type", type, dname, origdata)
		sys.exit(1)
	return newdata



def soundSegmentClassification(descriptors, segObjs, numbClasses=4):
	try:
		from sklearn.cluster import KMeans
		from sklearn.preprocessing import StandardScaler
	except ImportError:
		print("To run sound segment classification, you need to install sklearn.  Run the command 'pip install -U scikit-learn'")
		return
	data = buildFeatureArray(segObjs, descriptors)
	scaler = StandardScaler()
	scaler.fit(data)
	scaleddata = scaler.transform(data)
	kmeans = KMeans(n_clusters=numbClasses)
	kmeans.fit(scaleddata)
	y_km = kmeans.fit_predict(data)
	return y_km





def buildFeatureArray(segmentObjList, featureList):
	data = np.empty( (len(segmentObjList), len(featureList)) )
	for sidx, seg in enumerate(segmentObjList):
		for didx, d in enumerate(featureList):
			data[sidx][didx] = seg.desc.get(d)
	return data



def odf(powers, numberaverage):
	# with Norbert Schnell
	# 	an averaged delta function
	matrixe = np.zeros((numberaverage, len(powers))) # matrix of length x number average
	for frame in range(len(powers)):
		for i in range(1, numberaverage+1):
			if frame-i >= 0: matrixe[i-1][frame] = powers[frame-i] # fill it
	medians = np.median(matrixe, axis=0)
	newdata = powers-medians
	return newdata



def peakTimeSeg(powers):
	return np.argmax(powers)+0.5 # the middle of the peak window, reduces error to +/-0.5



def logAttackTime(powers):
	idx = np.argmax(powers)
	time = np.clip(ag.f2s(idx), 0.0001, sys.maxsize)
	return np.log(time) # the middle of the peak window, reduces error to +/-0.5



def f0Seg(f0s, powers):
	tmp = []
	for vidx, f0 in enumerate(f0s):
		if f0 == 0: continue # 0 means yin has no results
		tmp.append(f0)
	if len(tmp) == 0: return 0. # 0 means f0 didn't find an estimate!
	return np.median(tmp)



def f0SegV2(f0s, inharmonicities, powers, minAbsDb=-60, minRelDb=-16, inharmThreshold=0.1):
	tmp = []
	minRelDb = util.ampToDb(np.max(powers))+minRelDb
	for vidx, f0 in enumerate(f0s):
		if f0 == 0: continue # 0 means yin has no results
		if powers[vidx] < util.dbToAmp(minAbsDb): continue # too soft abs amp
		if powers[vidx] < minRelDb: continue # too soft rel amp
		if inharmonicities[vidx] > inharmThreshold: continue
		tmp.append((powers[vidx], f0, inharmonicities[vidx]))
			#print "nope", f0, inharmonicities[vidx]
		#	continue
		#print "YES", f0, inharmonicities[vidx]
		#tmp.append(f0)
	#sys.exit()
	tmp.sort(reverse=True)
	if len(tmp) == 0: return 0. # 0 means f0 didn't find an estimate!
	return np.median([f0 for power, f0, inharm in tmp[0:3]])


def descriptorSlope(handle, descriptName, start, NORMALIZE_FOR_DURATION=True):
	# with Norbert Schnell
	if start == None: effStart = 0
	else: effStart = start
	effDur = handle.desc.get('effDurFrames-seg', start=effStart)
	descript = handle.desc.get(descriptName, start=effStart, stop=effStart+effDur)
	start = int((len(descript))*0.2) # only take descriptor from %20-%80 
	end = int((len(descript))*0.8)
	values = np.array(descript[start:end])
	if len(values) < 2: return 0.
	if NORMALIZE_FOR_DURATION: cmpLine = np.linspace(0, 1, num=len(values))
	else: cmpLine = np.linspace(0, len(values), num=len(values))
	return np.polyfit(cmpLine, values, 1)[0]


def MIDIPitchByFileName(name, midiPitchMethod, handle, notfound=-1):
	# midiPitchMethod == 'filename' || int/float || f0-seg || centroid-seg
	if midiPitchMethod == 'filename':
		fileHead = os.path.splitext(os.path.split(name)[1])[0]
		test = getMidiPitchFromString(fileHead)
		if test != False: return test
		else: return notfound
	elif midiPitchMethod == 'composite':
		test = getMidiPitchFromString( os.path.splitext(os.path.split(name)[1])[0] )
		if test != False: return test
		else: return MIDIPitchByFileName(name, 'f0-seg', handle)
	elif midiPitchMethod == 'centroid-seg':
		return util.frq2Midi(handle.desc.get('centroid-seg'))
	elif midiPitchMethod == 'f0-seg':
		f0 = handle.desc.get('f0-seg')
		if f0 != 0:
			return util.frq2Midi(f0)
		else:
			return notfound


def evaluate_midipitches(segmentobjlist, config, notfound=-1):	
	if config in ['filename', 'composite', 'centroid-seg', 'f0-seg']:
		output_pitch_list = [MIDIPitchByFileName(obj.printName, config, obj, notfound=-1) for obj in segmentobjlist]
	
	elif type(config) in [float, int]: # pitchoverride=60
		output_pitch_list = [config for obj in segmentobjlist]
	
	elif type(config) != dict:
		util.error("SF SEGMENTS", 'midiPitchMethod must either be a string, a number, or a dictionary.')

	elif 'type' not in config:
		util.error("SF SEGMENTS", "a midiPitchMethod dictionary needs the key 'type'.")

	elif config['type'] == 'remap': # {'type': 'remap', 'method': 'centroid-seg', 'high': 80, 'low': 76}
		assert 'low' in config and 'high' in config and 'method' in config
		pitchlist = np.array([MIDIPitchByFileName(obj.printName, config['method'], obj, notfound=-1) for obj in segmentobjlist])
		minpitch, maxpitch = min(pitchlist), max(pitchlist)
		output_pitch_list = (((pitchlist-minpitch)/(maxpitch-minpitch))*(config['high']-config['low']))+config['low']
	# clip
#	elif config['type'] == 'clip':
#		assert 'low' in config or 'high' in config
#		if 'low' in config and standardpitch < config['low']: output_dict[c] = config['low']
#		elif 'high' in config and standardpitch > config['high']: output_dict[c] = config['high']
#		else: output_dict[c] = standardpitch
#	# filename string match
#	elif config['type'] == 'file_match':
#		for k in config:
#			if k == 'type': continue
#			if util.matchString(c.printName, k, caseSensative=True):
#				output_dict[c] = config[k]
#		# not found
#		output_dict[c] = standardpitch
	else:
		util.error("INSTRUMENTS", 'Ya done goofed son.')
	for o, p in zip(segmentobjlist, output_pitch_list): o.midipitch = p




FILENAME_PITCH_DICT = {} # save string results here so it doesn't have to reevaulate..
def getMidiPitchFromString(string):
	import os, re
	global FILENAME_PITCH_DICT
	if string in FILENAME_PITCH_DICT: return FILENAME_PITCH_DICT[string]
	pitchDict = {"c": 0,"cs": 1,"db": 1,"d": 2,"ds": 3,"eb": 3,"e": 4, 'fb': 4, "es": 5, "f": 5,"fs": 6,"gb": 6,"g": 7,"gs": 8,"ab": 8,"a": 9,"as": 10,"bb": 10, "b": 11, 'cb': 11}
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






def getDynamicFromFilename(file, dynToDbDict, stringToDynDict, notFound=-1000):
	SPLIT_STRINGS = ['-', '_', '.', '|']
	NOTHING_YET = True
	whichStr = 0
	searchstring = os.path.split(os.path.splitext(file)[0])[1]
	dynamic = 'fuck'
	while NOTHING_YET:
		if whichStr > len(SPLIT_STRINGS)-1:
			break
		splitStr = SPLIT_STRINGS[whichStr]
		strings = searchstring.split(splitStr)
		strings.reverse() # they tend to be at the end of the file
		for s in strings:
			if s in stringToDynDict:
				dynamic = s
				NOTHING_YET = False
				break
		whichStr += 1
	if dynamic == 'fuck':
		return notFound, None
	else:
		return dynToDbDict[dynamic], dynamic



def percentInFile(handle, start, end):
	return (handle.segmentStartSec/handle.soundfileTotalDuration)*100.

def effectiveDur(handle, time, absThreshScalar=-60):
	# RETURN SEGMENT LENGTH IN FRAMES
	counter = handle.lengthInFrames-1
	while True: # count from the end
		if util.ampToDb(handle.desc.get('power')[counter]) > absThreshScalar: break
		counter -= 1
		if counter < 0: return handle.lengthInFrames
	return counter+1

def hannWin(size):
	n = np.arange(size)
	w = 0.5*(1.0-np.cos(2*np.pi*n/(float(size-1))))
	return w

