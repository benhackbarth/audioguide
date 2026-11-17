import numpy as np
import util, os
#from scipy.stats import skew
#from scipy.stats import kurtosis
#from pydub import AudioSegment
#from pydub.playback import play



def buildarray_all_timevarying_descriptors(sfobjlist, descriptorlist, AnalInterface, n_dimensions=2):
	all_sfs = list(set([s.filename for s in sfobjlist]))
	tv_descriptors = [d for d in descriptorlist if not d.seg]
	
	matrix = np.empty((sum([AnalInterface.rawData[sf]['arraylen'] for sf in all_sfs]), len(tv_descriptors)))
	cnt = 0
	for sf in all_sfs:
		for didx, d in enumerate(tv_descriptors):
			dvalues = AnalInterface.rawData[sf]['librosad'][:,AnalInterface.rawData[sf]['info']['librosad_columns'][d.name]]
			matrix[cnt:cnt+len(dvalues),didx] = dvalues
		cnt += AnalInterface.rawData[sf]['arraylen']
	
	print("dimensional scaling")
	import umap
	mapper = umap.UMAP(n_neighbors=20, min_dist=0., n_components=n_dimensions, metric='euclidean')
	reduceddata = mapper.fit_transform(matrix)
	#print(reduceddata)

	print("adding new columns to librosad arrays")
	cnt = 0
	for sf in all_sfs:
		AnalInterface.desc_manager.sffile2matrix[sf].add_columns(reduceddata[cnt:cnt+AnalInterface.rawData[sf]['arraylen']], ['X','Y'])
		cnt += AnalInterface.rawData[sf]['arraylen']




class vizsegment:
	def __init__(self, tag, norm, segmentobj, matrixrow):
		self.tag = tag
		if norm == None:
			self.norm = False
		else:
			self.norm = True
		self.segobj = segmentobj
		self.matrixrow = matrixrow
		self.lenf = segmentobj.lengthInFrames
		if hasattr(segmentobj, 'voiceID'):
			self.voiceId = segmentobj.voiceID
		else:
			self.voiceId = -1 # target
		self.annotation = segmentobj.printName
		if segmentobj.segmentStartSec > 0:
			self.annotation += '@%.1f'%segmentobj.segmentStartSec
	def get_x(self, matrix):
		return matrix[self.matrixrow][0]
	def get_y(self, matrix):
		return matrix[self.matrixrow][1]
	def get_color(self, filelist, colormap):
		return colormap((filelist.index(self.segobj.printName))/float(len(filelist)))
		

########################
## make array for MDS ##
########################
# UMAP scaling
class dimensionalReduceData:
	registry = {}
	cnt = 0
	previous_transforms = {'scale': 1, 'rotate': 0, 'shift': [0, 0]}
	gridify_moved_points = {}
	
	def __init__(self):
		self.cnt = 0 # reset
		self.cps_filelist = []
		self.segments = []
		self.audiosegmentobjs = {}

	def addsoundsV2(self, segmentobjlist, norm=None, tag=None):
		for segmentobj in segmentobjlist:
			self.segments.append(vizsegment(tag, norm, segmentobj, self.cnt))
			self.cnt += 1
			if segmentobj.printName not in self.cps_filelist:
				self.cps_filelist.append(segmentobj.printName)
			#	self.audiosegmentobjs[segmentobj.filename] = AudioSegment.from_wav(segmentobj.filename)


	def buildV2(self, descriptorlist, MAKE_STATS=False):
		self.descriptorlist = descriptorlist
		self.matrix = np.empty((len(self.segments), len(self.descriptorlist)))
		for sidx, s in enumerate(self.segments):
			this_row = []
			desc_powers = s.segobj.desc.get('power', start=0, stop=s.lenf)
			for didx, dname in enumerate(self.descriptorlist):
				desc_data = s.segobj.desc.get(dname, start=0, stop=s.lenf)
				if sum(desc_powers) > 0:
					this_row.append(np.average(desc_data, weights=desc_powers))
				else:
					this_row.append(np.average(desc_data))
			self.matrix[sidx] = this_row
			
		



	# for click+play callbacks
	def scale(self, method='umap', n_neighbors=10, min_dist=0.4, n_dimensions=2, metric='euclidean'):
		self.n_dimensions = n_dimensions
		if method == 'umap':
			import umap
			self.title = "%s - %i %f %s"%(method, n_neighbors, min_dist, metric)
			self.mapper = umap.UMAP(n_neighbors=n_neighbors, min_dist=min_dist, n_components=n_dimensions, metric=metric)
			self.reduceddata = self.mapper.fit_transform(self.matrix)

		# AUTO ENCODER
