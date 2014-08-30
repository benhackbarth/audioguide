TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)

CORPUS = [
csf('lachenmann.aiff'),

] # CORPUS documented in 04-corpus.py

SEARCH = [
spass('ratio_limit', d('effDur-seg'), minratio=0.7, maxratio=1.1),
spass('closest', d('mfccs-seg'))
] # SEARCH documented in 02-searching.py

SUPERIMPOSE = si(maxSegment=8) # SUPERIMPOSE documented in 03-superimposition.py

DESCRIPTOR_WIN_SIZE_SEC = 0.05 # 0.04096
DESCRIPTOR_HOP_SIZE_SEC = 0.003 # 0.01024
##TARGET_SEGMENTATION_GRAPH_FILEPATH = 'output/targetlabels.jpg'
#DESCRIPTOR_WIN_SIZE_SEC = 0.02 # 0.04096
#DESCRIPTOR_HOP_SIZE_SEC = 0.003 # 0.01024
