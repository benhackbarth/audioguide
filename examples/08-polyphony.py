## this example is experimental and subject to change

################################################################################
## NOTE You must install librosa and scipy for the following example to work. ##
## Depending on which version of Python you're using, either run:             ##
## python2 -m pip install --user librosa scipy                                ##
## or                                                                         ##
## python3 -m pip install --user librosa scipy                                ##
################################################################################

################################################################################
## Sometimes target sounds are polyphonic (as is the case with the target     ##
## file examples/bone.aiff).  With soundfiles where there are simultanously   ##
## (or near-simultanously) overlapping sound streams, if can be useful to     ##
## separate these streams before the concatenative process.  Separation aids  ##
## in segmentation and can better represent polyphonic timbral content.       ##
################################################################################

################################################################################
## You can do this by adding the 'decompose' keyword to the tsf() variable.   ##
## This will break the target sound in the a number of independant streams.   ##
## At the moment only NMF and HPSS signal decomposition are supported.  This  ##
## works by creating a new target soundfile in the directory                  ##
## audioguide/data_decomposedtargets.  It will be the duration of the         ##
## original target sound times the number of streams.  The concatenative      ##
## process then takes place on the longer, decomposed target  to ensure       ##
## that normalization and segmentation work properly.  Selected segments are  ##
## then rearranged temporally to match the original target sound's structure. ##
################################################################################



TARGET = tsf('bone.aiff', thresh=-26, offsetRise=3, decompose={'type': 'NMF', 'streams': 7, 'fftsize': 1024, 'hopsize': 256})

# to separate a target into pitched/noise components, use HPSS (time-series harmonic-percussive separation):
#TARGET = tsf('bone.aiff', thresh=-26, offsetRise=2, decompose={'type': 'HPSS', 'fftsize': 1024, 'hopsize': 256})

# uncomment to compare to the target sound without decomposition:
#TARGET = tsf('bone.aiff', thresh=-26, offsetRise=2) 


CORPUS = [csf('heat sink.aiff'), csf('lachenmann.aiff'),]

SEARCH = [
spass('closest_percent', d('effDur-seg', norm=1), d('power-seg', norm=1), percent=20),
spass('closest', d('mfccs'))
]

SUPERIMPOSE = si(maxSegment=2)

RPP_FILEPATH = 'output/output.rpp' # our RPP output filepath
RPP_INCLUDE_TARGET = True # this will include the target sound in the RPP file