#		elif method == 'ae':
#			self.title = "%s - "%(method)
#			from sklearn.preprocessing import minmax_scale
#			from sklearn.model_selection import train_test_split
#			from keras.layers import Input, Dense
#			from keras.models import Model
#
#			train_scaled = minmax_scale(self.matrix, axis=0)
#
#			ncol = train_scaled.shape[1]
#			input_dim = Input(shape = (ncol, ))
#			### Define the encoder dimension
#			encoding_dim = 2
#
#
#			# Encoder Layers
#			encoded1 = Dense(6, activation = 'relu')(input_dim)
#			#encoded2 = Dense(8, activation = 'relu')(encoded1)
#			#encoded3 = Dense(6, activation = 'relu')(encoded2)
#			#encoded4 = Dense(4, activation = 'relu')(encoded3)
#			encoded5 = Dense(n_dimensions, activation = 'relu')(encoded1)
#
#			# Decoder Layers
#			decoded1 = Dense(4, activation = 'relu')(encoded5)
#			decoded2 = Dense(6, activation = 'relu')(decoded1)
#			decoded3 = Dense(8, activation = 'relu')(decoded2)
#			decoded4 = Dense(10, activation = 'relu')(decoded3)
#			decoded5 = Dense(ncol, activation = 'sigmoid')(decoded4)
#
#			# Combine Encoder and Deocder layers
#			#autoencoder = Model(inputs = input_dim, outputs = decoded5)
#
#			# Compile the Model
#			#autoencoder.compile(optimizer = 'adadelta', loss = 'binary_crossentropy')
#
#			encoder = Model(inputs = input_dim, outputs = encoded1)
#			encoded_input = Input(shape = (n_dimensions, ))
#
#			import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
#			encoded_train = pd.DataFrame(encoder.predict(train_scaled))
#			encoded_train = encoded_train.add_prefix('feature_')
#			self.reduceddata = np.array(encoded_train)

		self.originpoint = np.average(self.reduceddata, axis=0)
		self.min = np.min(self.reduceddata, axis=0)
		self.max = np.max(self.reduceddata, axis=0)

	# for click+play callbacks
	def __call__(self, event):
		cpsdistances = [(row[0]-event.xdata)**2 + (row[1]-event.ydata)**2 for row in self.reduceddata[self.registry['cps']['span'][0]:self.registry['cps']['span'][1]]]
		segobjidx = np.argmin(cpsdistances) + self.registry['cps']['span'][0]
		# send message "/foo/message1" with int, float and string arguments
		cps = self.registry['cps']['segobjs'][segobjidx]


	def gridify(self, numberpointsxy=(20, 20), plot=True):
		origmins = np.min(self.reduceddata, axis=0)
		origmaxs = np.max(self.reduceddata, axis=0)
		
		x_slots = np.linspace(origmins[0], origmaxs[0], num=numberpointsxy[0])
		y_slots = np.linspace(origmins[1], origmaxs[1], num=numberpointsxy[1])
		
		slot_assignments = {}
		for xidx, x in enumerate(x_slots):
			for yidx, y in enumerate(y_slots):
				slot_assignments[(xidx, yidx)] = {'x': x, 'y': y, 'list': []}

		for idx, (x, y) in enumerate(self.reduceddata):
			x_win = np.argmin(np.abs(x_slots-x))
			y_win = np.argmin(np.abs(y_slots-y))
			slot_assignments[(x_win, y_win)]['list'].append((x, y, idx))
					
		while True:
			# test for overflowed slot
			slot = None
			for (xidx, yidx) in slot_assignments:
				if len(slot_assignments[(xidx, yidx)]['list']) > 1:
					slot = (xidx, yidx)
					break
			if slot == None: break # we are done
			worst_matching_in_overflowed_slot = [((slot_assignments[slot]['x']-x)**2) + ((slot_assignments[slot]['y']-y)**2) for (x, y, idx) in slot_assignments[slot]['list']]
			slot_list_idx_to_move = np.argmax(worst_matching_in_overflowed_slot)
			movex, movey, moveidx = slot_assignments[slot]['list'][slot_list_idx_to_move]
			step_cnt = 1
			while True:
				free_slots_around_it = [(x, y) for x in range(slot[0]-step_cnt, slot[0]+step_cnt+1) for y in range(slot[1]-step_cnt, slot[1]+step_cnt+1) if (x, y) in slot_assignments and (x, y) != slot and len(slot_assignments[(x, y)]['list']) == 0]
				if len(free_slots_around_it) > 0: break
				step_cnt += 1
			distances_to_free_slot = [((slot_assignments[(x, y)]['x']-movex)**2) + ((slot_assignments[(x, y)]['y']-movey)**2) for (x, y) in free_slots_around_it]
			closest_free_slot = free_slots_around_it[np.argmin(distances_to_free_slot)]
			slot_assignments[closest_free_slot]['list'].append((movex, movey, moveidx))
			slot_assignments[slot]['list'].remove((movex, movey, moveidx))
			if plot:
				self.gridify_moved_points[tuple(self.reduceddata[moveidx])] = (slot_assignments[closest_free_slot]['x'], slot_assignments[closest_free_slot]['y'])

		# we are done
		newdata = []
		for (slotx, sloty), d in slot_assignments.items():
			if len(d['list']) == 0: continue
			assert len(d['list']) == 1
			newdata.append((d['x'], d['y'], d['list'][0][2]))
		
		from operator import itemgetter
		newdata = sorted(newdata, key=itemgetter(2))
		self.reduceddata = np.array(newdata)[:,[0, 1]]
	

	def plottarget(self, axis, x, y, selected, shadow_draw=False, writelabels=False, s=4):
		minlinwidth = 1.2
		maxlinewidth = 8
	
	
		if shadow_draw:
			bluecolor = '0.7' 
			bluecolorLC = (0.75, 0.75, 0.75, 0.5)
		else:
			bluecolor = (0., 0., 1.)
			bluecolorLC = (0.5, 0.5, 1, 0.5)
