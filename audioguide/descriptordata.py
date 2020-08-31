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
		if len(dnames) == 1: cols = self.column_dnames.index(dnames[0])
		else: cols = [self.column_dnames.index(d) for d in dnames]
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







class descriptor_manager:
	def __init__(self):
		self.norm_timevarying_matrix = expandable_matrix()
		self.norm_segmented_tag_dict = {}
		self.descriptor_string_to_params = {}
		self.sffile2matrix = {}
		self.singleNumberDescriptors = ['effDur-seg', 'effDurFrames-seg', 'peakTime-seg', 'MIDIPitch-seg', 'percentInFile-seg', 'temporalIncrease-seg', 'temporalDecrease-seg', 'logAttackTime-seg', 'temporalCentroid-seg']
		self.descriptIsAmp = ["power", "spectralpower", "noiseenergy", "loudness", "harmonicenergy", "energyenvelope"]
		self.descriptNotMixable = ["f0", "zeroCross", "effDur-seg"]
	########################################
	def descriptor_string_digest(self, dname):
		if dname not in self.descriptor_string_to_params:
			if dname.find('-slope-seg') != -1: type, seg = 'slope-regression', True
			elif dname.find('-mean-seg') != -1: type, seg = 'mean', True
			elif dname.find('-seg') != -1: type, seg = 'segmented', True
			elif dname.find('-odf-') != -1: type, seg = 'onsetdetection', False
			elif dname.find('-deltadelta') != -1: type, seg = 'deltadelta', False
			elif dname.find('-delta') != -1: type, seg = 'delta', False
			else: type, seg = 'raw', False
			if seg and type == 'slope-regression': seg_method = 'slope'
			elif seg and type == 'mean': seg_method = 'mean'
			elif seg and dname in ["power-seg", "rms-seg"]: seg_method = 'max'
			elif seg and dname in self.singleNumberDescriptors: seg_method = 'single_number'
			elif seg: seg_method = 'weighted_mean'
			else: seg_method = None
			# get the "parent descriptors" which this descriptor depend upon
			dnamesplit = dname.split('-')
			parent = None
			if dname not in self.singleNumberDescriptors and len(dnamesplit) > 1: parent = dnamesplit[0]
			self.descriptor_string_to_params[dname] = {'type': type, 'isseg': seg, 'seg_method': seg_method, 'parent': parent, 'describes_energy': dname in self.descriptIsAmp or parent in self.descriptIsAmp, 'is_mixable': dname not in self.descriptNotMixable}
		return self.descriptor_string_to_params[dname]
	########################################
	def normalize_setup(self, segment_objs):
		self.norm_objs = [o.desc for o in segment_objs]
		self.norm_tags = list(set([o.tag for o in self.norm_objs]))
		for t in self.norm_tags:
			if t not in self.norm_segmented_tag_dict: self.norm_segmented_tag_dict[t] = {} 
		self.tv_length = sum([o.len for o in self.norm_objs])
		self.seg_length = len(self.norm_objs)
		# make masks by tag
		norm_obj_seg_tags = np.array([o.tag for o in self.norm_objs], dtype=object)
		norm_obj_tv_tags = []
		for o in self.norm_objs: norm_obj_tv_tags.extend([o.tag]*o.len)
		norm_obj_tv_tags = np.array(norm_obj_tv_tags, dtype=object)
		self.tagmasks = {}
		for t in self.norm_tags: self.tagmasks[t] = {'tv': norm_obj_tv_tags == t, 'seg': norm_obj_seg_tags == t}
	########################################
	def _normalize_coeffs(self, dataarray, dnormmethod):
		if dnormmethod == 'stddev':
			return {'method': dnormmethod, 'mean': np.mean(dataarray), 'std': np.std(dataarray)}
		elif dnormmethod == 'minmax':
			m = np.min(dataarray)
			return {'method': dnormmethod, 'min': m, 'range': np.max(dataarray)-m}
	########################################
	def normalize_data(self, dataarray, coeffDict):
		if coeffDict['method'] == 'stddev':
			return (dataarray-coeffDict['mean'])/coeffDict['std']
		elif coeffDict['method'] == 'minmax':
			return (dataarray-coeffDict['min'])/coeffDict['range']
	########################################
	def normalize_descriptor(self, dname, dnormmethod, dnorm):
		dparams = self.descriptor_string_digest(dname)
		if dparams['isseg']:
			column = np.array([o.get(dname) for o in self.norm_objs])
			if dnorm == 1: # normalize all data together
				for tag in self.norm_tags: self.norm_segmented_tag_dict[tag][dname] = self._normalize_coeffs(column, dnormmethod)
			elif dnorm == 2: # normalize data separately
				columnmasked = np.ma.masked_array(column, mask=self.tagmasks[self.norm_tags[0]]['seg'])
				for tag in self.norm_tags:
					columnmasked.mask = self.tagmasks[tag]['seg']
					self.norm_segmented_tag_dict[tag][dname] = self._normalize_coeffs(columnmasked, dnormmethod)
		else:
			column = np.empty(self.tv_length)
			cnt = 0
			for o in self.norm_objs:
				m, s, e = o.get_matrix_location(dname, dparams, 0, None, norm=False)
				column[cnt:cnt+o.len] = m.get_columns([dname], rowslice=slice(s, e))
				o.norm_start = cnt
				o.norm_end = cnt + o.len
				cnt += o.len
			if dnorm == 1: # normalize all data together
				coeffdict = self._normalize_coeffs(column, dnormmethod)
				column = self.normalize_data(column, coeffdict)
			elif dnorm == 2: # normalize data separately
				columnmasked = np.ma.masked_array(column, mask=self.tagmasks[self.norm_tags[0]]['tv'])
				for t in self.norm_tags:
					columnmasked.mask = self.tagmasks[t]['tv']
					coeffdict = self._normalize_coeffs(columnmasked, dnormmethod)
					columnmasked = self.normalize_data(columnmasked, coeffdict)
				columnmasked.mask = None
				column = columnmasked
			self.norm_timevarying_matrix.add_columns(column, [dname])
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
			# data containers
			self.private_energy_descriptors = expandable_matrix()
			self.segmented_dataspace = {} # averaged descriptors unique to this segment
			self.segmented_norm_dataspace = {} # averaged descriptors unique to this segment
			self.norm_location = None # set in setup_normalization
		#####################################	
		def get_matrix_location(self, dname, dparams, start, stop, norm=False, mixture=False):
			# there are three possible arrays that we may need to access to get timevarying descriptor values
			#		1. the main, raw descriptor array loaded from disk. these descriptors are unnormalized, and the array is shared between multiple instances of sf_segment_descriptors()
			#		2. the main normalized descriptor array. self.overlord.norm_timevarying_matrix, also shared among objects. this is one long array regardless of obj file origins
			#		3. this obj's private_energy_descriptors, which are not shared. this is for things like envelopped descriptors which describe energy
			#print("HERE", self.tag, dname, start, stop)
			if stop == None: length = self.len
			else: length = stop-start
			if norm:
				st = "norm matrix"
				mat = self.overlord.norm_timevarying_matrix
				idx = self.norm_start
			elif mixture:
				st = "mixture matrix"
				mat = self.private_mixture_descriptors
				idx = 0
			elif dparams['describes_energy'] and self.has_envelope:
				st = "private matrix"
				mat = self.private_energy_descriptors
				if not mat.has_column(dname):
					pmat = self.overlord.sffile2matrix[self.sfseghandle.filename]
					if not pmat.has_column(dname):
						pmat.calculate_new_column(dname, dparams['type'], dparams['parent'])
					energydesc = pmat.get_columns([dname], rowslice=slice(self.start, self.end))
					mat.add_columns(np.array(energydesc, copy=True) * self.envelope, [dname])
				idx = 0
			else:
				st = "raw matrix"
				mat = self.overlord.sffile2matrix[self.sfseghandle.filename]
				if not mat.has_column(dname):
					# on demand calculation of new columns - delta, deltadelta, odf
					mat.calculate_new_column(dname, dparams['type'], dparams['parent'])
				idx = self.start

			#print(self.tag, st, idx, length, dname, start, stop)
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
						self.segmented_norm_dataspace[dname][k] = self.overlord.normalize_data(self.segmented_dataspace[dname][k], self.overlord.norm_segmented_tag_dict[self.tag][dname])			
					return self.segmented_norm_dataspace[dname][k]
			# otherwise this is time varying
			matrix_pointer, start_array, stop_array = self.get_matrix_location(dname, dparams, start, stop, norm=norm, mixture=mixture)
			output = matrix_pointer.get_columns([dname], rowslice=slice(start_array, stop_array))
			if copy: output = np.array(output, copy=True)
			return output
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
		def _edit_tv_data(self, dname, dataarray, minLen, start=0, norm=False, mixture=False):
			dparams = self.overlord.descriptor_string_digest(dname)
			mat, st, ed = self.get_matrix_location(dname, dparams, start, start+minLen, norm=norm, mixture=mixture)
			mat.matrix[st:ed,mat.column_dnames.index(dname)] = dataarray
		#####################################	
		def mixture_subtract(self, cpsseg, ampscale, minLen, verbose=True):
			tgtseg = self.sfseghandle
			preSubtractPeak = util.ampToDb(np.max(self.get('power', start=tgtseg.seek, stop=tgtseg.seek+minLen)))
			rawSubtraction = tgtseg.desc.get('power', start=tgtseg.seek, stop=tgtseg.seek+minLen)-(cpsseg.desc.get('power', stop=minLen)*ampscale)
			rawSubtraction = np.clip(rawSubtraction, 0, None)
			postSubtractPeak = util.ampToDb(np.max(rawSubtraction))
			self._edit_tv_data('power', rawSubtraction, minLen, start=tgtseg.seek, norm=False, mixture=False)
			#print("\tsubtracted %i corpus frames from target's amplitude -- original peak %.1fdB, new peak %.1fdB"%(minLen, preSubtractPeak, postSubtractPeak))
			for d in self.private_energy_descriptors.column_dnames:
				if d == 'power': continue
				dparams = self.overlord.descriptor_string_digest(d)
				self.private_energy_descriptors.recalculate_column(d, dparams['type'], dparams['parent'])
			# clear segmentation dicts
			self.segmented_dataspace.clear()
			self.segmented_norm_dataspace.clear()
		#####################################	
		def mixutre_mix(self, cpsseg, ampscale, minLen, descriptors, verbose=True):
			mix_dur = min(self.len-self.sfseghandle.seek, cpsseg.lengthInFrames)
			tgtseek = self.sfseghandle.seek
			for d in descriptors:
				dparams = self.overlord.descriptor_string_digest(d.name)
				if dparams['isseg']:
					continue
				tgtvalues = self.get(d.name, mixture=True)[tgtseek:tgtseek+mix_dur]
				cpsvalues = cpsseg.desc.get(d.name)[:mix_dur]
				if dparams['describes_energy']:
					mixture = tgtvalues + cpsvalues	# simple sum
				else:	
					tgtpowers = self.get('power', mixture=True)[tgtseek:tgtseek+mix_dur]
					cpspowers = cpsseg.desc.get('power')[:mix_dur]
					mixture = ((tgtvalues*tgtpowers)+(cpsvalues*cpspowers))/(tgtpowers + cpspowers)	# weighted average
				mixture = ((tgtvalues*tgtpowers)+(cpsvalues*cpspowers))/(tgtpowers + cpspowers)	
				#if dparams['describes_energy']:
				#	print("ENERGY", self.sfseghandle.seek)
				self._edit_tv_data(d.name, mixture, mix_dur, start=self.sfseghandle.seek, mixture=True)




