##############  OUTPUT FILES  #############
# FOR EACH VARIABLE ENDING IN _FILEPATH:
#    a value of None will turn off the creation of this file
#    a string path will create this file in the location specified
CSOUND_CSD_FILEPATH = 'output/output.csd'
CSOUND_RENDER_FILEPATH = 'output/output.aiff'
LOG_FILEPATH = 'output/log.txt'
MIDI_FILEPATH = 'output/output.mid'
TARGET_SEGMENT_LABELS_FILEPATH = 'output/targetlabels.txt'
TARGET_SEGMENTATION_GRAPH_FILEPATH = None #'output/targetlabels.jpg'
SUPERIMPOSITION_LABEL_FILEPATH = 'output/superimpositionlabels.txt'
LISP_OUTPUT_FILEPATH = None #'output/output.lisp.txt'
DATA_FROM_SEGMENTATION_FILEPATH = None #'output/datafromsegmentation.txt'
DICT_OUTPUT_FILEPATH = 'output/output.json'
MAXMSP_OUTPUT_FILEPATH = 'output/output.maxmsp.json'
TARGET_DESCRIPTORS_FILEPATH = 'output/targetdescriptors.json'
ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH = 'output/orderedcorpus.aiff'
TARGET_PLOT_DESCRIPTORS_FILEPATH = None #'output/targetplot.jpg'

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
OUTPUT_GAIN_DB = 0.
OUTPUT_TIME_STRETCH = 1.
OUTPUT_TIME_ADD = 0.
OUTPUT_QUANTIZE_TIME_METHOD = None # 'snapToGrid' 'medianAggregate'
OUTPUT_QUANTIZE_TIME_INTERVAL = 0.25


############  CSOUND RENDERING  ############
CSOUND_SR = 48000
CSOUND_KR = 128
CSOUND_PLAY_RENDERED_FILE = True
CSOUND_CHANNEL_RENDER_METHOD = "mix" # mix | oneChannelPerVoice | oneChannelPerOverlap
CSOUND_STRETCH_CORPUS_TO_TARGET_DUR = None # None | transpose | pv

################  DESCRIPTOR COMPUTATION SETTINGS  ################
DESCRIPTOR_FORCE_ANALYSIS = False
DESCRIPTOR_WIN_SIZE_SEC = 0.04096
DESCRIPTOR_HOP_SIZE_SEC = 0.01024
# ircamdescriptor
IRCAMDESCRIPTOR_RESAMPLE_RATE = 12500
IRCAMDESCRIPTOR_WINDOW_TYPE = 'blackman'
IRCAMDESCRIPTOR_NUMB_MFCCS = 13
IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ = 5000
IRCAMDESCRIPTOR_F0_MIN_FREQUENCY = 20
IRCAMDESCRIPTOR_F0_MAX_FREQUENCY = 5000
IRCAMDESCRIPTOR_F0_AMP_THRESHOLD = 30
IRCAMDESCRIPTOR_F0_QUALITY = 0.1
# other binary locations - None means disabled, otherwise specify a full path
SUPERVP_BIN = None
PM2_BIN = None

###############  USER INTERACTION / PRINTING  ##############
SEARCH_PATHS = []
VERBOSITY = 2
ALERT_ON_ERROR = True
PRINT_SELECTION_HISTO = False
PRINT_SIM_SELECTION_HISTO = True