# 		maxpowers = np.array([max(ps) for ps in powers])
# 		minny = np.min(maxpowers)
# 		rangy = np.max(maxpowers)-minny
# 		powerSizes = (maxpowers-minny)/rangy
# 		powerSizes *= maxlinewidth-minlinwidth
# 		powerSizes += minlinwidth
# 		faceCs = []
# 		powerSizesSelected = []
	
		color = []
		for b in selected: 
			if b: color.append('limegreen')
			else: color.append('blue')
		
		if shadow_draw:
			linetype = '--'
			dashes=[2]
		else:
			linetype = '-'
			dashes=[]
		axis.plot(x, y, linetype, marker='s', c=bluecolorLC, mfc=bluecolor, mec=bluecolor, markersize=s, dashes=dashes)

		if not shadow_draw and writelabels:
			for pidx, (xp, yp) in enumerate(zip(x, y)):
				axis.text(xp, yp, str(pidx))
	

	def plot(self, path=None, plotTarget=False, tgtmapping=None):		 
		import matplotlib.pyplot as plt
		import matplotlib.cm as cm
		from mpl_toolkits.mplot3d import Axes3D
		import matplotlib.path as mpath
		import matplotlib.patches as mpatches
		
		self.fig = plt.figure(figsize=(8, 5), dpi=200)
		self.ax = self.fig.add_subplot(111)

		self.tgtmapping = tgtmapping
		for tgtidx, cpsdict in self.tgtmapping.items():
			for simnumber, cpsidx in cpsdict.items():
				if simnumber == 0: color='black'
				else: color='yellow'
				self.ax.annotate("", xy=self.reduceddata[cpsidx], xycoords='data', xytext=self.reduceddata[tgtidx], textcoords='data', arrowprops=dict(facecolor=color, edgecolor=color, shrink=0.05, width=0.1, headwidth=0.5, headlength=0.5),)	





		# plot target
		if plotTarget:
			Xs = [s.get_x(self.reduceddata) for s in self.segments if s.tag == 'tgt']
			Ys = [s.get_y(self.reduceddata) for s in self.segments if s.tag == 'tgt']
			self.plottarget(self.ax, Xs, Ys, [True *len(Xs)], shadow_draw=False, writelabels=False, s=2)

		
		# assign corpus colors
		cspcolors = []
		csp_display_names = {}
		max_voiceID = max([s.segobj.voiceID for s in self.segments if s.tag == 'cps'])
		for s in self.segments:
			if s.tag == 'cps':
				if max_voiceID == 0:
					s.color='red'
				else:
					s.color = cm.get_cmap('tab10')(float(s.segobj.voiceID)/float(max_voiceID))
				foldername = os.path.split(os.path.split(s.segobj.filename)[0])[1]
				if foldername not in csp_display_names:
					csp_display_names[foldername] = {'color': s.color, 'xs': [], 'ys': []}
				csp_display_names[foldername]['xs'].append(s.get_x(self.reduceddata))
				csp_display_names[foldername]['ys'].append(s.get_y(self.reduceddata))
				cspcolors.append(s.color)
			else:
				s.color = 'blue'
				foldername = 'beatbox.aiff'
				if foldername not in csp_display_names:
					csp_display_names[foldername] = {'color': s.color, 'xs': [], 'ys': []}
				csp_display_names[foldername]['xs'].append(s.get_x(self.reduceddata))
				csp_display_names[foldername]['ys'].append(s.get_y(self.reduceddata))
			

		# plot corpus
		self.sc = self.ax.scatter([s.get_x(self.reduceddata) for s in self.segments if s.tag == 'cps'], [s.get_y(self.reduceddata) for s in self.segments if s.tag == 'cps'], c=cspcolors, marker='s', s=4)


		# CPS annotation stuff
		self.annot = self.ax.annotate("", xy=(0,0), xytext=(20,20), textcoords="offset points", bbox=dict(boxstyle="round", fc="w"), arrowprops=dict(arrowstyle="->"))
		self.annot.set_visible(False)
		
		nameremap = {
'artificial-harmonic': 'harmonic',
'fbslap': 'fingerboard slap',
'mutedpizz': 'muted pizz',
'pizz': 'pizz',
'scratch': 'scratch tone',
'wood': 'hit on wood',
'staccato': 'arco staccato',
		}
		
		for head, d in csp_display_names.items():
			numpyarraycoors = np.average(d['xs']), np.average(d['ys'])
			if head in nameremap:
				texty = nameremap[head]
			else:
				texty=head
			an = self.ax.annotate(texty, xy=numpyarraycoors, size=7.5, color=d['color']) 
			an.draggable()

		for xystart, xyend in self.gridify_moved_points.items():
			self.ax.annotate("", xy=xyend, xycoords='data', xytext=xystart, textcoords='data', arrowprops=dict(facecolor='black', shrink=0.00, width=0.25, headwidth=0.5, headlength=0.5))	


		self.annot_last_hover_play = None
		self.fig.canvas.mpl_connect("motion_notify_event", self.hover)
		self.fig.canvas.mpl_connect('button_press_event', self)
		
		plt.title(self.title, fontsize=12)
		plt.xlim([self.min[0]-1, self.max[0]+1])
		plt.ylim([self.min[1]-1, self.max[1]+1])
		
		if path == None: plt.show()
		else: plt.savefig(path)


	def hover(self, event):
		#vis = self.annot.get_visible()
		if event.inaxes == self.ax:
			cont, ind = self.sc.contains(event)
			if cont and ind["ind"][0] != self.annot_last_hover_play:
				thissegobj = [s for s in self.segments][ind["ind"][0]]
				if thissegobj.tag == 'cps':
					print(thissegobj.segobj.filename)
