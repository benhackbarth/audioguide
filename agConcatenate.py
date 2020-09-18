#!/usr/bin/env python
############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################


import sys, os, audioguide


if len(sys.argv) == 1:
	print('\nPlease specify an options file as the first argument\n')
	sys.exit(1)
opspath = os.path.realpath(sys.argv[1])
if not os.path.exists(opspath):
	print('\nCouldn\'t find an options called "%s"\n'%sys.argv[1])
	sys.exit(1)



ag = audioguide.main()
ag.parse_options_file(opspath)
ag.load_target()
ag.write_target_output_files()
ag.load_corpus()
ag.normalize()
ag.standard_concatenate()
ag.write_concatenate_output_files()
