#!/usr/bin/env python
############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys, os, audioguide


# import classes to let us write the options with ag.set_option()
from audioguide.userclasses import TargetOptionsEntry as tsf
from audioguide.userclasses import CorpusOptionsEntry as csf
from audioguide.userclasses import SuperimpositionOptionsEntry as si
from audioguide.userclasses import SearchPassOptionsEntry as spass
from audioguide.userclasses import SingleDescriptor as d


################################################################################
## below are options similar to example 1. note the classes imported from     ##
## audioguide.userclasses.                                                    ##
################################################################################
ag = audioguide.main()
ag.set_option('TARGET', tsf('examples/cage.aiff', thresh=-25, offsetRise=1.5))
ag.set_option('CORPUS', [csf('examples/lachenmann.aiff', limit='centroid-seg < 50%')])
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


################################################################################
## There are two ways to run audioguide via the api. The first, ag.execute,   ##
## is simpler. It keeps track of any changes to the concatenation options,    ##
## and, when you run ag.execute, it will only runs the parts of the code      ##
## needed to create new output files. Thus, you can run ag.execute, change    ##
## output file variables and run ag.execute again and it will only run the    ##
## output file portion of the code. The second way is calling individual      ##
## functions to execute different steps of the algorithm -                    ##
## ag.initialize_analysis_interface, ag.load_target,                          ##
## ag.write_target_output_files, ag.load_corpus, ag.normalize,                ##
## ag.standard_concatenate, and ag.write_concatenate_output_files.            ##
################################################################################


####################################
## Let's look at ag.execute first ##
####################################

files = ag.execute(print_steps=True)

print("Wrote output files:")
for k, v in files.items(): print("\t%s -> %s"%(k, v))


#################################################
## if you call it again, it won't do anything. ##
#################################################
files = ag.execute(print_steps=True)


################################################################################
## however, if you change some options, ag.execute will run the parts of the  ##
## code needed to account for the changed options                             ##
################################################################################
ag.set_option('TARGET', tsf('examples/bone.aiff', thresh=-25, offsetRise=1.5))
ag.set_option('SEARCH', [spass('closest', d('centroid'))])
ag.set_option('CSOUND_RENDER_FILEPATH', 'output/output2.aiff')

files = ag.execute(print_steps=True)
print("Wrote output files:")
for k, v in files.items(): print("\t%s -> %s"%(k, v))





################################################################################
## Now let's look at the more complicated method involving discrete function  ##
## calls                                                                      ##
################################################################################

# here, instead of using ag.execute(), we'll call individual program functions separately.
ag.initialize_analysis_interface()
ag.load_target()
ag.write_target_output_files()

# let's look at our target segs!
for ts in ag.tgt.segs:
	print("target segment from %.2f - %.2f: power-seg=%f, centroid-seg=%.2f mfcc1[0:4]=%s"%(ts.segmentStartSec, ts.segmentEndSec, ts.desc.get("power-seg"), ts.desc.get("centroid-seg"), ts.desc.get("mfcc1")[0:4]))

# now let's load our corpus...
ag.load_corpus()
# and look at our corpus segs!
for cs in ag.cps.postLimitSegmentNormList:
	print("corpus segment from %.2f - %.2f: power-seg=%f, centroid-seg=%.2f mfcc1[0:4]=%s"%(cs.segmentStartSec, cs.segmentEndSec, cs.desc.get("power-seg"), cs.desc.get("centroid-seg"), cs.desc.get("mfcc1")[0:4]))



ag.normalize()
ag.standard_concatenate()
files = ag.write_concatenate_output_files()

# let's look at the selected sound segments, held in a list called ag.outputEvents:
print("%i OUTPUT EVENTS"%(len(ag.outputEvents)))

for eobj in ag.outputEvents:
	print('\toutput event: %.2f %s@%f'%(eobj.timeInScore, eobj.filename, eobj.sfSkip))
	#other attributes
#	for attr in ['cpsduration', 'duration', 'dynamicFromFilename', 'effDurSec', 'envAttackSec', 'envDb', 'envDecaySec', 'envSlope', 'midi', 'peaktimeSec', 'powerSeg', 'rmsSeg', 'selectedInstrumentIdx', 'selection_cnt', 'sfSkip', 'sfchnls', 'simSelects', 'stretchcode', 'tgtsegdur', 'tgtsegnumb', 'tgtsegpeak', 'tgtsegstart', 'transposition', 'voiceID']:
#		print('\t', attr, ':', getattr(eobj, attr))

#	you can get descriptor data this way
#	print('\tAverage centroid for this segment vs average centroid for target segment: %.3f %.3f'%(eobj.sfseghandle.desc.get('centroid-seg'), eobj.tgtsfseghandle.desc.get('centroid-seg')))
#	print('\tmfcc1 for this segment vs the target segment: %s %s'%(eobj.sfseghandle.desc.get('mfcc1'), eobj.tgtsfseghandle.desc.get('mfcc1')))



