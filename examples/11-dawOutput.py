################################################################################
## As of version 1.71, audioGuide can create RPP files for reaper. This is    ##
## done by setting a filepath for the RPP_FILEPATH variable.                  ##
################################################################################

################################################################################
## As of version 1.69, audioGuide can create AAF files for loading into       ##
## Logic/Pro Tools. This is done by setting a filepath for the AAF_FILEPATH   ##
## variable. This has been tested and works in Logic.                         ##
################################################################################

#########################################################################
## For AAF file support, you need to install the python module pyaaf2. ##
#########################################################################

#################################################################################
## This example file will create quite a few tracks in the AAF/RPP files. Each ##
## entry in the corpus gets at minimum of one track. More tracks are made if   ##
## there are overlapping selections from the csf entry and/or if the csf has   ##
## resources of different channel counts.                                      ##
#################################################################################

################################################################################
## Note that the reaper RPP file supports corpus sound envelopes and          ##
## transpositions while the aaf output does not.                              ##
################################################################################


TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)

CORPUS = [
csf('heat sink.aiff', transMethod='random -6 +6'), # <- random transposition will only work in rpp output
csf('lachenmann.aiff', scaleDb=-6, onsetLen='20%'), # <- scaleDb and onsetLen will only work in rpp output
]

SEARCH = [
spass('ratio_limit', d('effDur-seg'), maxratio=1),
spass('closest_percent', d('power-seg', norm=1), percent=20),
spass('closest', d('mfccs'))
]


SUPERIMPOSE = si(maxSegment=3)


# let's create an AAF file output
AAF_FILEPATH = 'output/output.aaf' # our AAF output filepath
AAF_INCLUDE_TARGET = True # this will include the target sound in the aaf file
AAF_CPSTRACK_METHOD = 'cpsidx' # how cps tracks are written to the AAF file, also try 'minimum'


# let's also create a reaper output rpp file
RPP_FILEPATH = 'output/output.rpp' # our AAF output filepath
RPP_INCLUDE_TARGET = True # this will include the target sound in the aaf file
RPP_CPSTRACK_METHOD = 'cpsidx' # how cps tracks are written to the AAF file, also try 'minimum'

# auto launch will attempt to automatically open the rpp file after it is written. this will open the file with OSX's default program given its file extension.
RPP_AUTOLAUNCH = True

# don't render csound
CSOUND_CSD_FILEPATH = None 


