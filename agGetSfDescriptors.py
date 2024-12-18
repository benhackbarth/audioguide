#!/usr/bin/env python3
############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################


import sys, os, audioguide, json

#######################
## find options file ##
#######################
if len(sys.argv) < 3:
	print('\nPlease specify a soundfile as the first argument, and a json dict to create as a second argument\n')
	sys.exit(1)
file = os.path.realpath(sys.argv[1])
outputfile = os.path.realpath(sys.argv[2])
if not os.path.exists(file):
	print('\nCouldn\'t find a soundfile called "%s"\n'%file)
	sys.exit(1)


# import classes to let us write the options as a dictionary
from audioguide.userclasses import TargetOptionsEntry as tsf

optionsDictionary = {
'TARGET': tsf(file),
'VERBOSITY': 0, # <- turn off printing to the console!
}


ag = audioguide.main()
ag.parse_options_dict(optionsDictionary)
ag.ops.SEARCH_PATHS.append(os.path.dirname(__file__))
ag.initialize_analysis_interface()
ag.load_target()
ag.tgt.whole.desc.writedict(outputfile, ag.AnalInterface)
