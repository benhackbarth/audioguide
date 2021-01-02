TARGET = tsf('cage.aiff', thresh=-26, offsetRise=2)

CORPUS = [
csf('lachenmann.aiff', limit='centroid-seg > 90%'), # doughnut
csf('lachenmann.aiff', limit='centroid-seg < 10%'), #  corpus
]

################################################################################
## The parser spass() method toggles between two different actions            ##
## depending on a whether each target segment passes a test. Each spass() has ##
## the following parameters: spass('parser', test, submethod, ifTrue,         ##
## ifFalse)                                                                   ##
##                                                                            ##
## • test - a string which is a boolean test of a target segment's            ##
## segmented descriptor. e.g. 'power-seg > 0.1'                               ##
## • submethod - a string denoting the type of operation to perform -         ##
## possibilities are closest, closest_percent, and corpus_filter              ##
## • ifTrue - a list of items to perform if ‘test’ is True.                   ##
## • ifFalse - a list of items to perform if ‘test’ is False.                 ##
################################################################################

################################################################################
## For instance: spass('parser', 'closest', 'effDur-seg > 0.4',               ##
## [d('zeroCross')], [d('zeroCross-delta')]) # if the target sound is less    ##
## than 0.4 seconds long, pick the best corpus sound according to             ##
## zeroCrossings; otherwise pick the best sound according to the first order  ##
## difference of zeroCrossings                                                ##
##                                                                            ##
## spass('parser', 'f0-seg == 0', 'closest_percent', [d('f0')], [d('mfccs-    ##
## seg')], percent=10) # if f0-seg equals 0, return the closest 10 percent of ##
## matches to f0; otherwise return the 10 percent best matches according to   ##
## mfccs-seg                                                                  ##
##                                                                            ##
## spass('parser', 'closest', 'noisiness-seg >= 50%', [d('mfccs-seg')],       ##
## [d('f0')]) # if this target segment's noisiness is in the upper 50         ##
## percentile among all target segments, return the best matching corpus      ##
## sound according to mfccs; other use f0.                                    ##
################################################################################

################################################################################
## The third method, ‘corpus_filter’, uses the target descriptor test to      ##
## determine which items of the CORPUS list are valid: spass('parser',        ##
## 'effDur-seg > 0.4', 'corpus_filter', [0], [1, 2]) # if the effective       ##
## duration is less that 0.4 seconds, use corpus samples from argument 1 of   ##
## the corpus list; otherwise used samples from argument 2 and 3.             ##
################################################################################



SEARCH = [
# for the 50% of target segments with the highest zerocrossing, pick from cps idx 0. otherwise pick from cps idx 1
spass('parser', 'zeroCross-seg > 50%', 'corpus_select', [0], [1]), 
spass('closest', d('mfccs'))
]


SUPERIMPOSE = si(maxSegment=2)
