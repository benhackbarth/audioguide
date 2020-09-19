################################################################################
## this file shows how to interact with the limited python api. here the      ##
## options for concatenation are written directly into the code as a          ##
## dictionary. these options are parsed, and the target and corpus sounds are ##
## loaded. then the search variable is overridden to create different         ##
## concatenations with different descriptors. note that the output soundfile  ##
## path is also overridden, giving each variation a unique filename.          ##
################################################################################

import sys, os, audioguide
# these class imports support writing options directly into the code
from audioguide.userclasses import TargetOptionsEntry as tsf
from audioguide.userclasses import CorpusOptionsEntry as csf
from audioguide.userclasses import Instrument as instr
from audioguide.userclasses import Score as score
from audioguide.userclasses import SearchPassOptionsEntry as spass
from audioguide.userclasses import SuperimpositionOptionsEntry as si
from audioguide.userclasses import SingleDescriptor as d


myoptions = {
'TARGET': tsf('/Users/ben/Documents/audioguide/examples/cage.aiff', thresh=-25, offsetRise=1.5),
'CORPUS': [csf('/Users/ben/Documents/audioguide/examples/lachenmann.aiff')],
'SEARCH': [spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=25), spass('closest', d('mfccs'))],
'SUPERIMPOSE': si(maxSegment=6),
'CSOUND_PLAY_RENDERED_FILE': False
}



ag = audioguide.main()
ag.parse_options_dict(myoptions)
ag.load_target()
ag.load_corpus()

for dname in ['chromas', 'chromas-seg', 'f0', 'f0-seg', 'harmonicoddevenratio', 'harmonicoddevenratio-seg', 'harmoniccentroid', 'harmoniccentroid-seg', 'harmonicdecrease', 
'harmonicdecrease-seg', 'harmonicdeviation', 'harmonicdeviation-seg', 'harmonickurtosis', 'harmonickurtosis-seg', 'harmonicrolloff', 'harmonicrolloff-seg', 'harmonicskewness', 'harmonicskewness-seg', 'harmonicslope', 'harmonicslope-seg', 'harmonicspread', 'harmonicspread-seg', 'harmonicvariation', 'harmonicvariation-seg', 'inharmonicity', 'inharmonicity-seg', 'noisiness', 'noisiness-seg', 'perceptualoddtoevenratio', 'perceptualoddtoevenratio-seg', 'perceptualcentroid', 'perceptualcentroid-seg', 'perceptualdecrease', 'perceptualdecrease-seg', 'perceptualdeviation', 'perceptualdeviation-seg', 'perceptualkurtosis', 'perceptualkurtosis-seg', 'perceptualrolloff', 'perceptualrolloff-seg', 'perceptualskewness', 'perceptualskewness-seg', 'perceptualslope', 'perceptualslope-seg', 'perceptualspread', 'perceptualspread-seg', 'perceptualvariation', 'perceptualvariation-seg', 'sharpness', 'sharpness-seg', 'zeroCross', 'zeroCross-seg', 'centroid', 'centroid-seg', 'crests', 'crests-seg', 'decrease', 'decrease-seg', 'flatnesses', 'flatnesses-seg', 'kurtosis', 'kurtosis-seg', 'rolloff', 'rolloff-seg', 'skewness', 'skewness-seg', 'slope', 'slope-seg', 'spectralspread', 'spectralspread-seg', 'variation', 'variation-seg', 'spread', 'spread-seg',  'mfccs', 'mfccs-seg']:
	ag.ops.SEARCH = [spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=25), spass('closest', d(dname))]	
	ag.normalize()
	ag.standard_concatenate()
	ag.ops.CSOUND_RENDER_FILEPATH = 'output/output-%s.wav'%dname # changes the filename of the sound output
	ag.write_concatenate_output_files()


