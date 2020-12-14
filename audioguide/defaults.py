##############  OUTPUT FILES  #############
CSOUND_CSD_FILEPATH = 'output/output.csd'
CSOUND_RENDER_FILEPATH = 'output/output.aiff'
HTML_LOG_FILEPATH = 'output/log.html'
MIDI_FILEPATH = None # 'output/output.mid'
MIDIFILE_TEMPO = 60.
TARGET_SEGMENT_LABELS_FILEPATH = 'output/targetlabels.txt'
TARGET_SEGMENTATION_GRAPH_FILEPATH = None #'output/targetlabels.jpg'
OUTPUT_LABEL_FILEPATH = 'output/outputlabels.txt'
LISP_OUTPUT_FILEPATH = None #'output/output.lisp.txt'
DATA_FROM_SEGMENTATION_FILEPATH = None #'output/datafromsegmentation.txt'
DICT_OUTPUT_FILEPATH = 'output/output.json'
MAXMSP_OUTPUT_FILEPATH = 'output/output.maxmsp.json'
BACH_FILEPATH = 'output/bachroll.txt'
TARGET_DESCRIPTORS_FILEPATH = None # 'output/targetdescriptors.json'
TARGET_PLOT_DESCRIPTORS_FILEPATH = None #'output/targetplot.jpg'
CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH = None

##########  CORPUS   #######
SEARCH = []
CORPUS_GLOBAL_ATTRIBUTES = {}
VOICE_PATTERN = []
VOICE_TO_ONSET_MAPPING = []
ROTATE_VOICES = False
ORDER_CORPUS_BY_DESCRIPTOR = None
RESTRICT_CORPUS_SELECT_PERCENTAGE_BY_STRING = {}
RESTRICT_CORPUS_OVERLAP_BY_STRING = {}

##########  BACH   #######
BACH_INCLUDE_TARGET = True
BACH_TARGET_STAFF = 'F'
BACH_CORPUS_STAFF = 'FG'
BACH_SLOTS_MAPPING = {1: 'fullpath', 2: 'sfskiptime', 3: 'sfchannels', 4: 'env', 10: 'cps_transposition', 11: 'cps_selectnumber', 12: 'cps_filehead', 20: 'cps_dynamic', 22: 'instr_articulation', 23: 'instr_notehead', 24: 'instr_annotation', 25: 'instr_technique', 26: 'instr_temporal_mode'}

##########  INSTRUMENTS   #######
INSTRUMENTS = None

#######  NORMALIZATION  #######
NORMALIZATION_METHOD = 'standard'
NORMALIZATION_DELTA_FREEDOM = 0 # 0=default stddev
CLUSTER_MAPPING = {}

#######  CONCATENATE SELECTION  #######
SUPERIMPOSE = si()
ALWAYS_MAKE_COMPLETE_MATCHING_RESULTS = False
RANDOMIZE_AMPLITUDE_FOR_SIM_SELECTION = False
OUTPUT_GAIN_DB = 0.
RANDOM_SEED = None

#######  POST-CONCATENATION EVENT MANIPULATION  #######
OUTPUTEVENT_ALIGN_PEAKS = False 
OUTPUTEVENT_TIME_STRETCH = 1.
OUTPUTEVENT_TIME_ADD = 0.
OUTPUTEVENT_QUANTIZE_TIME_INTERVAL = 0.25
OUTPUTEVENT_QUANTIZE_TIME_METHOD = None # snapToGrid | medianAggregate
OUTPUTEVENT_DURATION_SELECT = 'cps' # cps | tgt
OUTPUTEVENT_DURATION_MIN = None
OUTPUTEVENT_DURATION_MAX = None
OUTPUTEVENT_CLASSIFY = {'numberClasses': 0, 'descriptors': ['mfcc1-seg', 'mfcc2-seg', 'mfcc3-seg', 'mfcc4-seg']} # only classifies if numberClasses >= 2

############  CSOUND RENDERING  ############
CSOUND_SR = 48000
CSOUND_KSMPS = 128
CSOUND_BITS = 16
CSOUND_CHANNEL_RENDER_METHOD = "corpusmax" # corpusmax | stereo | targetoutputmix | oneChannelPerVoice | oneChannelPerOverlap
CSOUND_STRETCH_CORPUS_TO_TARGET_DUR = None # None | transpose | pv
CSOUND_PLAY_RENDERED_FILE = True
CSOUND_NORMALIZE = False
CSOUND_NORMALIZE_PEAK_DB = -3

################  DESCRIPTOR COMPUTATION SETTINGS  ################
DESCRIPTOR_OVERRIDE_DATA_PATH = None
DESCRIPTOR_FORCE_ANALYSIS = False
DESCRIPTOR_WIN_SIZE_SEC = 0.04096
DESCRIPTOR_HOP_SIZE_SEC = 0.01024
DESCRIPTOR_ENERGY_ENVELOPE_HOP_SEC = 0.005
# ircamdescriptor
IRCAMDESCRIPTOR_RESAMPLE_RATE = 12500
IRCAMDESCRIPTOR_WINDOW_TYPE = 'blackman'
IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ = 5000
IRCAMDESCRIPTOR_F0_MIN_FREQUENCY = 20
IRCAMDESCRIPTOR_F0_MAX_FREQUENCY = 5000
IRCAMDESCRIPTOR_F0_AMP_THRESHOLD = 1
IRCAMDESCRIPTOR_NUMB_MFCCS = 13
# filenames -> dynamic -> dB settings
DYNAMIC_TO_DECIBEL = {'pp': -50, 'p': -40, 'mp': -34, 'mf': -24, 'f': -20, 'ff': -10}
FILENAMESTRING_TO_DYNAMICS = {}

###############  USER INTERACTION / PRINTING  ##############
SEARCH_PATHS = []
VERBOSITY = 2
TARGET_SEGMENT_LABELS_INFO = 'logic'
EXPERIMENTAL = {}