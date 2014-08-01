__author__ = "Benjamin Hackbarth, Norbert Schnell, Philippe Esling, Diemo Schwarz, Gilbert Nouno"
__author_email__ = "b.hackbarth@liv.ac.uk"
__version__ = "1.1.0"


	
	
def setup(scriptpath):
	import sys, os, platform
	defaultpath = os.path.join(scriptpath, 'audioguide', 'defaults.py')
	if sys.maxsize > 2**32: bits = 64
	else: bits = 32
	libpath = os.path.join(scriptpath, 'audioguide', 'pylib%i.%i-%s-%i'%(sys.version_info[0], sys.version_info[1], platform.system().lower(), bits))

	return defaultpath, libpath