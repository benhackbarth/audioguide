import numpy as np
import util

########################
## make array for MDS ##
########################
# UMAP scaling
class dimensionalReduceData:
	registry = {}
	cnt = 0
	previous_transforms = {'scale': 1, 'rotate': 0, 'shift': [0, 0]}
	
	def __init__(self):
		pass

	def addsoundsAndBuildV2(self, segmentobjlist, descriptorlist, norm=None, tag=None):
		from scipy.stats import skew
		from scipy.stats import kurtosis

		self.cnt = 0 # reset
		
		if tag not in self.registry: self.registry[tag] = {'segobjs': [], 'descslice': [], 'matrixloc': [], 'voiceID': [], 'cps_annotations': []}
		for segmentobj in segmentobjlist:
			self.registry[tag]['segobjs'].append(segmentobj)
			self.registry[tag]['matrixloc'].append(self.cnt)
			self.registry[tag]['descslice'].append([0, segmentobj.lengthInFrames])
			self.cnt += 1		
			if tag == 'cps':
				self.registry[tag]['voiceID'].append(segmentobj.voiceID)
				annotation = segmentobj.printName
				if segmentobj.segmentStartSec > 0:
					annotation += '@%.1f'%segmentobj.segmentStartSec
				self.registry[tag]['cps_annotations'].append(annotation)


		MAKE_STATS = False
		#self.descriptorlist = ['mfcc1', 'mfcc2', 'mfcc3', 'mfcc4', 'mfcc5', 'mfcc6', 'mfcc7', 'mfcc8', 'mfcc9', 'mfcc10', 'mfcc11', 'mfcc12'] #descriptorlist
		self.descriptorlist = ['chroma0', 'chroma1', 'chroma2', 'chroma3', 'chroma4', 'chroma5', 'chroma6', 'chroma7', 'chroma8', 'chroma9', 'chroma10', 'chroma11'] #descriptorlist
		matrix_width = len(self.descriptorlist)
		if MAKE_STATS: matrix_width *= 6
		self.matrix = np.empty((self.cnt, matrix_width))
		for tag in self.registry:
			for segobj, descslice, matrixloc in zip(self.registry[tag]['segobjs'], self.registry[tag]['descslice'], self.registry[tag]['matrixloc']):
				this_row = []
				desc_powers = segobj.desc.get('power', start=descslice[0], stop=descslice[1])
				for didx, dname in enumerate(self.descriptorlist):
					desc_data = segobj.desc.get(dname, start=descslice[0], stop=descslice[1])
					this_row.append(np.average(desc_data, weights=desc_powers))
					if MAKE_STATS:
						datas = [np.min(desc_data), np.max(desc_data), np.std(desc_data), skew(desc_data), kurtosis(desc_data)]
						this_row.extend(datas)
					# diff
#					desc_data = np.diff(desc_data)
#					datas = [np.average(desc_data), np.min(desc_data), np.max(desc_data), np.std(desc_data), skew(desc_data), kurtosis(desc_data)]
#					this_row.extend(datas)

				self.matrix[matrixloc] = this_row
				print(self.matrix[matrixloc], matrixloc)


		# get spans for tag
		for tag in self.registry:
			self.registry[tag]['span'] = [self.registry[tag]['matrixloc'][0], self.registry[tag]['matrixloc'][-1]+(self.registry[tag]['descslice'][-1][1]-self.registry[tag]['descslice'][-1][0])]



	def addsounds(self, segmentobjlist, method='allframes', tag=None):
		if tag not in self.registry: self.registry[tag] = {'segobjs': [], 'descslice': [], 'matrixloc': [], 'voiceID': [], 'cps_annotations': []}
		for segmentobj in segmentobjlist:
			self.registry[tag]['segobjs'].append(segmentobj)
			self.registry[tag]['matrixloc'].append(self.cnt)
			if method == 'allframes': # add every frame of this sound
				self.registry[tag]['descslice'].append([0, segmentobj.lengthInFrames])
				self.cnt += segmentobj.lengthInFrames
			elif method == 'peakframe': # add only the peak frame of this sound
				peakf = np.argmax(list(segmentobj.desc.get('power')))
				self.registry[tag]['descslice'].append([peakf, peakf+1])
				self.cnt += 1
			elif method == 'static_stats': # many stats to represent TV arrays
				self.registry[tag]['descslice'].append([0, segmentobj.lengthInFrames])
				self.cnt += 1

			if tag == 'cps':
				self.registry[tag]['voiceID'].append(segmentobj.voiceID)

				annotation = segmentobj.printName
				if segmentobj.segmentStartSec > 0:
					annotation += '@%.1f'%segmentobj.segmentStartSec
				self.registry[tag]['cps_annotations'].append(annotation)

		
	def buildarray(self, descriptorlist, type='raw', norm=None):
		self.descriptorlist = descriptorlist
		self.matrix = np.empty((self.cnt, len(self.descriptorlist)))
		for tag in self.registry:
			for segobj, descslice, matrixloc in zip(self.registry[tag]['segobjs'], self.registry[tag]['descslice'], self.registry[tag]['matrixloc']):
				for didx, d in enumerate(descriptorlist):
					if type == 'raw':
						self.matrix[matrixloc:matrixloc+descslice[1]-descslice[0]:,didx] = segobj.desc.get(d.name, start=descslice[0], stop=descslice[1])
					elif type == 'norm':
						self.matrix[matrixloc:matrixloc+descslice[1]-descslice[0]:,didx] = segobj.desc.get(d.name, start=descslice[0], stop=descslice[1], norm=True)
						
		# get spans for tag
		for tag in self.registry:
			self.registry[tag]['span'] = [self.registry[tag]['matrixloc'][0], self.registry[tag]['matrixloc'][-1]+(self.registry[tag]['descslice'][-1][1]-self.registry[tag]['descslice'][-1][0])]
