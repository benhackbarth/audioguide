import util, sys
from UserClasses import TargetOptionsEntry as tsf
from UserClasses import CorpusOptionsEntry as csf
from UserClasses import SingleDescriptor as d
from UserClasses import SearchPassOptionsEntry as spass
from UserClasses import SuperimpositionOptionsEntry as si



def testOpsDict(dicty):
	for item, testList in UserVar_types.items():
		outcome = []
		for tstring in testList:
			#print item, tstring
			outcome.append( testVariable(tstring, dicty[item]) )
		if not True in outcome: # if none of these test were passed
			util.error("user variable", "variable %s must be %s"%(item, ' or '.join(testList)))




def testVariable(vtype, v):
	if vtype == 'True or False':
		if v == True or v == False: return True
	elif vtype == 'None':
		if v == None: return True
	elif vtype == 'a number':
		if v == isinstance(x, (int, long, float, complex)): return True
	elif vtype == 'a string':
		if isinstance(v, basestring): return True
	elif vtype == 'a dictionary':
		if isinstance(v, dict): return True
	elif vtype == 'a tsf() object':
		if isinstance(v, tsf): return True
	elif vtype == 'a si() object':
		if isinstance(v, si): return True
	# lists of things
	elif vtype == 'a list of strings':
		if not False in [isinstance(i, basestring) for i in v]: return True
	elif vtype == 'a list of spass() objects':
		if not False in [isinstance(i, spass) for i in v]: return True
	elif vtype == 'a list of csf() objects':
		if not False in [isinstance(i, csf) for i in v]: return True
	

	else:
		util.error("user variable", "no test method %s"%(vtype))
	return False



UserVar_types = {
'TARGET': ['a tsf() object'],
'CORPUS': ['a list of csf() objects'],
'SUPERIMPOSE': ['a si() object'],
'SEARCH': ['a list of spass() objects'],

##########  OUTPUT FILES   #######
'CSOUND_CSD_FILEPATH': ['None', 'a string'],
'CSOUND_RENDER_FILEPATH': ['None', 'a string'],
'LOG_FILEPATH': ['None', 'a string'],
'MIDI_FILEPATH': ['None', 'a string'],
'TARGET_SEGMENT_LABELS_FILEPATH': ['None', 'a string'],
'TARGET_SEGMENTATION_GRAPH_FILEPATH': ['None', 'a string'],
'SUPERIMPOSITION_LABEL_FILEPATH': ['None', 'a string'],
'LISP_OUTPUT_FILEPATH':  ['None', 'a string'],
'DATA_FROM_SEGMENTATION_FILEPATH': ['None', 'a string'],
'DICT_OUTPUT_FILEPATH': ['None', 'a string'],
'MAXMSP_OUTPUT_FILEPATH': ['None', 'a string'],
'TARGET_DESCRIPTORS_FILEPATH': ['None', 'a string'],
'ORDER_CORPUS_BY_DESCRIPTOR_FILEPATH': ['None', 'a string'],
'TARGET_PLOT_DESCRIPTORS_FILEPATH': ['None', 'a string'],
##########  CORPUS   #######
'CORPUS_GLOBAL_ATTRIBUTES': ['a dictionary'],
'VOICE_PATTERN': ['a list of strings'],
'ORDER_CORPUS_BY_DESCRIPTOR': ['a string'],
'ROTATE_VOICES': ['True or False'],




########  CONCATENATE SELECTION  #######
#RANDOM_SEED': ['None', 'a number'],
#OUTPUT_GAIN_DB = 0.
#OUTPUT_TIME_STRETCH = 1.
#OUTPUT_TIME_ADD = 0.
#OUTPUT_QUANTIZE_TIME_METHOD = None # 'snapToGrid' 'medianAggregate'
#OUTPUT_QUANTIZE_TIME_INTERVAL = 0.25
'ALWAYS_MAKE_COMPLETE_MATCHING_RESULTS': ['True or False'],
'RANDOMIZE_AMPLITUDE_FOR_SIM_SELECTION': ['True or False'],
#
#############  CSOUND RENDERING  ############
#CSOUND_SR = 48000
#CSOUND_KR = 128
#CSOUND_CHANNEL_RENDER_METHOD = "mix" # mix | oneChannelPerVoice | oneChannelPerOverlap
#CSOUND_STRETCH_CORPUS_TO_TARGET_DUR = None # None | transpose | pv
'CSOUND_PLAY_RENDERED_FILE': ['True or False'],

#################  DESCRIPTOR COMPUTATION SETTINGS  ################
'DESCRIPTOR_FORCE_ANALYSIS': ['True or False'],
#DESCRIPTOR_WIN_SIZE_SEC = 0.04096
#DESCRIPTOR_HOP_SIZE_SEC = 0.01024
## ircamdescriptor
#IRCAMDESCRIPTOR_RESAMPLE_RATE = 12500
#IRCAMDESCRIPTOR_WINDOW_TYPE = 'blackman'
#IRCAMDESCRIPTOR_NUMB_MFCCS = 13
#IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ = 5000
#IRCAMDESCRIPTOR_F0_MIN_FREQUENCY = 20
#IRCAMDESCRIPTOR_F0_MAX_FREQUENCY = 5000
#IRCAMDESCRIPTOR_F0_AMP_THRESHOLD = 30
#IRCAMDESCRIPTOR_F0_QUALITY = 0.1
## other binary locations - None means disabled, otherwise specify a full path
#SUPERVP_BIN = None
#PM2_BIN = None
#
################  USER INTERACTION / PRINTING  ##############
#SEARCH_PATHS = []
#VERBOSITY = 2
'ALERT_ON_ERROR': ['True or False'],
'PRINT_SELECTION_HISTO': ['True or False'],
'PRINT_SIM_SELECTION_HISTO': ['True or False'],
}


		
