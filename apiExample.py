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
ag.load_target()
ag.write_target_output_files()
ag.load_corpus()

for descriptor in ['centroid', 'mfccs', 'flatnesses']:
	ag.ops.SEARCH = [spass('closest', d(descriptor))] # <- change options this way (just be careful not to change an option after you run associated code. for instance, if you change the target filename, you 'll need to run ag.load_target() again).
	ag.ops.CSOUND_RENDER_FILEPATH = 'output/output-%s.aiff'%descriptor # here we'll change the output csound soundfile name to ensure that each concatenation doesn't overwrite the previous file
	ag.normalize()
	ag.standard_concatenate()
	print(ag.ops.SEARCH[0].descriptor_list, "SELECTED EVENTS")
	# selected corpus sounds are stored as a list in ag.outputEvents. each output event is an object:
	for eobj in ag.outputEvents:
		print('\nOUTPUT EVENT', eobj.timeInScore, eobj.filename)
		# other attributes
		#for attr in ['cpsduration', 'duration', 'dynamicFromFilename', 'effDurSec', 'envAttackSec', 'envDb', 'envDecaySec', 'envSlope', 'midi', 'peaktimeSec', 'powerSeg', 'rmsSeg', 'selectedInstrumentIdx', 'selection_cnt', 'sfSkip', 'sfchnls', 'simSelects', 'stretchcode', 'tgtsegdur', 'tgtsegnumb', 'tgtsegpeak', 'tgtsegstart', 'transposition', 'voiceID']:
		#	print('\t', attr, ':', getattr(eobj, attr))
		# you can get descriptor data this way
		print('\tAverage centroid for this segment vs average centroid for target segment: %.3f %.3f'%(eobj.sfseghandle.desc.get('centroid-seg'), eobj.tgtsfseghandle.desc.get('centroid-seg')))
		print('\tmfcc1 for this segment vs the target segment: %s %s'%(eobj.sfseghandle.desc.get('mfcc1'), eobj.tgtsfseghandle.desc.get('mfcc1')))


	files = ag.write_concatenate_output_files()

	print("\n\nwrote output files:", files)

