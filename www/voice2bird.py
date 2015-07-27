TARGET = tsf('/Users/ben/Documents/audioguide/targets/cageTarget.aiff', thresh=-26, offsetRise=1.5)

CORPUS = [csf('/Users/ben/Documents/audioguide/corpi/birds.aiff')]

SEARCH = [
spass('ratio_limit', d('effDur-seg'), minratio=0.7, maxratio=1.1),
spass('closest_percent', d('power-seg'), percent=60),
spass('closest_percent', d('mfccs-seg', norm=2), percent=20),
spass('closest', d('centroid-delta', norm=1))
]

SUPERIMPOSE = si(maxSegment=1)

CSOUND_RENDER_FILEPATH = '/Users/ben/Documents/audioguide/www/voice2bird.aiff'