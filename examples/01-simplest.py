TARGET = tsf('cage.aiff', thresh=-32, rise=1.2, stretch=2)

CORPUS = [
csf('lachenmann.aiff'),
]

SEARCH = [
spass('ratio_limit', d('effDur-seg', norm=1), minratio=0.8, maxratio=1.2),
spass('closest', d('mfccs'))
]
