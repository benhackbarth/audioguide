############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

__author__ = "Benjamin Hackbarth, Norbert Schnell, Philippe Esling, Diemo Schwarz, Gilbert Nouno"
__author_email__ = "hackbarth@gmail.com"
__version__ = "1.41"

import sys, os, platform
	
	
def setup(scriptpath):
	defaultpath = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'defaults.py')
	if sys.maxsize > 2**32: bits = 64
	else: bits = 32
	libpath = os.path.join(scriptpath, 'audioguide', 'pylib%i.%i-%s-%i'%(sys.version_info[0], sys.version_info[1], platform.system().lower(), bits))
	return defaultpath, libpath


def optionsfiletest(argv):
	if len(argv) == 1:
		print('\nPlease specify an options file as the first argument\n')
		sys.exit(1)
	opspath = os.path.realpath(sys.argv[1])
	if not os.path.exists(opspath):
		print('\nCouldn\'t find an options called "%s"\n'%sys.argv[1])
		sys.exit(1)
	return opspath








class main:
	from audioguide import concatenativeclasses, simcalc, userinterface, util, descriptordata, anallinkage, musicalwriting

	def __init__(self):
		if sys.maxsize > 2**32: bits = 64
		else: bits = 32
		libpath = os.path.join(os.path.dirname(__file__), 'audioguide', 'pylib%i.%i-%s-%i'%(sys.version_info[0], sys.version_info[1], platform.system().lower(), bits))
		sys.path.append(libpath)


	def initialize_options(self, opsdata):
		'''opsdata may be a dict or filepath string'''
		opspath = optionsfiletest(sys.argv)
		###########################################
		## LOAD OPTIONS AND SETUP SDIF-INTERFACE ##
		###########################################
		ops = concatenativeclasses.parseOptions(opsfile=opspath, defaults=defaultpath, scriptpath=os.path.dirname(__file__))
		if 'concateMethod' in ops.EXPERIMENTAL and ops.EXPERIMENTAL['concateMethod'] == 'framebyframe':
			util.error("CONFIG", "Frame by frame concatenation is only possible with the agConcatenateFrames.py script.")
		p = userinterface.printer(ops.VERBOSITY, os.path.dirname(__file__), ops.HTML_LOG_FILEPATH)
		p.printProgramInfo(audioguide.__version__)
		AnalInterface = ops.createAnalInterface(p)


	def load_target():
		############
		## TARGET ##
		############
		p.logsection( "TARGET" )
		tgt = audioguide.sfsegment.target(ops.TARGET, AnalInterface)
		tgt.initAnal(AnalInterface, ops, p)
		tgt.stageSegments(AnalInterface, ops, p)

		# experimental
		#tgt.peakdata = AnalInterface.analize_spectralPeaks(tgt.filename, fftsize=2048)
		#for s in tgt.segs:
		#	s.peaks = []
		#	for time, partials in tgt.peakdata['peaks']:
		#		if time >= s.segmentStartSec and time <= s.segmentEndSec:
		#			s.peaks.extend(partials)

		if len(tgt.segs) == 0:
			util.error("TARGET FILE", "no segments found!  this is rather strange.  could your target file %s be digital silence??"%(tgt.filename))
		p.log("TARGET SEGMENTATION: found %i segments with an average length of %.3f seconds"%(len(tgt.segs), np.average(tgt.seglengths)))
		#######################
		## target label file ##
		#######################
		if ops.TARGET_SEGMENT_LABELS_FILEPATH != None:
			tgt.writeSegmentationFile(ops.TARGET_SEGMENT_LABELS_FILEPATH)
			p.log( "TARGET: wrote segmentation label file %s"%ops.TARGET_SEGMENT_LABELS_FILEPATH )
		#############################
		## target descriptors file ##
		#############################
		if ops.TARGET_DESCRIPTORS_FILEPATH != None:
			outputdict = tgt.whole.desc.getdict()
			outputdict['frame2second'] = AnalInterface.f2s(1)
			fh = open(ops.TARGET_DESCRIPTORS_FILEPATH, 'w')
			json.dump(outputdict, fh)
			fh.close()
			p.log("TARGET: wrote descriptors to %s"%(ops.TARGET_DESCRIPTORS_FILEPATH))
		##############################
		## target descriptor graphs ##
		##############################
		if ops.TARGET_PLOT_DESCRIPTORS_FILEPATH != None:
			tgt.plotMetrics(ops.TARGET_PLOT_DESCRIPTORS_FILEPATH, AnalInterface, p)
		###############################
		## target segmentation graph ##
		###############################
		if ops.TARGET_SEGMENTATION_GRAPH_FILEPATH != None:
			tgt.plotSegmentation(ops.TARGET_SEGMENTATION_GRAPH_FILEPATH, AnalInterface, p)

		descriptors = []
		dnames = []
		for dobj in AnalInterface.requiredDescriptors:
			if dobj.seg or dobj.name in ['power']: continue
			d = np.array(tgt.whole.desc[dobj.name][:])
			d -= np.min(d)
			d /= np.max(d)
			d = np.around(d, 2)
	
			descriptors.append(d)
			dnames.append(dobj.name)
		p.html.jschart_timeseries(yarray=np.array([AnalInterface.f2s(i) for i in range(tgt.whole.lengthInFrames)]), xarrays=descriptors, ylabel='time in seconds', xlabels=dnames)