# 				elif thissegobj.tag == 'tgt' and self.tgtmapping != None:
# 					thissegmapping = self.tgtmapping[thissegobj.matrixrow]
# 					print(thissegobj.matrixrow, thissegmapping)
# 					
					
				#startms = thissegobj.segobj.segmentStartSec*1000
				#stopms = thissegobj.segobj.segmentEndSec*1000
				#play(self.audiosegmentobjs[thissegobj.segobj.filename][startms:stopms])
				# segobj self.audiosegmentobjs[segmentobj.filename]
# 				cps = self.registry['cps']['segobjs'][ind["ind"][0]]
# 				atk = cps.envAttackSec*1000
# 				dec = cps.envDecaySec*1000
# 		
# 				if False:
# 					# make label appear
# 					self.annot.xy = self.sc.get_offsets()[ind["ind"][0]]
# 					self.annot.set_text("{}".format(self.registry['cps']['annotations'][ind["ind"][0]]))
# 					#self.annot.get_bbox_patch().set_facecolor(cmap(norm(c[ind["ind"][0]])))
# 					self.annot.get_bbox_patch().set_alpha(0.4)
# 					self.annot.set_visible(True)
# 				self.annot_last_hover_play = ind["ind"][0]
# 			else:
# 				if vis:
# 					self.annot.set_visible(False)
			self.fig.canvas.draw_idle()
		

	def transformReducedData(self, transtype, transvalue, tag, originpoint='auto-all'):
		assert transtype in self.previous_transforms
		if originpoint == 'auto-all':
			originpoint = self.originpoint
		
		
		# transform it!
		if transtype == 'rotate':
			# ROTATION
			thistransvalue = transvalue - self.previous_transforms[transtype]
			for idx in range(self.registry[tag]['span'][0], self.registry[tag]['span'][1]):
				import math
				radi
				ans = np.pi*(thistransvalue/180.)
				point = self.reduceddata[idx]
				qx = originpoint[0] + math.cos(radians) * (point[0] - originpoint[0]) - math.sin(radians) * (point[1] - originpoint[1])
				qy = originpoint[1] + math.sin(radians) * (point[0] - originpoint[0]) + math.cos(radians) * (point[1] - originpoint[1])
				self.reduceddata[idx] = np.array([qx, qy])

		elif transtype == 'scale':
			# SCALING
			thistransvalue = transvalue / self.previous_transforms[transtype]
			for idx in range(self.registry[tag]['span'][0], self.registry[tag]['span'][1]):
				self.reduceddata[idx] = ((self.reduceddata[idx]-originpoint)*thistransvalue)+originpoint


		elif transtype == 'shift':
			# ROTATION
			thistransvalue = np.array([transvalue[0] - self.previous_transforms[transtype][0], transvalue[1] - self.previous_transforms[transtype][1]])
			for idx in range(self.registry[tag]['span'][0], self.registry[tag]['span'][1]):
				self.reduceddata[idx] += thistransvalue
		self.previous_transforms[transtype] = transvalue



	def extrapolateNewDescriptors(self, tag, type='raw'):		
		extrapolatedarray = self.mapper.inverse_transform(self.reduceddata[self.registry[tag]['span'][0]:self.registry[tag]['span'][1]])
		for s, matrixloc, descslice in zip(self.registry[tag]['segobjs'], self.registry[tag]['matrixloc'], self.registry[tag]['descslice']):
			loc = matrixloc-self.registry[tag]['span'][0]
			length = descslice[1]-descslice[0]
			for didx, d in enumerate(self.descriptorlist):
				if type == 'raw':
					s.desc[d.name] = extrapolatedarray[loc:loc+length:, didx]
				elif type == 'norm':
					s.desc[d.name].datanorm = extrapolatedarray[loc:loc+length:, didx]
					s.desc[d.name] = None

