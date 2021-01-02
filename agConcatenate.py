#!/usr/bin/env python3
############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################


import sys, os, audioguide

from optparse import OptionParser
parser = OptionParser(usage="usage: %prog [options] optionsfile")
parser.set_defaults(INTERACTIVE=False)
parser.add_option("-i", "--interactive", action="store_true", dest="INTERACTIVE", help="This flag turns on intercative mode.")
(options, args) = parser.parse_args()



if len(args) == 0:
	print('\nPlease specify an options file as the first argument\n')
	sys.exit(1)
opspath = os.path.realpath(args[0])
if not os.path.exists(opspath):
	print('\nCouldn\'t find an options called "%s"\n'%sys.argv[1])
	sys.exit(1)


ag = audioguide.main()
ops_mtime = ag.parse_options_file(opspath, init=True)
ag.execute()


if options.INTERACTIVE:
	import time
	print("Ready..")
	try:
		while True:
			time.sleep(0.1)
			if not os.path.exists(opspath):
				print("\nYour options file disappeared!\n")
				sys.exit(0)
			mtime_cur = os.path.getmtime(opspath)
			if mtime_cur != ops_mtime:
				ops_mtime = ag.parse_options_file(opspath)
				ag.execute()
				print("Done. Ready..")
			ops_mtime = mtime_cur
	except KeyboardInterrupt:
		sys.exit(0)