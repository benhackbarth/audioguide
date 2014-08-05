TARGET = tsf('soundfiles/cage.aiff', thresh=-32, rise=1.2)

CORPUS = [
csf('/Users/ben/Documents/audioGuide/examples/lachenmann.aiff'),
]

SUPERIMPOSE = si(maxSegment=4) # -> this variable is explained in depth in 03-superimposition.py



# the SEARCH variable is a list of spass objects.  each spass object searches through a list of corpus segments and returns a shorter list, passing the result to the next spass object.  organising descriptor searches this way is very powerful, and gives the user much more control over the resulting concatenation.  consider two possible SEARCHes, both of which use effDur-seg and mfccs:


SEARCH = [
spass('closest', d('mfccs', weight=0.5), d('effDur-seg', norm=1, weight=0.5))
]

SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), percent=25),
spass('closest', d('mfccs'))
]


