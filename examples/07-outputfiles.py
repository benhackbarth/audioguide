################################################################################
## This file gives you some information about how to work with outputfile     ##
## names in audioguide. Pretty simple stuff.                                  ##
################################################################################
TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)

CORPUS = [
csf('lachenmann.aiff'),
]

SEARCH = [
spass('ratio_limit', d('effDur-seg'), maxratio=1),
spass('ratio_limit', d('power-seg'), maxratio=1),
spass('closest', d('mfccs-seg'))
]

SUPERIMPOSE = si(maxSegment=4)


################################################################################
## You can stop audiguide from writing any output files you don't want by     ##
## setting their associated variable to None                                  ##
################################################################################
OUTPUT_LABEL_FILEPATH = None
DICT_OUTPUT_FILEPATH = None
MAXMSP_OUTPUT_FILEPATH = None
BACH_FILEPATH = None


################################################################################
## Note that CSOUND_CSD_FILEPATH _must_ be created in order for               ##
## CSOUND_RENDER_FILEPATH to be made. But you can put this file somewhere     ##
## non-visable if you want                                                    ##
################################################################################
CSOUND_CSD_FILEPATH = '/tmp/hideme.csd'


################################################################################
## You can also use the special string $TIME in your filenames to ensure that ##
## output files do not get overwritten                                        ##
################################################################################
CSOUND_RENDER_FILEPATH = 'output/$TIME-output.wav' # will create the file output/YYYY-MM-DD_hh-mm-ss-output.wav with the current time
HTML_LOG_FILEPATH = 'output/log.html' # will just write output/log.html and will get overwritten next time you run agConcatenate.py


###################################################################
## You can also use $TIME to create a directory for output files ##
###################################################################
#CSOUND_RENDER_FILEPATH = 'output/$TIME/output.wav' # will create the file output/YYYY-MM-DD_hh-mm-ss/output.wav 
#HTML_LOG_FILEPATH = 'output/$TIME/log.html'
#COPY_OPTIONS_FILEPATH = 'output/$TIME/options.py' # <- copies the options file you're using so you can remember what you did :)
