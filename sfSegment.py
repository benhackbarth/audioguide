#!/usr/bin/env python2.7
import sys, os, random

from optparse import OptionParser
parser = OptionParser(usage="usage: %prog [options] soundfile")
parser.set_defaults(THRESHOLD=-40)
parser.set_defaults(RISE=1.3)
parser.set_defaults(ABS_DB_OFFSET_THRESH=-80)
parser.set_defaults(REL_DB_OFFSET_BOOST=+12)
parser.set_defaults(MINIMUM_SEG=0.05)
parser.set_defaults(MAXIMUM_SEG=4)
parser.set_defaults(GRAIN_SIZE=None)
parser.set_defaults(grainRange=None)
parser.set_defaults(GRAIN_OVERLAP=1)
parser.set_defaults(OUTPUT_FILE='')

parser.add_option("-t", "--threshold", action="store", dest="THRESHOLD", type="float", help="set the threshold for segmentation.  a value from -100 to 0 where a lower value make onsets happen more frequently.  default=-40")
parser.add_option("-r", "--rise", action="store", dest="RISE", type="float", help="set the rise factor for segment onsets.  a higher value makes onsets happen more easily.  default=1.3")

parser.add_option("-d", "--absdb", action="store", dest="ABS_DB_OFFSET_THRESH", type="float", help="absolute db for segment offsets.  default=-80")

parser.add_option("-c", "--reldb", action="store", dest="REL_DB_OFFSET_BOOST", type="float", help="if the amplitude of the soundfile doesn't go below the absolute db (-d), this relative value will be used.  if corrisponds to the minimum found dB plus this value.  default=+18")

parser.add_option("-g", "--grain", action="store", dest="GRAIN_SIZE", type="float", help="slice this soundfile into evenly spaced windows of N seconds.  overrides a normal threshold method.  by default is disabled.")
parser.add_option("-b", "--grainRange", action="store", dest="grainRange", type="str", help="")

parser.add_option("-o", "--grainOverlap", action="store", dest="GRAIN_OVERLAP", type="float", help="set the grain overlap.  by default is disabled.")
parser.add_option("-e", "--exhaustive", action="store_true", dest="exhaustive", default=False)
parser.add_option("-s", "--minimum", action="store", dest="MINIMUM_SEG", type="float", help="set the minimum segment length in seconds.  segments will be forced to be this duration or greater.  default=0.05")
parser.add_option("-l", "--maximum", action="store", dest="MAXIMUM_SEG", type="float", help="set the maximum segment length in seconds.  segments will be forced to be this duration or shorter.  default=4")
parser.add_option("-f", "--file", action="store", dest="OUTPUT_FILE", type="str", help="set the name of the output file.  by default it is the soundfile name + '.txt'")


(options, args) = parser.parse_args()


