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


# same as example 1..
optionsDictionary = {
'TARGET': tsf('examples/cage.aiff', thresh=-25, offsetRise=1.5),
'CORPUS': [csf('examples/lachenmann.aiff')],
'SEARCH': [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=25),
spass('closest', d('mfccs'))],
'SUPERIMPOSE': si(maxSegment=6),
'VERBOSITY': 0, # <- turn off printing to the console!
'CSOUND_PLAY_RENDERED_FILE': False, # don't play the rendered file at the commandline
}

ag = audioguide.main()
ag.parse_options_dict(optionsDictionary)
ag.load_target()
ag.write_target_output_files()
ag.load_corpus()
ag.normalize()
ag.standard_concatenate()

print("selected events")
for eobj in ag.outputEvents:
	# ['classification', 'cpsduration', 'duration', 'dynamicFromFilename', 'effDurSec', 'envAttackSec', 'envDb', 'envDecaySec', 'envSlope', 'extraDataFromSegmentationFile', 'filename', 'instrParams', 'instrTag', 'makeCsoundOutputText', 'makeDictOutput', 'makeLabelText', 'makeLispText', 'makeMaxMspListOutput', 'makeSegmentationDataText', 'metadata', 'midi', 'midiVelocity', 'peaktimeSec', 'powerSeg', 'printName', 'rmsSeg', 'selectedInstrumentIdx', 'selection_cnt', 'sfSkip', 'sfchnls', 'sfseghandle', 'simSelects', 'stretchcode', 'tgtsegdur', 'tgtsegnumb', 'tgtsegpeak', 'tgtsegstart', 'timeInScore', 'transposition', 'transratio', 'voiceID']
	print(eobj.timeInScore, eobj.filename)

files = ag.write_concatenate_output_files()

print("wrote output files:", files)

