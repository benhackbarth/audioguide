TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)
CORPUS = [csf('lachenmann.aiff'), csf('heat sink.aiff'), csf('dream.aiff')]
SUPERIMPOSE = si(maxSegment=1)

# the SEARCH variable is a list of spass objects.  each spass object searches through the list of corpus segments and returns a shorter list, passing the result to the next spass object.  the first spass() eamines the entire corpus while the last one select the "winning" segment.  organising descriptor searches this way is very powerful, and gives the user much more control over the resulting concatenation.  consider two possible SEARCHes, both of which use effDur-seg and mfccs (uncomment one to hear the effect).  the first is only one spass long: it will examine the entire corpus and r...... NOT DONE...


#SEARCH = [
#spass('closest', d('mfccs', weight=0.5), d('effDur-seg', norm=1, weight=0.5))
#]
#
#SEARCH = [
#spass('closest_percent', d('effDur-seg', norm=1), percent=25),
#spass('closest', d('mfccs'))
#]



# in general, if the segments in target and corpus have similar durations, a good strategy is to have 1 or 2 spass() objects that address temporality first - effDur-seg, power-seg, power-mean-seg, power-slope-seg, etc. - then additional spass() objects that match timbre - mfccs, centroid, flatnesses, etc.

SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=25), # only the 25% best matching segments make it through to the next spass()
spass('closest', d('flatnesses-seg')) # picks a winning segment.
]


# other times duration may not matter at all.  here, this SEARCH list has a first spass() which matches pitch (using f0-seg) as a ratio.  then we look at power and power-slope.

SEARCH = [
spass('ratio_limit', d('f0-seg'),  minratio=0.943, maxratio=1.059), # only corpus segments within a semitone of the target segment's f0 get past.
spass('closest', d('power-seg'), d('power-slope-seg')) # picks a winning segment.
]



# SEARCH can also yield the "worst" matching segment.  Note that this isn't at all necessarily uncorrelated with the target's descriptors; rather, the furthest segment is a sort of inverse of the target's values

SEARCH = [
spass('furthest', d('centroid-seg')) # picks the segment with the most distance centroid when compared to target segments.
]
