############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys
import audioguide.util as util


def testOpsDict(dicty):
	for name, value in dicty.items():
		#print name, value
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
	else: # a string for testing!
		if v == vtype: return True
	return False



UserVar_types = {
##########  OBJECT VARIABLES  #######
'TARGET': ['a tsf() object'],
'CORPUS': ['a list of csf() objects'],
'SUPERIMPOSE': ['a si() object'],
'SEARCH': ['a list of spass() objects'],
##########  OUTPUT FILES   #######
'CSOUND_CSD_FILEPATH': ['None', 'a string'],
'CSOUND_RENDER_FILEPATH': ['None', 'a string'],
'HTML_LOG_FILEPATH': ['None', 'a string'],
'MIDI_FILEPATH': ['None', 'a string'],
'MIDIFILE_TEMPO': ['a number greater than zero'],
'TARGET_SEGMENT_LABELS_FILEPATH': ['None', 'a string'],
'SEGMENTATION_FILE_INFO': ['a string'],
'TARGET_SEGMENTATION_GRAPH_FILEPATH': ['None', 'a string'],
'OUTPUT_LABEL_FILEPATH': ['None', 'a string'],
'LISP_OUTPUT_FILEPATH':  ['None', 'a string'],
'DATA_FROM_SEGMENTATION_FILEPATH': ['None', 'a string'],
'DICT_OUTPUT_FILEPATH': ['None', 'a string'],
'MAXMSP_OUTPUT_FILEPATH': ['None', 'a string'],
'TARGET_DESCRIPTORS_FILEPATH': ['None', 'a string'],
'TARGET_PLOT_DESCRIPTORS_FILEPATH': ['None', 'a string'],
'CORPUS_SEGMENTED_FEATURES_JSON_FILEPATH': ['None', 'a string'],
##########  CORPUS   #######
'CORPUS_GLOBAL_ATTRIBUTES': ['a dictionary'],
'VOICE_PATTERN': ['a list of strings'],
'VOICE_TO_ONSET_MAPPING': ['a list of ints or lists'],
'ORDER_CORPUS_BY_DESCRIPTOR': ['a string', 'None'],
'ROTATE_VOICES': ['True or False'],
'RESTRICT_CORPUS_SELECT_PERCENTAGE_BY_STRING': ['a dictionary'],
'RESTRICT_CORPUS_OVERLAP_BY_STRING': ['a dictionary'],

########  NORMALIZATION  #######
'NORMALIZATION_METHOD': ['standard', 'cluster'],
'NORMALIZATION_DELTA_FREEDOM': ['a number greater than or equal to zero'], 
'CLUSTER_MAPPING': ['a dictionary'],

########  CONCATENATE SELECTION  #######
'RANDOM_SEED': ['None', 'a number'],
'OUTPUT_GAIN_DB': ['a number'],
'OUTPUT_TIME_STRETCH': ['a number greater than zero'],
'OUTPUT_TIME_ADD': ['a number'],
'OUTPUT_QUANTIZE_TIME_METHOD': ['None', 'snapToGrid', 'medianAggregate'],
'OUTPUT_QUANTIZE_TIME_INTERVAL': ['a number greater than zero'],
'ALWAYS_MAKE_COMPLETE_MATCHING_RESULTS': ['True or False'],
'RANDOMIZE_AMPLITUDE_FOR_SIM_SELECTION': ['True or False'],
#############  CSOUND RENDERING  ############
'CSOUND_SR': ['an integer greater than zero'],
'CSOUND_KSMPS': ['an integer greater than zero'],
'CSOUND_BITS': ['an integer greater than zero'],
'CSOUND_ALIGN_PEAKS': ['True or False'],
'CSOUND_CHANNEL_RENDER_METHOD': ['stereo', 'corpusmax', 'oneChannelPerVoice', 'oneChannelPerOverlap', 'mix'], # mix is deprecated 
'CSOUND_STRETCH_CORPUS_TO_TARGET_DUR': ['None', 'pv', 'transpose'],
'CSOUND_SEGMENT_MIN_DUR': ['None', 'a number'],
'CSOUND_SEGMENT_MAX_DUR': ['None', 'a number'],
'CSOUND_PLAY_RENDERED_FILE': ['True or False'],
'CSOUND_RENDER_DUR': ['cps', 'tgt'],
'CSOUND_NORMALIZE': ['True or False'],
'CSOUND_NORMALIZE_PEAK_DB': ['a number'],
#################  DESCRIPTOR COMPUTATION SETTINGS  ################
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
'SUPERVP_BIN': ['None', 'a string'],
'PM2_BIN': ['None', 'a string'],
################  USER INTERACTION / PRINTING  ##############
'SEARCH_PATHS': ['a list of strings'],
'VERBOSITY': ['a number greater than or equal to zero'],
'EXPERIMENTAL': ['a dictionary'],
}


		
