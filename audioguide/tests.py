############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys
import audioguide.util as util


def testOpsDict(dicty):
	#print(UserVar_types)
	for name, value in dicty.items():
		#print (name, value)
		if name.startswith('_'): continue # added this exception to permit user variable that start with _
		if not name in UserVar_types:
			util.error("user variable", "I don't have an option called %s\n :("%(name))
		outcomes = []
		for tstring in UserVar_types[name]:
			outcomes.append( testVariable(tstring, value) )
		if not True in outcomes: # if none of these test were passed
			util.error("user variable", "variable %s must be %s (%s given as %s)"%(name, ' or '.join(UserVar_types[name]), str(value), type(value)))


def testInstance(obj1, obj2):
	str1 = str(obj1).replace('<','').split()[0].split('.')[-1]
	str2 = str(obj2).replace('<class \'', '').replace("'>", '').split('.')[-1]
	return str1 == str2



def testVariable(vtype, v):
	from audioguide.userclasses import TargetOptionsEntry as tsf
	from audioguide.userclasses import CorpusOptionsEntry as csf
	from audioguide.userclasses import Instrument as instr
	from audioguide.userclasses import Score as score
	from audioguide.userclasses import SearchPassOptionsEntry as spass
	from audioguide.userclasses import SuperimpositionOptionsEntry as si
	if vtype == 'True or False':
		if v == True or v == False: return True
	elif vtype == 'None':
		if v == None: return True
	elif vtype == 'a number':
		if isinstance(v, (int, float)): return True
	elif vtype == 'a string':
		if isinstance(v, str): return True
	elif vtype == 'a dictionary':
		if isinstance(v, dict): return True
	elif vtype == 'a tsf() object':
		if testInstance(v, tsf): return True
	elif vtype == 'a si() object':
		if testInstance(v, si): return True
	elif vtype == 'an spass() object':
		return testInstance(v, spass)
	elif vtype in ['a number greater than zero', 'an integer greater than zero']:
		if isinstance(v, (int, float)) and v > 0.: return True
	elif vtype in ['a number greater than or equal to zero']:
		if isinstance(v, (int, float)) and v >= 0.: return True
	# lists of things
	elif vtype == 'a list of strings':
		if not False in [isinstance(i, str) for i in v]: return True
	elif vtype == 'a list of ints or lists':
		if not False in [isinstance(i, list) or isinstance(i, int) for i in v]: return True
	elif vtype == 'a list of spass() objects':
		if not False in [testInstance(i, spass) for i in v]: return True
	elif vtype == 'a list of csf() objects':
		if not False in [testInstance(i, csf) for i in v]: return True
	elif vtype == 'a list of instr() objects':
		if not False in [testInstance(i, instr) for i in v]: return True
	elif vtype == 'a score() object':
		return testInstance(v, score)


	else: # a string for testing!
		if v == vtype: return True
	return False



