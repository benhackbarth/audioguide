TARGET = tsf('/Users/ben/Documents/audioguide/targets/beatbox/callout_adiao.wav', thresh=-48, offsetRise=1.5)
#TARGET = tsf('/Users/ben/Documents/audioguide/examples/cage.aiff', thresh=-26, offsetRise=1.5)

CORPUS = [
#csf('/Users/ben/Documents/audioguide/corpi/BANoise.aiff'),
#csf('/Users/ben/Documents/audioguide/corpi/BAPitch.aiff'),
#csf('/Users/ben/Documents/audioguide/corpi/snareCatalogue.aiff'),
csf('/Users/ben/Documents/audioguide/corpi/glitz'),
#csf('/Users/ben/Documents/sfdb/pno/muted', wholeFile=True),
#csf('/Users/ben/Documents/sfdb/pno/pluck', wholeFile=True),
#csf('/Users/ben/Documents/sfdb/pno/short', wholeFile=True),
#csf('/Users/ben/Documents/audioguide/corpi/crotaleCatalogue.aiff'),
]


CLUSTER_MAPPING = {'type': 'SOM', 'descriptors': ('crest0', 'crest1', 'crest2', 'crest3'), 'size': 7, 'normalise': 'independent', 'makeHitMap': True, 'makePickleFile': True}

SEARCH = [
#spass('ratio_limit', d('effDur-seg', norm=1), minratio=0.5, maxratio=1.),
#spass('closest', d('mfccs-seg'), d('slope-seg'), d('sharpness-seg'), d('perceptualoddtoevenratio-seg'), d('chroma11-seg'), d('chroma10-seg'), d('perceptualtristimuluses-seg'), d('perceptualcentroid-seg'), d('harmonicslope-seg'), d('perceptualdeviation-seg'), d('spread-seg'), d('harmonicenergy-seg'), d('perceptualdecrease-seg'), d('inharmonicity-seg'), d('harmonicdeviation-seg'), d('kurtosis-seg'), d('harmonicspread-seg'), d('perceptualspread-seg'), d('harmonickurtosis-seg'), d('harmonicskewness-seg'), d('f0-seg'), d('flatnesses-seg'), d('harmonicdecrease-seg'), d('skewness-seg'), d('perceptualslope-seg'), d('harmonictristimuluses-seg'), d('centroid-seg'), d('perceptualrolloff-seg'), d('noisiness-seg'), d('chroma9-seg'), d('chroma8-seg'), d('perceptualvariation-seg'), d('power-seg'), d('chroma1-seg'), d('chroma0-seg'), d('chroma3-seg'), d('chroma2-seg'), d('chroma5-seg'), d('chroma4-seg'), d('chroma7-seg'), d('chroma6-seg'), d('variation-seg'), d('energyenvelope-seg'), d('crest1-seg'), d('crest0-seg'), d('crest3-seg'), d('crest2-seg'), d('harmonicrolloff-seg'), d('zeroCross-seg'), d('perceptualskewness-seg'), d('harmonicoddevenratio-seg'), d('rolloff-seg'), d('perceptualkurtosis-seg'), d('loudness-seg'), d('harmoniccentroid-seg'),)
spass('closest', d('mfccs'))
]

SUPERIMPOSE = si(maxSegment=4, maxOnset=1)
