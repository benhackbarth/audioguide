#!/usr/bin/env python
############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os, audioguide


# import classes to let us write the options as a dictionary
from audioguide.userclasses import TargetOptionsEntry as tsf
from audioguide.userclasses import CorpusOptionsEntry as csf
from audioguide.userclasses import SuperimpositionOptionsEntry as si
from audioguide.userclasses import SearchPassOptionsEntry as spass
from audioguide.userclasses import SingleDescriptor as d


################################################################################
## below are the same options as example 1, except written as a python        ##
## dictionary instead of as a textfile. note the classes imported from        ##
## audioguide.userclasses.                                                    ##
################################################################################
ag = audioguide.main()
ag.set_option('TARGET', tsf('examples/cage.aiff', thresh=-25, offsetRise=1.5)) # set options this way
ag.set_option('CORPUS', [csf('examples/lachenmann.aiff')])
ag.set_option('SUPERIMPOSE', si(maxSegment=5))
ag.set_option('VERBOSITY', 0)
ag.set_option('CSOUND_PLAY_RENDERED_FILE', False)


for descriptor in ['centroid', 'mfccs', 'flatnesses']:
	ag.set_option('SEARCH', [spass('closest', d(descriptor))])
	ag.set_option('CSOUND_RENDER_FILEPATH', 'output/output-%s.aiff'%descriptor) # here we'll change the output csound soundfile name
	
	files = ag.execute() # you can embed this in a loop - it only runs the parts of the program that are needed given any options changes.
	
	print("SELECTED EVENTS")
	# selected corpus sounds are stored as a list in ag.outputEvents. each output event is an object:
	for eobj in ag.outputEvents:
		print('\nOUTPUT EVENT', eobj.timeInScore, eobj.filename)
		# other attributes
		#for attr in ['cpsduration', 'duration', 'dynamicFromFilename', 'effDurSec', 'envAttackSec', 'envDb', 'envDecaySec', 'envSlope', 'midi', 'peaktimeSec', 'powerSeg', 'rmsSeg', 'selectedInstrumentIdx', 'selection_cnt', 'sfSkip', 'sfchnls', 'simSelects', 'stretchcode', 'tgtsegdur', 'tgtsegnumb', 'tgtsegpeak', 'tgtsegstart', 'transposition', 'voiceID']:
		#	print('\t', attr, ':', getattr(eobj, attr))
		# you can get descriptor data this way
		print('\tAverage centroid for this segment vs average centroid for target segment: %.3f %.3f'%(eobj.sfseghandle.desc.get('centroid-seg'), eobj.tgtsfseghandle.desc.get('centroid-seg')))
		print('\tmfcc1 for this segment vs the target segment: %s %s'%(eobj.sfseghandle.desc.get('mfcc1'), eobj.tgtsfseghandle.desc.get('mfcc1')))


	print("\n\nwrote output files:", files)