UserVar_types = {
##########  OBJECT VARIABLES  #######
'TARGET': ['a tsf() object'],
'CORPUS': ['a list of csf() objects'],
'SUPERIMPOSE': ['a si() object'],
'SEARCH': ['a list of spass() objects'],
'INSTRUMENTS': ['None', 'a score() object'],
##########  OUTPUT FILES   #######
'CSOUND_CSD_FILEPATH': ['None', 'a string'],
'CSOUND_SCORE_FILEPATH': ['None', 'a string'],
'CSOUND_RENDER_FILEPATH': ['None', 'a string'],
'HTML_LOG_FILEPATH': ['None', 'a string'],
'TARGET_SEGMENT_LABELS_FILEPATH': ['None', 'a string'],
'TARGET_SEGMENT_LABELS_INFO': ['a string'],
'TARGET_SEGMENTATION_GRAPH_FILEPATH': ['None', 'a string'],
'OUTPUT_LABEL_FILEPATH': ['None', 'a string'],
'LISP_OUTPUT_FILEPATH':  ['None', 'a string'],
'DATA_FROM_SEGMENTATION_FILEPATH': ['None', 'a string'],
'DICT_OUTPUT_FILEPATH': ['None', 'a string'],
'MAXMSP_OUTPUT_FILEPATH': ['None', 'a string'],
'TARGET_DESCRIPTORS_FILEPATH': ['None', 'a string'],
'TARGET_PLOT_DESCRIPTORS_FILEPATH': ['None', 'a string'],
'CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH': ['None', 'a string'],
'BACH_FILEPATH': ['None', 'a string'],
'AAF_FILEPATH': ['None', 'a string'],




##########  CORPUS   #######
'CORPUS_GLOBAL_ATTRIBUTES': ['a dictionary'],
'VOICE_PATTERN': ['a list of strings'],
'VOICE_TO_ONSET_MAPPING': ['a list of ints or lists'],
'ORDER_CORPUS_BY_DESCRIPTOR': ['a string', 'None'],
'ROTATE_VOICES': ['True or False'],
'RESTRICT_CORPUS_SELECT_PERCENTAGE_BY_STRING': ['a dictionary'],
'RESTRICT_CORPUS_OVERLAP_BY_STRING': ['a dictionary'],

########  BACH  #######
'BACH_INCLUDE_TARGET': ['True or False'],
'BACH_TARGET_STAFF': ['a string'],
'BACH_CORPUS_STAFF': ['a string'],
'BACH_SLOTS_MAPPING': ['a dictionary'],

########  NORMALIZATION  #######
'NORMALIZATION_METHOD': ['standard', 'cluster'],
'NORMALIZATION_DELTA_FREEDOM': ['a number greater than or equal to zero'], 
'CLUSTER_MAPPING': ['a dictionary'],

########  CONCATENATE SELECTION  #######
'RANDOM_SEED': ['None', 'a number'],
'OUTPUT_GAIN_DB': ['a number'],
'ALWAYS_MAKE_COMPLETE_MATCHING_RESULTS': ['True or False'],
'RANDOMIZE_AMPLITUDE_FOR_SIM_SELECTION': ['True or False'],

#######  POST-CONCATENATION EVENT MANIPULATION  #######
'OUTPUTEVENT_ALIGN_PEAKS': ['True or False'],
'OUTPUTEVENT_DURATION_SELECT': ['cps', 'tgt'],
'OUTPUTEVENT_DURATION_MIN': ['None', 'a number'],
'OUTPUTEVENT_DURATION_MAX': ['None', 'a number'],
'OUTPUTEVENT_TIME_STRETCH': ['a number greater than zero'],
'OUTPUTEVENT_TIME_ADD': ['a number'],
'OUTPUTEVENT_QUANTIZE_TIME_METHOD': ['None', 'snapToGrid', 'medianAggregate'],
'OUTPUTEVENT_QUANTIZE_TIME_INTERVAL': ['a number greater than zero'],
'OUTPUTEVENT_CLASSIFY': ['a dictionary'],

#############  CSOUND RENDERING  ############
'CSOUND_SR': ['an integer greater than zero'],
'CSOUND_KSMPS': ['an integer greater than zero'],
'CSOUND_BITS': ['an integer greater than zero'],
'CSOUND_CHANNEL_RENDER_METHOD': ['stereo', 'targetoutputmix', 'corpusmax', 'oneChannelPerVoice', 'oneChannelPerOverlap', 'mix', 'oneChannelPerClassification', 'oneChannelPerInstrument'], # mix is deprecated 
'CSOUND_STRETCH_CORPUS_TO_TARGET_DUR': ['None', 'pv', 'transpose'],
'CSOUND_PLAY_RENDERED_FILE': ['True or False'],
'CSOUND_NORMALIZE': ['True or False'],
'CSOUND_NORMALIZE_PEAK_DB': ['a number'],

#################  DESCRIPTOR COMPUTATION SETTINGS  ################
'DESCRIPTOR_DATABASE_SIZE_LIMIT': ['a number greater than zero'],
'DESCRIPTOR_DATABASE_AGE_LIMIT': ['a number greater than zero'],
'DESCRIPTOR_OVERRIDE_DATA_PATH': ['None', 'a string'],
'DESCRIPTOR_FORCE_ANALYSIS': ['True or False'],
'DESCRIPTOR_WIN_SIZE_SEC': ['a number greater than zero'],
'DESCRIPTOR_HOP_SIZE_SEC': ['a number greater than zero'],
'DESCRIPTOR_ENERGY_ENVELOPE_HOP_SEC': ['a number greater than zero'],
'IRCAMDESCRIPTOR_RESAMPLE_RATE': ['an integer greater than zero'],
'IRCAMDESCRIPTOR_WINDOW_TYPE': ['blackman', 'hanning', 'hamming', 'hanning2'],
'IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ': ['an integer greater than zero'],
'IRCAMDESCRIPTOR_F0_MIN_FREQUENCY': ['an integer greater than zero'],
'IRCAMDESCRIPTOR_F0_MAX_FREQUENCY': ['an integer greater than zero'],
'IRCAMDESCRIPTOR_F0_AMP_THRESHOLD': ['an integer greater than zero'],
'IRCAMDESCRIPTOR_F0_QUALITY': ['an integer greater than zero'], # DEPRECATED
'IRCAMDESCRIPTOR_NUMB_MFCCS': ['an integer greater than zero'],
'DYNAMIC_TO_DECIBEL': ['None', 'a dictionary'],
'FILENAMESTRING_TO_DYNAMICS': ['None', 'a dictionary'],


################  USER INTERACTION / PRINTING  ##############
'SEARCH_PATHS': ['a list of strings'],
'VERBOSITY': ['a number greater than or equal to zero'],
'EXPERIMENTAL': ['a dictionary'],
}



