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
## below are the same options as example 1. note the classes imported from    ##
## audioguide.userclasses.                                                    ##
################################################################################
ag = audioguide.main()
ag.set_option('TARGET', tsf('examples/cage.aiff', thresh=-25, offsetRise=1.5))
ag.set_option('CORPUS', [csf('examples/lachenmann.aiff')])
ag.set_option('SEARCH', [spass('closest', d('centroid'))])
ag.set_option('SUPERIMPOSE', si(maxSegment=5))
ag.set_option('VERBOSITY', 0)
ag.set_option('CSOUND_RENDER_FILEPATH', 'output/output1.aiff')
ag.set_option('CSOUND_PLAY_RENDERED_FILE', False)
ag.set_option('TARGET_SEGMENT_LABELS_FILEPATH', None)
ag.set_option('MAXMSP_OUTPUT_FILEPATH', None)
ag.set_option('DICT_OUTPUT_FILEPATH', None)
ag.set_option('OUTPUT_LABEL_FILEPATH', None)
ag.set_option('HTML_LOG_FILEPATH', None)
ag.set_option('BACH_FILEPATH', None)




# ag.execute runs the concatenative algorithm and writes the output files.
files = ag.execute(print_steps=True)
print("\nWrote output files:")
for k, v in files.items(): print("\t%s -> %s"%(k, v))


# if you call it again, it won't do anything.
files = ag.execute(print_steps=True)

# however, if you change some options, it will ag.execute() will run the parts of the code needed to account for the changed options
ag.set_option('TARGET', tsf('examples/bone.aiff', thresh=-25, offsetRise=1.5))
ag.set_option('SEARCH', [spass('closest', d('flatnesses'))])
ag.set_option('CSOUND_RENDER_FILEPATH', 'output/output2.aiff')

files = ag.execute(print_steps=True)
print("\nWrote output files:")
for k, v in files.items(): print("\t%s -> %s"%(k, v))

# once you have run ag.execute(), you can access selected sound data with ag.outputEvents list, each output event is an object
print("%i SELECTED EVENTS"%(len(ag.outputEvents)))

for eobj in ag.outputEvents:
	print('\tevent: %.2f %s'%(eobj.timeInScore, eobj.filename))
	#other attributes
#	for attr in ['cpsduration', 'duration', 'dynamicFromFilename', 'effDurSec', 'envAttackSec', 'envDb', 'envDecaySec', 'envSlope', 'midi', 'peaktimeSec', 'powerSeg', 'rmsSeg', 'selectedInstrumentIdx', 'selection_cnt', 'sfSkip', 'sfchnls', 'simSelects', 'stretchcode', 'tgtsegdur', 'tgtsegnumb', 'tgtsegpeak', 'tgtsegstart', 'transposition', 'voiceID']:
#		print('\t', attr, ':', getattr(eobj, attr))

#	you can get descriptor data this way
#	print('\tAverage centroid for this segment vs average centroid for target segment: %.3f %.3f'%(eobj.sfseghandle.desc.get('centroid-seg'), eobj.tgtsfseghandle.desc.get('centroid-seg')))
#	print('\tmfcc1 for this segment vs the target segment: %s %s'%(eobj.sfseghandle.desc.get('mfcc1'), eobj.tgtsfseghandle.desc.get('mfcc1')))
