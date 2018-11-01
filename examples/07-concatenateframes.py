# This provides an example for use with the script agConcatenateFrames.py.  It will not work the agConcatenate.py.  agConcatenateFrames.py does not use the SEARCH or SUPERIMPOSE variables; rather, variables are specified in the EXPERIMENTAL dictionary (see below).

# The method for sound selection works quite differently from agConcatenate.py.  Here, rather than segment sounds into chunks, the alrogirth looks through the target sound frame by frame.  It starts with the loudest target frame and finds the best matching single frame from anywhere in the corpus according to the descriptors found in EXPERIMENTAL['matrix'].  Then, it looks at the following target frame and the next frame following the matching corpus frame and sees if the similarity is within EXPERIMENTAL['percentMatchDeviationForSegmentFrameAddition'].  When this variable = 20, it means that the next frame can only be 20% further distance from the matching frame, otherwise it will be discarded.  It also looks backwards and performs the same test.  Thusly frames are added after and before the matched frame, until one of the following: 1.) a target frame that is softer than tsf thresh or 2.) there are more overlapping corpus frames that permitted in EXPERIMENTAL['maxoverlaps'] or 3.) if EXPERIMENTAL['canReuseCorpusFrames'] is False, a corpus frame that has previously been used.  If the resulting length of corpus frames is between EXPERIMENTAL['minimumLengthInFrames'] and EXPERIMENTAL['maximumLengthInFrames'], the segment is added to the csound score.

TARGET = tsf('examples/cage.aiff', thresh=-45)
# the only keyword argument that matters for the tsf() is thresh.  Nothing will be picked to match the target if the target amplitude is below the thresh

CORPUS = [
csf('examples/heat sink.aiff'),
] # you can either use short soundfiles, long soundfiles with wholeFile=True, or segmented soundfiles.  segmented soundfiles (with agSegmentSf.py) seem to work best as it helps eliminate silences.


EXPERIMENTAL = {
'concateMethod': 'framebyframe',
'matrix': spass('closest', d('mfccs')), # this spass is built into a matrix which matches a target frame to any frame in the corpus; time-varying descirptors only
'envAttackFrames': 1, # duration of fade in for each sound specified in frames (1 frame = )
'envDecayFrames': 1,
'percentMatchDeviationForSegmentFrameAddition': 20,
'minimumLengthInFrames': 0, # None=no minimum
'maximumLengthInFrames': None, # None=no maxmium
'maxoverlaps': 1, # how many samples may be overlapping
'canReuseCorpusFrames': True, # if False, a corpus frame may not be selected if it has been picked already
}