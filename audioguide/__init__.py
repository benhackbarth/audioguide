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








class concatenate:

	def __init__(self, ):
		defaultpath, libpath = setup(os.path.dirname(__file__))
		opspath = optionsfiletest(sys.argv)
		sys.path.append(libpath)
		# import audioguide's submodules
		from audioguide import sfsegment, concatenativeclasses, simcalc, userinterface, util, descriptordata, anallinkage, musicalwriting
		# import other modules
		import numpy as np
		import json
		
		###########################################
		## LOAD OPTIONS AND SETUP SDIF-INTERFACE ##
		###########################################
		ops = concatenativeclasses.parseOptions(opsfile=opspath, defaults=defaultpath, scriptpath=os.path.dirname(__file__))
		if 'concateMethod' in ops.EXPERIMENTAL and ops.EXPERIMENTAL['concateMethod'] == 'framebyframe':
			util.error("CONFIG", "Frame by frame concatenation is only possible with the agConcatenateFrames.py script.")


		p = userinterface.printer(ops.VERBOSITY, os.path.dirname(__file__), ops.HTML_LOG_FILEPATH)
		p.printProgramInfo(audioguide.__version__)
		AnalInterface = ops.createAnalInterface(p)
		p.middleprint('SOUNDFILE CONCATENATION')




	def initalize_target(self, ):
		pass


	def initalize_corpus(self, ):
		pass


	def normalize(self, ):
		pass

	def initalize_concatenate(self, ):
		pass


	def concatenate(self, ):
		pass


	def render(self, ):
		pass
