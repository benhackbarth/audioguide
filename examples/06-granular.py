################################################################################
## Start by creating a granular segmentation of heat sink.aiff by running     ##
## the script 'agGranulateSf.py examples/heat\ sink.aiff -o 0.025 -g 0.075'.  ##
## This will create short grains which work well with this script.            ##
################################################################################


TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)

################################################################################
## Here we use onsetLen=50%, offsetLen=50%, which will result in each grain   ##
## having an envelope of 50% fade in 50% fade out, à la granular synthesis.   ##
################################################################################
CORPUS = [
csf('heat sink.aiff', onsetLen='50%', offsetLen='50%'),
]

################################################################################
## Do not use duration as a search parameter since all corpus grains will be  ##
## of the same duration. Instead, using power-seg helps filter out the search ##
## and ensures that the selected grains will correspond somewhat to the       ##
## aploitude of the target.                                                   ##
################################################################################
SEARCH = [
spass('closest_percent', d('power-seg', normmethod='minmax'), percent=20),
spass('closest', d('mfccs-seg'))
]

################################################################################
## Using maxOnset=1 will let the algorhythim pick one grain per analysis      ##
## frame, i.e. every 0.0124 seconds                                           ##
################################################################################
SUPERIMPOSE = si(maxOnset=1) 