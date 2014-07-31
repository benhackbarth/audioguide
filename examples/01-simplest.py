TARGET = tsf('dream.aiff', thresh=-42, rise=1.2)

CORPUS = [
csf('lachenmann.aiff'),
#csf('/Users/ben/Documents/audioGuide/source/glitz'),
]

SEARCH = [
spass('ratio_limit', d('effDur-seg', norm=1), minratio=0.8, maxratio=1.2),
spass('closest', d('mfccs'))
]
