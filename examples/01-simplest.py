###########################################################################
## To run this example, you first need to segment the soundfile          ##
## lachenmann.aiff by running the following command:                     ##
##                                                                       ##
## python3 agSegmentSf.py examples/lachenmann.aiff                       ##
##                                                                       ##
## Then run concatenation script specifying this file as the options     ##
## file for agConcatenate.py:                                            ##
##                                                                       ##
## python3 agConcatenate.py examples/01-simplest.py                      ##
##                                                                       ##
###########################################################################


TARGET = tsf('cage.aiff', thresh=-25, offsetRise=1.5)

CORPUS = [
csf('lachenmann.aiff'),
] # CORPUS documented in 04-corpus.py

SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=25),
spass('closest', d('mfccs'))
]

SUPERIMPOSE = si(maxSegment=6) # SUPERIMPOSE documented in 03-superimposition.py
