__author__ = "Benjamin Hackbarth, Norbert Schnell, Philippe Esling, Diemo Schwarz, Gilbert Nouno"
__author_email__ = "b.hackbarth@liv.ac.uk"
__version__ = "1.1.4"

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

