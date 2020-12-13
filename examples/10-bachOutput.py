################################################################################
## Audioguide automatically creates an output file for every concatenation    ##
## that may be loaded into a bach.roll in Max/MSP. The path for the bach      ##
## output file, which is output/bach_roll.txt by default, is controlable by   ##
## the BACH_FILEPATH variable. You may visualize, explore, and playback       ##
## concatenated sounds with the patch maxmsp/bach/main.maxpat.                ##
################################################################################

################################################################################
## Please note that this example shows only the simplest interaction with     ##
## Bach. Example 11 details AudioGuide's INSTRUMENTS infrastructure, which    ##
## let's you create acoustic scores.                                          ##
################################################################################


TARGET = tsf('cage.aiff', end=1, thresh=-26, offsetRise=2)

CORPUS = [csf('heat sink.aiff'), csf('lachenmann.aiff'),]


SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=20),
spass('parser', 'zeroCross-seg > 50%', 'closest_percent', [d('flatnesses-seg')], [d('centroid-seg')], percent=20),
spass('closest', d('mfccs'))
]


SUPERIMPOSE = si(maxSegment=5)

BACH_INCLUDE_TARGET = True
# if BACH_INCLUDE_TARGET is True, the segments of the target sound will be placed into Bach voice 1. All sounds from the corpus will be placed into subsequent voices according to their csf() index in CORPUS. In other words, heat sink will be place in voice 2 and lachenmann in voice 3. 

# you can customize the staff type of the target sound and corpus sounds
BACH_TARGET_STAFF = 'F'
BACH_CORPUS_STAFF = 'FG'


# Uncomment below to customize what data is placed into which bach slots. A full list of the keywords that you can use here is given in the "Bach Slots" section of the documentation. We'll also add some segmented descriptors so that we can access sound descriptor values from within Max. You can add a single averaged descriptor for a bach float slot, a list of averaged descriptors for a bach floatlist, or a time-varying descriptor for a bach floatlist.
BACH_SLOTS_MAPPING = {1: 'fullpath', 2: 'sfskiptime', 3: 'sfchannels', 4: 'env', 10: 'sftransposition', 11: ['centroid-seg', 'centroid-minseg', 'centroid-maxseg', 'centroid-stdseg', 'centroid-kurtseg', 'centroid-skewseg'], 13: 'power-seg'}