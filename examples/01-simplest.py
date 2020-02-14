TARGET = tsf('cage.aiff', thresh=-25, offsetRise=1.5)

CORPUS = [
csf('lachenmann.aiff'),
] # CORPUS documented in 04-corpus.py

SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=25),
spass('closest', d('mfccs'))
]

SUPERIMPOSE = si(maxSegment=6) # SUPERIMPOSE documented in 03-superimposition.py
