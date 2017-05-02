TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)
CORPUS = [csf('lachenmann.aiff'), csf('heat sink.aiff'), csf('dream.aiff')]
SUPERIMPOSE = si(maxSegment=1)


################################################################################
## The SEARCH variable is a list of spass objects.  Each Audiogude file may   ##
## have only one SEARCH variable.  If there are mutiple SEARCH varibles       ##
## defined, the last one will be used.  Each spass object in the SEARCH list  ##
## looks through the list of corpus segments and selects certain corpus       ##
## sounds while rejecting others.  An spass() therefore returns a shorter     ##
## list, passing it on to the next spass object.  Therefore the first spass() ##
## in SEARCH examines the entire corpus while the last one selects the        ##
## "winning" segment.  Organising descriptor searches this way is very        ##
## powerful and gives the user a lot of control over possible concatenations. ##
## Consider the two possible SEARCHes below, both of which use the effDur-seg ##
## and mfccs descriptors.  The first is only one spass() long: it will        ##
## examine the entire corpus according to a combination of how well the mfccs ##
## and effDur-seg of each corpus sound matches the target segment.  The       ##
## second SEARCH has two spass()es: the first selects the best matching 25%   ##
## of corpus sounds according to their effDur-seg and then the second spass   ##
## selects the best sound of the remaining sounds according to mfccs.  In     ##
## general, if the segments in target and corpus have similar durations, a    ##
## good strategy is to have 1 or 2 spass() objects that address temporality   ##
## first - effDur-seg, power-seg, power-mean-seg, power-slope-seg, etc. -     ##
## then additional spass() objects that match timbre - mfccs, centroid,       ##
## flatnesses, etc.                                                           ##
################################################################################

SEARCH = [
spass('closest', d('mfccs'), d('effDur-seg', norm=1))
]

#SEARCH = [
#spass('closest_percent', d('effDur-seg', norm=1), percent=25),
#spass('closest', d('mfccs'))
#]



################################################################################
## Additional examples below examine different strategies for arranging       ##
## spass() objects within the SEARCH variable.  Remember that an spass object ##
## may take any number of descriptors and that keyword arguments, including   ##
## descriptor weighting, are documented in the read me.pdf.                   ##
################################################################################
#SEARCH = [
#spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=25), # only the 25% best matching segments make it through to the next spass()
#spass('closest', d('flatnesses-seg')) # picks a winning segment.
#]


################################################################################
## When the final spass() object yields multiple samples, as is the case here ##
## since 'closest_percent' gives the best matching percentage of the corpus,  ##
## AudioGuide selects between segments randomly.  Thus each time you run the  ##
## software you get different result.  The SEED argument can be used to set   ##
## the pseudo random seed.                                                    ##
################################################################################
#SEARCH = [
#spass('closest_percent', d('centroid-seg', norm=1), percent=10), # will select a corpus sound randomly between the best matching 10% of corpus sounds
#]



################################################################################
## Sometimes duration may not matter at all.  Here, the SEARCH list has a     ##
## first spass() which matches pitch (using f0-seg) as a ratio.               ##
################################################################################
#SEARCH = [
#spass('ratio_limit', d('f0-seg'),  minratio=0.943, maxratio=1.059), # only corpus segments within a semitone of the target segment's f0 get past.
#spass('closest', d('power-seg'), d('power-slope-seg')) # picks a winning segment.
#]


################################################################################
## SEARCH can also yield the "worst" matching segment.  Note that this isn't  ##
## at all uncorrelated with the target's descriptors; rather, the farthest    ##
## segment is a sort of inverse of the target's values.                       ##
################################################################################
#SEARCH = [
#spass('farthest', d('centroid-seg')) # picks the segment with the most distance centroid when compared to target segments.
#]
