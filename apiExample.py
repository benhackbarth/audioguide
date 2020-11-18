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
optionsDictionary = {
'TARGET': tsf('examples/cage.aiff', thresh=-25, offsetRise=1.5),
'CORPUS': [csf('examples/lachenmann.aiff')],
'SEARCH': [spass('closest', d('centroid-seg', norm=1))],
'SUPERIMPOSE': si(maxSegment=1),
'VERBOSITY': 0, # <- turn off printing to the console!
'CSOUND_PLAY_RENDERED_FILE': False, # don't play the rendered file at the commandline
}


ag = audioguide.main()
ag.parse_options_dict(optionsDictionary)
ag.ops.SUPERIMPOSE = si(maxSegment=2) # <- change options this way
ag.load_target()
ag.write_target_output_files()
ag.load_corpus()
ag.normalize()
ag.standard_concatenate()

print("selected events")
for eobj in ag.outputEvents:
	print('\nOUTPUT EVENT', eobj.timeInScore, eobj.filename)
	for attr in ['cpsduration', 'duration', 'dynamicFromFilename', 'effDurSec', 'envAttackSec', 'envDb', 'envDecaySec', 'envSlope', 'midi', 'peaktimeSec', 'powerSeg', 'rmsSeg', 'selectedInstrumentIdx', 'selection_cnt', 'sfSkip', 'sfchnls', 'simSelects', 'stretchcode', 'tgtsegdur', 'tgtsegnumb', 'tgtsegpeak', 'tgtsegstart', 'transposition', 'voiceID']:
		print('\t', attr, ':', getattr(eobj, attr))
	# get descriptor data this way
	print('\tAverage centroid for this segment vs average centroid for target segment: %.3f %.3f'%(eobj.sfseghandle.desc.get('centroid-seg'), eobj.tgtsfseghandle.desc.get('centroid-seg')))


files = ag.write_concatenate_output_files()

print("\n\nwrote output files:", files)