# can be: 'reinit', 'output', 'target', 'corpus', 'norm' 'concate', 
OptionChangeToProgramRun = {
"TARGET": "target",
"CORPUS": "corpus",
"SEARCH": "norm",
"SUPERIMPOSE": "concate",
"INSTRUMENTS": "concate",


"CSOUND_CSD_FILEPATH": "output",
"CSOUND_SCORE_FILEPATH": "output",
"CSOUND_RENDER_FILEPATH": "output",
"HTML_LOG_FILEPATH": "reinit",
"TARGET_SEGMENT_LABELS_FILEPATH": "target",
"TARGET_SEGMENTATION_GRAPH_FILEPATH": "target",
"OUTPUT_LABEL_FILEPATH": "output",
"LISP_OUTPUT_FILEPATH": "output",
"DATA_FROM_SEGMENTATION_FILEPATH": "output",
"DICT_OUTPUT_FILEPATH": "output",
"MAXMSP_OUTPUT_FILEPATH": "output",
"BACH_FILEPATH": "output",
"TARGET_DESCRIPTORS_FILEPATH": "output",
"TARGET_PLOT_DESCRIPTORS_FILEPATH": "output",
"CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH": "output",

"CORPUS_GLOBAL_ATTRIBUTES": "corpus",
"VOICE_PATTERN": "concate",
"VOICE_TO_ONSET_MAPPING": "concate",
"ROTATE_VOICES": "concate",
"ORDER_CORPUS_BY_DESCRIPTOR": "reinit",
"RESTRICT_CORPUS_SELECT_PERCENTAGE_BY_STRING": "corpus",
"RESTRICT_CORPUS_OVERLAP_BY_STRING": "corpus",

"BACH_INCLUDE_TARGET": "output",
"BACH_TARGET_STAFF": "output",
"BACH_CORPUS_STAFF": "output",
"BACH_SLOTS_MAPPING": "output",

"NORMALIZATION_METHOD": "norm",
"NORMALIZATION_DELTA_FREEDOM": "norm",
"CLUSTER_MAPPING": "norm",

"ALWAYS_MAKE_COMPLETE_MATCHING_RESULTS": "concate",
"RANDOMIZE_AMPLITUDE_FOR_SIM_SELECTION": "concate",
"OUTPUT_GAIN_DB": "concate",
"RANDOM_SEED": "concate",

"OUTPUTEVENT_ALIGN_PEAKS": "output",
"OUTPUTEVENT_TIME_STRETCH": "output",
"OUTPUTEVENT_TIME_ADD": "output",
"OUTPUTEVENT_QUANTIZE_TIME_INTERVAL": "output",
"OUTPUTEVENT_QUANTIZE_TIME_METHOD": "output",
"OUTPUTEVENT_DURATION_SELECT": "output",
"OUTPUTEVENT_DURATION_MIN": "output",
"OUTPUTEVENT_DURATION_MAX": "output",
"OUTPUTEVENT_CLASSIFY": "output",

"CSOUND_SR": "output",
"CSOUND_KSMPS": "output",
"CSOUND_BITS": "output",
"CSOUND_CHANNEL_RENDER_METHOD": "output",
"CSOUND_STRETCH_CORPUS_TO_TARGET_DUR": "output",
"CSOUND_PLAY_RENDERED_FILE": "output",
"CSOUND_NORMALIZE": "output",
"CSOUND_NORMALIZE_PEAK_DB": "output",

"DESCRIPTOR_DATABASE_SIZE_LIMIT": "concate",
"DESCRIPTOR_DATABASE_AGE_LIMIT": "concate",
"DESCRIPTOR_OVERRIDE_DATA_PATH": "reinit",
"DESCRIPTOR_FORCE_ANALYSIS": "reinit",
"DESCRIPTOR_WIN_SIZE_SEC": "reinit",
"DESCRIPTOR_HOP_SIZE_SEC": "reinit",
"DESCRIPTOR_ENERGY_ENVELOPE_HOP_SEC": "reinit",

"IRCAMDESCRIPTOR_RESAMPLE_RATE": "reinit",
"IRCAMDESCRIPTOR_WINDOW_TYPE": "reinit",
"IRCAMDESCRIPTOR_F0_MAX_ANALYSIS_FREQ": "reinit",
"IRCAMDESCRIPTOR_F0_MIN_FREQUENCY": "reinit",
"IRCAMDESCRIPTOR_F0_MAX_FREQUENCY": "reinit",
"IRCAMDESCRIPTOR_F0_AMP_THRESHOLD": "reinit",
"IRCAMDESCRIPTOR_NUMB_MFCCS": "reinit",

"DYNAMIC_TO_DECIBEL": "corpus",
"FILENAMESTRING_TO_DYNAMICS": "corpus",

"SEARCH_PATHS": "reinit",
"VERBOSITY": "reinit",
"TARGET_SEGMENT_LABELS_INFO": "target",
"EXPERIMENTAL": "reinit",
}


