TARGET = tsf('soundfiles/cage.aiff', thresh=-32, rise=1.2)

CORPUS = [
csf('/Users/ben/Documents/audioGuide/examples/lachenmann.aiff'),
]


SEARCH = [
#spass('ratio_limit', d('effDur-seg', norm=1), minratio=0.9, maxratio=1.1),
spass('closest_percent', d('power-seg', norm=2), percent=10),
spass('closest', d('mfccs'))
]

#  Here we set the superimpose object to only allow one corpus segment to be selected for each target segment (maxSegment=1).  Since the first spass in SEARCH is using the descriptor effDur-seg, we can except to have somewhat similar durations for the selected corpus segments.  However, note that this might not be true, in particular if you use a corpus will wildly different segment durations that your target.  If you don't care about duration, you can remove the first spass object from SEARCH.  If you want durations to be rendered to match the target more precisely, see below.
SUPERIMPOSE = si(maxSegment=10, minSegment=1)

