TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)
CORPUS = [csf('lachenmann.aiff'), csf('heat sink.aiff'), csf('dream.aiff')]
SUPERIMPOSE = si(maxSegment=4) # -> this variable is explained in depth in 03-superimposition.py



# the SEARCH variable is a list of spass objects.  each spass object searches through a list of corpus segments and returns a shorter list, passing the result to the next spass object.  organising descriptor searches this way is very powerful, and gives the user much more control over the resulting concatenation.  consider two possible SEARCHes, both of which use effDur-seg and mfccs (uncomment one to hear tha effect):


#SEARCH = [
#spass('closest', d('mfccs', weight=0.5), d('effDur-seg', norm=1, weight=0.5))
#]
#
#SEARCH = [
#spass('closest_percent', d('effDur-seg', norm=1), percent=25),
#spass('closest', d('mfccs'))
#]



# in general, if the segments in target and corpus have similar sizes, a good strategy is to have 1 or 2 spass() objects that address temporality - effDur-seg, power-seg, power-mean-seg, power-slope-seg, etc. - then additional spass(objects that match timbre - mfccs, centroid, flatnesses, etc.)

SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=25),
spass('closest', d('flatnesses-seg'))
]