#  TESTING
#		for tag in self.registry:
#			for sobj, descslice, mloc in zip(self.registry[tag]['segobjs'], self.registry[tag]['descslice'], self.registry[tag]['matrixloc']):
#				print(sobj.filename, descslice,mloc, sobj.lengthInFrames, self.matrix[mloc])
#


	# for click+play callbacks
	def scale(self, method='umap', n_neighbors=20, min_dist=0.1, n_dimensions=2, metric='euclidean'):
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
		#mu.executeCommand("afplay %s"%self.registry['cps']['segobjs'][segobjidx].filename)

	def plot(self, path=None):
		try:
			import liblo
		except ImportError:
			print(ImportError, "liblo package needs to be installed for OSC max callbacks.")

		# send all messages to port 1234 on the local machine
		try:
			 self.osc_target = liblo.Address(1234)
		except liblo.AddressError:
			 sys.exit()		
		import matplotlib.pyplot as plt
		import matplotlib.cm as cm
		from mpl_toolkits.mplot3d import Axes3D
		import matplotlib.path as mpath
		import matplotlib.patches as mpatches
		
		self.fig = plt.figure()
		self.ax = self.fig.add_subplot(111)

		# plot target traj
		plotTarget = False
		if plotTarget:
			for sobj, descslice, mloc in zip(self.registry['tgt']['segobjs'], self.registry['tgt']['descslice'], self.registry['tgt']['matrixloc']):
				data = self.reduceddata[mloc:mloc+descslice[1]]
				colors = []
				alphas = sobj.desc.get('power')/np.max(sobj.desc.get('power'))
				for a in alphas: colors.append([1, 0, 0, a])
				self.ax.plot(data[:,0], data[:,1], 'r-')


#			tgt_path_data = []
#			Path = mpath.Path
#			path_data = [(Path.MOVETO, self.reduceddata[self.registry['tgt']['span'][0]])]
#			for x, y in self.reduceddata[self.registry['tgt']['span'][0]+1:self.registry['tgt']['span'][1]-1]:
#				path_data.append((Path.LINETO, (x, y)))
#			path_data.append((Path.CLOSEPOLY, self.reduceddata[self.registry['tgt']['span'][1]-1]))
#			codes, verts = zip(*path_data)
#			pathobj = mpath.Path(verts, codes)
#			# plot control points and connecting lines
#			x, y = zip(*pathobj.vertices)
#			#ax.plot(x, y, 'r-',  alpha=0.1)
#			ax.plot(x, y, 'r-',  alpha=1)

		
#		if self.n_dimensions == 1:
#			ax = self.fig.add_subplot(111)
#			ax.scatter(self.reduceddata[:,0], range(len(self.reduceddata)))
#		elif self.n_dimensions == 2:
		cpscolors = np.array(self.registry['cps']['voiceID'], dtype=float)
		cpscolors /= np.max(cpscolors)
		cmap = cm.get_cmap('tab20')
		cpscolors = [cmap(c) for c in cpscolors]

		self.sc = self.ax.scatter(self.reduceddata[self.registry['cps']['span'][0]:self.registry['cps']['span'][1],0], self.reduceddata[self.registry['cps']['span'][0]:self.registry['cps']['span'][1]:,1], color=cpscolors, s=5)
		# annotation stuff
		self.annot = self.ax.annotate("", xy=(0,0), xytext=(20,20), textcoords="offset points", bbox=dict(boxstyle="round", fc="w"), arrowprops=dict(arrowstyle="->"))
		self.annot.set_visible(False)
		self.annot_last_hover_play = None
		self.fig.canvas.mpl_connect("motion_notify_event", self.hover)
		self.fig.canvas.mpl_connect('button_press_event', self)
		
#		elif self.n_dimensions == 3:
#			ax = self.fig.add_subplot(111, projection='3d')
#			ax.scatter(self.reduceddata[:,0], self.reduceddata[:,1], self.reduceddata[:,2], s=100)
		plt.title(self.title, fontsize=12)
		plt.xlim([self.min[0]-1, self.max[0]+1])
		plt.ylim([self.min[1]-1, self.max[1]+1])
		
		if path == None: plt.show()
		else: plt.savefig(path)


	def hover(self, event):
		vis = self.annot.get_visible()
		if event.inaxes == self.ax:
			cont, ind = self.sc.contains(event)
			if cont and ind["ind"][0] != self.annot_last_hover_play:
				cps = self.registry['cps']['segobjs'][ind["ind"][0]]
				atk = cps.envAttackSec*1000
				dec = cps.envDecaySec*1000
				liblo.send(self.osc_target, str(cps.soundfileChns), cps.filename, cps.segmentStartSec*1000, cps.segmentEndSec*1000, atk, cps.segmentDurationSec*1000-atk-dec, dec, util.dbToAmp(cps.envDb))

				if False:
					# make label appear
					self.annot.xy = self.sc.get_offsets()[ind["ind"][0]]
					self.annot.set_text("{}".format(self.registry['cps']['cps_annotations'][ind["ind"][0]]))
					#self.annot.get_bbox_patch().set_facecolor(cmap(norm(c[ind["ind"][0]])))
					self.annot.get_bbox_patch().set_alpha(0.4)
					self.annot.set_visible(True)
				self.annot_last_hover_play = ind["ind"][0]
			else:
				if vis:
					self.annot.set_visible(False)
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