def timeVaryingDescriptorMixture(tgtsegh, tgtseek, cpssegh, cpsseek, dobj, cpsAmpScale, v=False):
	mix_dur = min(tgtsegh.lengthInFrames-tgtseek, cpssegh.lengthInFrames-cpsseek)
	tgt_vals = tgtsegh.mixdesc[dobj.name][tgtseek:tgtseek+mix_dur]
	cps_vals = cpssegh.desc[dobj.name][cpsseek:cpsseek+mix_dur]
	if dobj.describes_energy: # powers are summed
		mixture = tgt_vals + (cps_vals*cpsAmpScale)
	elif dobj.name == 'zeroCross': 
		mixture = np.maximum(tgt_vals, cps_vals)	
	else: # power averaged
		tgt_amps = tgtsegh.mixdesc['power'][tgtseek:tgtseek+mix_dur]
		cps_amps = cpssegh.desc['power'][cpsseek:cpsseek+mix_dur]*cpsAmpScale
		mixture = ((tgt_vals*tgt_amps)+(cps_vals*cps_amps))/(tgt_amps + cps_amps)	
	if v: # verbose printing
		maxxy = min(5, len(mixture))
		if dobj.describes_energy: # powers are summed
			print("SUM", dobj.name, tgtseek, mix_dur)
		else:
			print("MIXTURE", dobj.name, tgtseek, mix_dur)
		print("\tpastmix:", tgt_vals[0:maxxy])
		print("\tcorpus:", cps_vals[0:maxxy])
		print("\tnewmix:", mixture[0:maxxy])
	return mixture




