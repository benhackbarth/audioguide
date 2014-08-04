###############  SETUP  ##############
SEARCH_PATHS = [] # additional directories to search for soundfiles
SOUNDFILE_EXTENSIONS = ['.aiff', '.aif', '.wav', '.au'] # when loading a directory, skip files without these extensions; not case sensative
VERBOSITY = 2
ALERT_ON_ERROR = True
PRINT_SELECTION_HISTO = False
PRINT_SIM_SELECTION_HISTO = True

################  DESCRIPTOR COMPUTATION SETTINGS  ################
DESCRIPTOR_FORCE_ANALYSIS = False
DESCRIPTOR_WIN_SIZE_SEC = 0.04643990929708
DESCRIPTOR_HOP_SIZE_SEC = 0.01160997732427
# ircamdescriptor
IRCAMDESCRIPTOR_RESAMPLE_RATE = 12500
IRCAMDESCRIPTOR_WINDOW_TYPE = 'blackman'
IRCAMDESCRIPTOR_NUMB_MFCCS = 13
IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ = 5000
IRCAMDESCRIPTOR_F0_MIN_FREQUENCY = 20
IRCAMDESCRIPTOR_F0_MAX_FREQUENCY = 5000
IRCAMDESCRIPTOR_F0_AMP_THRESHOLD = 30
IRCAMDESCRIPTOR_F0_QUALITY = 0.1
# supervp
SUPERVP_STRETCH_FLAGS = '-Afft -Np0 -M0.092879802s -oversamp 8 -Whamming -P1 -td_thresh 1.2 -td_G 2.5 -td_band 0,22050 -td_nument 10 -td_minoff 0.02s -td_mina 9.9999997e-06 -td_minren 0 -td_evstre 1 -td_ampfac 1.5 -td_relax 100 -td_relaxto 1 -FCombineMul -shape 1 -Vuf -4'
SUPERVP_NUMB_PEAKS = 12 
# clusteranal
CLUSTERANAL_DESCRIPTOR_DIM = ['mfcc1', 'mfcc2', 'mfcc3']
CLUSTERANAL_NUMB_CLUSTS = 8 
SUPERVP_BIN = None
PM2_BIN = None

##############  OUTPUT FILES  #############
# FOR EACH VARIABLE ENDING IN _FILEPATH:
#    a value of None will turn off the creation of this file
#    a string path will create this file in the location specified
CSOUND_CSD_FILEPATH = 'output/output.csd'
CSOUND_RENDER_FILEPATH = 'output/output.aiff'
LOG_FILEPATH = 'output/log.txt'
MIDI_FILEPATH = 'output/output.mid'
TARGET_SEGMENT_LABELS_FILEPATH = 'output/targetlabels.txt'
SUPERIMPOSITION_LABEL_FILEPATH = 'output/superimpositionlabels.txt'
LISP_OUTPUT_FILEPATH = 'output/output.lisp.txt'
#PARAM_SCORE_FILEPATH = None #'output/paramscore.txt'
DICT_OUTPUT_FILEPATH = 'output/output.json'
TARGET_DESCRIPTORS_FILEPATH = 'output/targetdescriptors.json'
ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH = 'output/orderedcorpus.aiff'
TARGET_PLOT_DESCRIPTORS_FILEPATH = None #'output/targetplot.jpg'

############  CSOUND  ############
CSOUND_SR = 48000
CSOUND_KR = 128
CSOUND_PLAY_RENDERED_FILE = True
CSOUND_PLAYERS = {'Darwin': 'afplay', 'Linux': 'aplay', 'Windows': 'mplay32 \play'}
CSOUND_CHANNEL_RENDER_METHOD = "mix" # mix | oneChannelPerVoice | oneChannelPerOverlap
CSOUND_STRETCH_CORPUS_TO_TARGET_DUR = None # None | transpose | pv

############ TARGET  ############
TARGET_ONSET_DESCRIPTORS = {'power-odf-7': 1}
TARGET_SEGMENT_OFFSET_DB_ABS_THRESH = -80.
TARGET_SEGMENT_OFFSET_DB_REL_THRESH = +18
TARGET_LOAD_SEGMENTS_FILEPATH = None

##########  CORPUS   #######
SEARCH = []
CORPUS_GLOBAL_ATTRIBUTES = {}
VOICE_PATTERN = []
ROTATE_VOICES = False
ORDER_CORPUS_BY_DESCRIPTOR = 'centroid-seg'

#######  CONCATENATE SELECTION  #######
SUPERIMPOSE = si()
ALWAYS_MAKE_COMPLETE_MATCHING_RESULTS = False
RANDOMIZE_AMPLITUDE_FOR_SIM_SELECTION = False
RANDOM_SEED = None

################  CONCATENATE TIME MANIPULATION  ################
OUTPUT_GAIN_DB = 0.
OUTPUT_TIME_STRETCH = 1.
OUTPUT_TIME_ADD = 0.

#RHYTHM_QUANTIZE = 0
#RHYTHM_QUANTIZE_METHOD = 'aggregate'
