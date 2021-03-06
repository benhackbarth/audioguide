################################################################################
## To run this example, first ensure that lachenmann.aiff and heat sink.aiff  ##
## have been segmented with agSegmentSf.py. Then execute the following        ##
## command in the terminal:                                                   ##
##                                                                            ##
## python3 agConcatenate.py examples/10-bachOutput.py                         ##
##                                                                            ##
################################################################################

################################################################################
## Audioguide automatically creates an output file for every concatenation    ##
## that may be loaded into a bach.roll in Max/MSP. The path for the bach      ##
## output file, which is output/bach_roll.txt by default, is controlable by   ##
## the BACH_FILEPATH variable. You may visualize, explore, and playback       ##
## concatenated sounds with the patch maxmsp/bach/ag_playback.maxpat.         ##
################################################################################

################################################################################
## Please note that this example shows only the simplest interaction with     ##
## Bach. Example 12 details AudioGuide's INSTRUMENTS infrastructure, which    ##
## let's you create acoustic scores.                                          ##
################################################################################


TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5) # add midiPitchMethod=60 to make the target pitches C4

CORPUS = [
csf('heat sink.aiff', onsetLen='50%', offsetLen='50%'), 
csf('lachenmann.aiff'), #, midiPitchMethod={'type': 'remap', 'method': 'centroid-seg', 'low': 40, 'high': 70}
]

SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=20),
spass('closest', d('kurtosis'))
]


SUPERIMPOSE = si(maxSegment=3)


################################################################################
## if BACH_INCLUDE_TARGET is True, the segments of the target sound will be   ##
## placed into Bach voice 1. All sounds from the corpus will be placed into   ##
## subsequent voices according to their csf() index in CORPUS. Here, any      ##
## sounds from heat sink will be place in voice 2 and lachenmann in voice 3.  ##
################################################################################
BACH_INCLUDE_TARGET = True

###############################################################################
## You can customize the staff type of the target sound and/or corpus sounds ##
###############################################################################
BACH_TARGET_STAFF = 'F'
BACH_CORPUS_STAFF = 'FG'


################################################################################
## Uncomment below to customize what data is placed into which bach slots. A  ##
## full list of the keywords that you can use here is given in the "Bach      ##
## Slots" section of the documentation. Lets's also add some segmented        ##
## descriptors so that we can access sound descriptor values from within Max. ##
## You can add a single averaged descriptor for a bach float slot, a list of  ##
## averaged descriptors for a bach floatlist, or a time-varying descriptor    ##
## for a bach floatlist.                                                      ##
################################################################################
BACH_SLOTS_MAPPING = {
1: 'fullpath', 2: 'sfskiptime', 3: 'sfchannels', 4: 'env', 5: 'transposition', 6: 'selectionnumber', # normal stuff
7: ['centroid-seg', 'centroid-minseg', 'centroid-maxseg'], # centroid stats
8: ['mfcc1-seg', 'mfcc2-seg', 'mfcc3-seg', 'mfcc4-seg', 'mfcc5-seg', 'mfcc6-seg', 'mfcc7-seg', 'mfcc8-seg', 'mfcc9-seg', 'mfcc10-seg', 'mfcc11-seg', 'mfcc12-seg'], # averaged mfccs!
9: 'power' # time-varying power
}


CSOUND_CSD_FILEPATH = None