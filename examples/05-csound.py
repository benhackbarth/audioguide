TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)

CORPUS = [
csf('lachenmann.aiff'),
csf('heat sink.aiff'),
]

SEARCH = [
spass('ratio_limit', d('effDur-seg', norm=1), maxratio=1.1),
spass('closest', d('mfccs'))
]

SUPERIMPOSE = si(maxSegment=4)

################################################################################
## Change Csound's sample rate and control rate with the following variables. ##
## This affects the quality of the csound output file.                        ##
################################################################################
CSOUND_SR = 48000
CSOUND_KSMPS = 128
CSOUND_BITS = 16 # 16, 24, or 32


################################################################################
## If you uncomment one of the following lines, csound will stretch selected  ##
## corpus samples to match the duration of the target segments (after they're ##
## picked).  This will not affect which segments are selected, only their     ##
## playback duration in csound rendering.                                     ##
################################################################################
CSOUND_STRETCH_CORPUS_TO_TARGET_DUR = None # which does not perform temporal manipulation.
#CSOUND_STRETCH_CORPUS_TO_TARGET_DUR = "pv" # phase vocoder (will not change pitch)
#CSOUND_STRETCH_CORPUS_TO_TARGET_DUR = "transpose" # tape-head transposition (will change pitch, but not as "phasy")


################################################################################
## By default Csound creates a soundfile where the number of channels is      ##
## equal to the maxmimum number of channels found in the corpus - corpus      ##
## files may have different channel counts. This option is called "corpusmax" ##
################################################################################
CSOUND_CHANNEL_RENDER_METHOD = "corpusmax"
################################################################################
## You can also create a stereo file where stereo corpus sounds are put       ##
## into L and R and mono sounds are put into the L and R channels equally.    ##
## This option is called "stereo":                                            ##
################################################################################
#CSOUND_CHANNEL_RENDER_METHOD = "stereo"
################################################################################
## There are two other posibilities.  "oneChannelPerVoice" creates an         ##
## output soundfile where each corpus entry is given its own channel.  Since  ##
## CORPUS is a list, the sound segments from the first item will be put into  ##
## channel 1, the second item into channel 2, etc.  The output soundfile will ##
## have as many channels as there are entries in the CORPUS variable:         ##
################################################################################
#CSOUND_CHANNEL_RENDER_METHOD = "oneChannelPerVoice"
################################################################################
## A fourth option is called "oneChannelPerOverlap".  Here corpus sounds are  ##
## put into different channels based on how densely corpus sounds overlap.    ##
## If corpus sounds overlap with a maximum density of 4, there will be 4      ##
## output channels.                                                           ##
################################################################################
#CSOUND_CHANNEL_RENDER_METHOD = "oneChannelPerOverlap"


################################################################################
## You can change the name of the .csd file and the resulting soundfile by    ##
## changing either of the two FILEPATH variables:                             ##
################################################################################
CSOUND_CSD_FILEPATH = 'output/output.csd'
CSOUND_RENDER_FILEPATH = 'output/output.aiff'


################################################################################
## This variable tells the concatenate script to play the resulting csound    ##
## file at the command line when done rendering:                              ##
################################################################################
CSOUND_PLAY_RENDERED_FILE = True