def UpdatedOpsTestForChanges(currentops, newops):
	changed = []
	setops = {}
	for k, v in newops.items():
		if v == getattr(currentops, k): continue
		changed.append(OptionChangeToProgramRun[k])
		setops[k] = v
	REINIT = False
	EVAL_TARGET = False
	EVAL_CORPUS = False
	EVAL_NORM = False
	EVAL_CONCATE = False
	EVAL_OUTPUT = False
	if 'reinit' in changed:
		return True, True, True, True, True, True
	else:
		if 'target' in changed:
			EVAL_TARGET = True
			EVAL_NORM = True
			EVAL_CONCATE = True
			EVAL_OUTPUT = True			
		if 'corpus' in changed:
			EVAL_CORPUS = True
			EVAL_NORM = True
			EVAL_CONCATE = True
			EVAL_OUTPUT = True			
		if 'norm' in changed:
			EVAL_NORM = True
			EVAL_CONCATE = True
			EVAL_OUTPUT = True			
		if 'concate' in changed:
			EVAL_CONCATE = True
			EVAL_OUTPUT = True			
		if 'output' in changed:
			EVAL_OUTPUT = True			
	return REINIT, EVAL_TARGET, EVAL_CORPUS, EVAL_NORM, EVAL_CONCATE, EVAL_OUTPUT, setops
