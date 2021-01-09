#########################################################################
## For AAF file support, you need to install the python module pyaaf2. ##
#########################################################################

################################################################################
## As of version 1.69, audioGuide can create AAF files for loading into       ##
## Logic/Pro Tools. This is done by setting a filepath for the AAF_FILEPATH   ##
## variable. This has been tested and works in Logic.                         ##
################################################################################

################################################################################
## As of version 1.69, audioGuide can create AAF files for loading into       ##
## Logic/Pro Tools. This is done by setting a filepath for the AAF_FILEPATH   ##
## variable. This has been tested and works in Logic.                         ##
################################################################################

################################################################################
## As of version 1.71, audioGuide can create RPP files for loading into       ##
## reaper.                                                                    ##
################################################################################


################################################################################
## This example file will create quite a few tracks in the AAF file. Each     ##
## entry in the corpus gets at minimum of one track. More tracks are made if  ##
## there are overlapping selections from the csf entry and/or if the csf has  ##
## resources of different channel counts.                                     ##
################################################################################

################################################################################
## Some things to know: there is a bug with the code at the moment and tracks ##
## are written to the aaf file in an unpredictable order. Also note that      ##
## envelope data from onsetLen and offsetLen doesn't translate to the AAF,    ##
## and scaleDb values are ignored. Transposition will not work either.        ##
################################################################################

TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)

CORPUS = [
csf('heat sink.aiff', transMethod='random -6 +6'), 
csf('lachenmann.aiff', scaleDb=-6),
]

SEARCH = [
spass('ratio_limit', d('effDur-seg'), maxratio=1),
spass('closest_percent', d('power-seg', norm=1), percent=20),
spass('closest', d('mfccs'))
]


SUPERIMPOSE = si(maxSegment=3)


CSOUND_CSD_FILEPATH = None # don't render csound

AAF_FILEPATH = 'output/output.aaf' # our AAF output filepath

AAF_INCLUDE_TARGET = True # this will include the target sound in the aaf file

AAF_CPSTRACK_METHOD = 'cpsidx' # how cps tracks are written to the AAF file, also try 'minimum'

# let's also create a reaper output rpp file
RPP_FILEPATH = 'output/output.rpp' # our AAF output filepath

RPP_INCLUDE_TARGET = True # this will include the target sound in the aaf file

RPP_CPSTRACK_METHOD = 'cpsidx' # how cps tracks are written to the AAF file, also try 'minimum'