#	def mixSelectedSamplesDescriptors(self, cpsh, cpsAmpScale, tgtsegSeek, AnalInterface, v=True):
#			if not d.seg: # is time-varying
#				self.mixdesc[d.name][tgtsegSeek:tgtsegSeek+mix_dur] = timeVaryingDescriptorMixture(self, tgtsegSeek, cpsh, 0, d, cpsAmpScale)
#			else: # is segmented
#				self.mixdesc[d.name].clear()
#		self.has_been_mixed = True
#


if __name__ == '__main__':
	descriptor_manager = descriptor_manager()
	class fakecsf:
		def __init__(self):
			self.filename = 'cage/path/aiff'
	this_fake_csf = fakecsf()

	fakedata = np.load('/Users/ben/Documents/audioguide/audioguide/data/cage-69f74bc6b9bf-ircamd.npy')
	tgtwhole = descriptor_manager.create_sf_descriptor_obj(this_fake_csf, fakedata, 0, 1110, tag='tgtwhole')
	print(tgtwhole.get('power-odf-7'))



	desc2 = descriptor_manager.create_sf_descriptor_obj(this_fake_csf, fakedata, 50, 300, tag='tgt')
	desc3 = descriptor_manager.create_sf_descriptor_obj(this_fake_csf, fakedata, 50, 200, tag='tgt')
	desc4 = descriptor_manager.create_sf_descriptor_obj(this_fake_csf, fakedata, 100, 50, tag='cps', envelope=np.linspace(0, 1, num=50))
	desc = descriptor_manager.create_sf_descriptor_obj(this_fake_csf, fakedata, 20, 5, tag='cps', envelope=0.)
	print(desc.get('centroid'))
	print(desc.get('noisiness-delta'))
	print(desc.get('mfcc2'))
	print(desc.get('power'))
	print(desc4.get('power'))
	descriptor_manager.normalize_setup([desc, desc2, desc3, desc4])

	from audioguide.userclasses import SingleDescriptor as d
	d_list = [d('power-seg', norm=1), d('centroid'), d('kurtosis-seg'), d('noisiness-delta'), d('mfcc1', norm=1)]
	for dobj in d_list:
		descriptor_manager.normalize_descriptor(dobj.name, dobj.normmethod, dobj.norm)


	print(desc3.get('power-seg', norm=True))
	print(desc.get('kurtosis-seg', norm=True))
	print(desc2.get('kurtosis-seg', norm=True))
	print(desc3.get('kurtosis-seg', norm=True))
	print(desc4.get('kurtosis-seg', norm=True))
	print(desc.get('centroid', norm=True))
	#print(desc.get('mfcc1-delta', start=9, stop=10))
	#print(desc.get('power-seg'))