for file in args:
	# test if its an audio file
	file = os.path.abspath(file)
	fileExtension = os.path.splitext(file)[1]
	isValidSoundfile = False
	for ext in ['.wav', '.aiff', '.au', '.gilbert_butt_fuck']:
		if ext.lower() == fileExtension.lower():
			isValidSoundfile = True
			break
	if not isValidSoundfile:
		#print("\n\n%s is not a valid soundfile!!!!\n\n"%(file))
		continue
	opsData = '''CORPUS = []
TARGET_SEGMENT_OFFSET_DB_ABS_THRESH = %f
TARGET_SEGMENT_OFFSET_DB_REL_THRESH = %f
TARGET_ONSET_ENVELOPE = 'orig'
TARGET_OFFSET_ENVELOPE = 'orig'
CSOUND_SCORE_FILEPATH = None
CSOUND_RENDER_FILEPATH = None
MIDI_FILEPATH = None
TARGET_SEGMENT_LABELS_FILEPATH = None
SUPERIMPOSITION_LABEL_FILEPATH = None
VERBOSITY = 0
USE_PROGRESS_BAR = False

SEARCH = [spass(d('power'))]
'''%(options.ABS_DB_OFFSET_THRESH, options.REL_DB_OFFSET_BOOST)
	if options.GRAIN_SIZE == None: 
		opsData += 'TARGET = tsf("%s", thresh=%f, rise=%f, minSegLen=%f, maxSegLen=%f)'%(file, options.THRESHOLD, options.RISE, options.MINIMUM_SEG, options.MAXIMUM_SEG)
	else: # granular
		opsData += 'TARGET = tsf("%s", thresh=%f, rise=%f, minSegLen=0.01, maxSegLen=10000)'%(file, options.THRESHOLD, options.RISE)
	tmpOpsPath = os.path.join(agPath, 'segmentationops.txt')
	fh = open(tmpOpsPath, 'w')
	fh.write(opsData+'\n')
	fh.close()
	
	ag = audioguide.main(os.path.dirname(os.path.realpath(__file__)), "defaults.py", loadOptionsFromFile=tmpOpsPath, printName="Segment Soundfile")
	ag.init(printConfig=False)
	print("\tCreating segmentation label file for %s..."%file)
	ag.loadTarget()
	print("\tThreshold dB: %f\t\trise: %f\tOffset dB: %f"%(options.THRESHOLD, options.RISE, audioguide.utilities.ampToDb(audioguide.ag.powerOffsetValue)))
	if options.OUTPUT_FILE == '':
		segFile = audioguide.tgt.filename+'.txt'
	else:
		segFile = os.path.abspath(options.OUTPUT_FILE)
	if options.GRAIN_SIZE == None and options.grainRange == None: 
		audioguide.tgt.writeSegLabelsToDisk(segFile, audioguide.tgt.segs, audioguide.ops.TEMPO_CHANGE)
		SEGS = audioguide.tgt.segs
		print("\n\tAudioGuide found %i segments\n"%len(audioguide.tgt.segs))
	elif type(options.GRAIN_SIZE) in [float, int]:
		SEGS = []
		print("\tSilcing target segments into grains of %f seconds with an overlap of %f"%(options.GRAIN_SIZE, options.GRAIN_OVERLAP))
		out = open(segFile, 'w')
		numbSegs = 0
		for a in audioguide.tgt.segs:
			print a
			start = a[0]
			end = start+a[1]
			if options.exhaustive:
				out.write( str(start)+'\t'+str(end) +'\n') # append real segment
				SEGS.append((start,end-start))
				numbSegs += 1

			#print start, end
			while end > start:	
				#print options.exhaustive
				for multi in [2, 3, 4]:
					if options.GRAIN_SIZE*multi <= end:
						#print '\t\t', start+(options.GRAIN_SIZE*multi), end
						if options.exhaustive:
							out.write( str(start)+'\t'+str(start+(options.GRAIN_SIZE*multi)) +'\n')
							SEGS.append((start,end))
							numbSegs += 1
			#print '\t', start, start+options.GRAIN_SIZE
				out.write( str(start)+'\t'+str(start+options.GRAIN_SIZE) +'\n')
				start += options.GRAIN_SIZE/float(options.GRAIN_OVERLAP)
				numbSegs += 1
		print("\n\tAudioGuide found %i grain-segments\n"%numbSegs)
		out.close()
	else:
		out = open(segFile, 'w')
		range = eval(options.grainRange)
		time = 0.
		while True:
			dur = random.uniform(range[0],range[1])
			print(time, "for", dur)
			if time+dur > audioguide.tgt.endSec-0.4: break
			out.write( str(time)+'\t'+str(time+dur) +'\n')
			time += dur
		out.close()
	triggers = []
	for key, val in audioguide.tgt.triggerData.iteritems():
		if key == 'totalWeights': continue
		triggers.append('"'+key+'": '+audioguide.utilities.trunc(val['initMax'], 2))
	#print 'TARGET_ONSET_FORCE_MAX = {'+', '.join(triggers)+'}\n'
	
#	durations = []
#	for seg in SEGS: durations.append(seg[1])
#	print durations
