TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)
SEARCH = [spass('closest', d('mfccs'))]
SUPERIMPOSE = si(maxSegment=1)


################################################################################
## The CORPUS variable is a list of csf objects.  This list may be of any     ##
## length.  Each csf object specifies corpus soundfiles in the form of one    ##
## long soundfile which is segmented or a folder of soundfiles which have     ##
## already been segmented (see the "wholeFile" option in the readme.pdf for   ##
## help on this).  There are many keyword arguments for csf which control     ##
## what segments are used in concatenation.  Below are some examples to get   ##
## you started thinking about how to compose your corpuses.                   ##
################################################################################
CORPUS = [
csf('lachenmann.aiff'),
]


##############################################################################
## Adding another csf() object adds more soundfile segments to the corpus.  ##
##############################################################################
#CORPUS = [
#csf('lachenmann.aiff'),
#csf('heat sink.aiff'),
#]


################################################################################
## Descriptor limitations are very useful in that you can filter out portions ##
## of a csf()'s segments based on averaged descriptor values.  These limits   ##
## can be chained together.  For instance:                                    ##
################################################################################
#CORPUS = [
#csf('lachenmann.aiff', limit=['power-seg < 50%']), # only uses the softest 50% of segments from this file
#csf('heat sink.aiff', limit=['power-seg > 25%', 'centroid-seg < 2000']), # only uses the loudest 75% of segments from this file, then takes only those segments whos centroid is higher than 2000.
#]


##############################################################################
## A lot more information can be found in the csf section of the readme.pdf ##
##############################################################################