def SegmentedDescriptorComputation(sfdescobj, dname, dparams, handle, start, end):
	# SINGLE-NUMBER METHODS
	if dname == "dur-seg": # raw segment duration
		output = handle.lengthInFrames
	elif dname == "effDur-seg": # perceived segment duration in seconds
		output = effectiveDur(handle, start) * handle.f2s
	elif dname == "effDurFrames-seg": # perceived segment duration in frames
		output = effectiveDur(handle, start)
	elif dname == "MIDIPitch-seg":
		output = MIDIPitchByFileName( handle.printName, handle.midiPitchMethod, handle )
	elif dname == "peakTime-seg":
		output = peakTimeSeg(sfdescobj.get('power', start=start, stop=end))
	elif dname == "logAttackTime-seg":
		output = logAttackTime(sfdescobj.get('power', start=start, stop=end))
	elif dname == "percentInFile-seg":
		output = percentInFile(handle, start, end)
	elif dname == "f0-seg":
		output = f0Seg(handle.desc.get('f0', start=start, stop=end), sfdescobj.get('power', start=start, stop=end))
	# DESCRIPTOR SLOPE
	elif dparams['type'] == 'slope-regression':
		output = descriptorSlope(handle, dparams['parent'], start)
	# FLAT MEAN - NOT ENERGY WEIGHTED
	elif dparams['type']  == 'mean':
		output = np.average(sfdescobj.get(dparams['parent'], start=start, stop=end))
	# SEGMENT-AVERAGE METHODS
	elif dparams['seg_method']  == 'max':
		output = np.max(sfdescobj.get(dparams['parent'], start=start, stop=end))
	elif dparams['seg_method']  == 'median': 
		output = sfdescobj.get(dparams['parent'], start=start, stop=end)
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
	return newdata



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
	elif type(midiPitchMethod) in [float, int]:
		return midiPitchMethod
	elif midiPitchMethod == 'centroid-seg':
		return util.frq2Midi(handle.desc.get('centroid-seg'))
	elif midiPitchMethod == 'f0-seg':
		f0 = handle.desc.get('f0-seg')
		if f0 != 0:
			return util.frq2Midi(f0)
		else:
			return notfound


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

