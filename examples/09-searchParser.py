TARGET = tsf('cage.aiff', thresh=-26, offsetRise=2)

CORPUS = [csf('heat sink.aiff'), csf('lachenmann.aiff'),]


#SEARCH = [
## for the loudest 50% of target segements, use corpus ID 1; otherwise use ID 2
#spass('parser', 'power-seg > 50%', 'corpus_select', [0], [1]),
#spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=20),
#spass('closest', d('mfccs'))
#]



SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=20),
spass('parser', 'zeroCross-seg > 50%', 'closest_percent', [d('flatnesses-seg')], [d('centroid-seg')], percent=20), # for the 50% of target segements with the highest zerocrossing, pick the best 20% matching corpus sound using flatnesses; otherwise use centroid
spass('closest', d('mfccs'))
]


SUPERIMPOSE = si(maxSegment=1)
