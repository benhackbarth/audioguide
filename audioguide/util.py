from math import log10, log
import sys, os, subprocess, random

audioguide_lady = '''
          ,)(8)).
        (()))())()).
       (()"````"::= )
       )| _    _ ::= )
      (()(o)/ (o) ?(/)
       )(  c    ( :(/)   --> 
      (( \ .__, ;,/(/)
        ) `.___,'/ (/)
           |    | (/)
         _.'    ,\(/)__
     _.-"   `AG'   (/) ".
   ,"               ^    \\
  /                      |
'''
  
def ladytext(string):
	global audioguide_lady
	string = string.split()
	audioguide_lady_pieces = audioguide_lady.split('\n')
	cnt = 0
	i_cnt = 0
	output = ''
	while cnt < len(audioguide_lady_pieces):
		output += audioguide_lady_pieces[cnt]+' '*(29-len(audioguide_lady_pieces[cnt]))
		if cnt > 2:
			text = ''
			while len(string) > i_cnt and len(text) < 40:
				text += string[i_cnt]+' '
				i_cnt += 1
			output += text + '\n'
		else:
			output += '\n'
		cnt += 1
	return output
	

def exit(*args):
#	ALERT_ON_ERROR = False
#	if ALERT_ON_ERROR:  # beep?
#		sys.stdout.write('\a')
#		sys.stdout.flush()
#	print "\n"
	sys.exit(1)


def error(errorType, errorData, exitcode=1):
	print(ladytext("%s ERROR: %s"%(bold(errorType.upper()), errorData)))
	exit(exitcode)


def bold(string):
	return "\033[1m"+str(string)+"\033[0;0m"


def getTimeStamp(file):
	return os.stat(file).st_ctime


def checkIfFileIsNewer(file1, file2):
	if not os.path.exists(file2):
		return True
	if getTimeStamp(file1) > getTimeStamp(file2): return True
	else: return False
	

def quantize(value, interval):
	interval = float(interval)
	if interval == 0:
		return value
	else:
		if value < 0: interval = -interval
		return int((value+(interval/2.0))*(1/interval))*interval


def ampToDb(amp):
	return (20*log10(max(amp, 0.0000000000001))) # amp to dB


def dbToAmp(db):
	return pow(10, db/20.0) # dB to amp


def frq2Midi(frq):
	from math import log
	if frq == 0.0: frq = 0.000001
	return round(12*log(frq/440.0), 2)+69


def interpArray(array, desiredSize, interpMask=None):
	from numpy import arange, linspace, interp
	x = arange(array.size)
	if interpMask == None:
		interpMask = linspace(0, len(array)-1, desiredSize)
	return interp(interpMask, x, array)

def nextPowerOfTwo(val):
	result = 2.
	while result < val: result *= 2.
	return result

def getDynamicFromFilename(file, notFound=-1000):
	TYPICAL_DYNAMICS = {'pp': -50, 'p': -40, 'mp': -34, 'mf': -24, 'f': -20, 'ff': -10}
	MAP_DYNAMICS = {'ppmfpp': 'mf', 'pfp': 'f', 'f-ff': 'f','fp': 'f', 'ppff':'ff', 'ffpp': 'ff', 'slap': 'pp', 'sfz': 'f', 'p1': 'p', 'p2': 'pp', }
	ALL_DYN_KEYS = TYPICAL_DYNAMICS.keys()
	ALL_DYN_KEYS.extend(MAP_DYNAMICS.keys())
	SPLIT_STRINGS = ['-', '_', '.', '|'] # in order of likelihood
	NOTHING_YET = True
	whichStr = 0
	dynamic = "fuck"
	while NOTHING_YET:
		if whichStr > len(SPLIT_STRINGS)-1:
			break
		splitStr = SPLIT_STRINGS[whichStr]
		fileHead = os.path.split(file)[1]
		strings = os.path.split(os.path.splitext(file)[0])[1].split(splitStr)
		strings.reverse() # they tend to be at the end of the file
		for s in strings:
			if s in ALL_DYN_KEYS:
				dynamic = s
				NOTHING_YET = False
				break
		whichStr += 1
	if dynamic == 'fuck':
		return notFound
	elif MAP_DYNAMICS.has_key(dynamic):
		return TYPICAL_DYNAMICS[MAP_DYNAMICS[dynamic]]
	else:
		return TYPICAL_DYNAMICS[dynamic]


def matchString(testString, matchStr, caseSensative=True):
	if not caseSensative:
		testString = testString.lower()
		matchStr = matchStr.lower()
	if testString.find(matchStr) == -1: return False
	else: return True


def readAudacityLabelFile(path):
	timeList = []
	audacityLabels = open(path, 'r')
	lines = audacityLabels.readlines()
	# in case it was made in audacity and has a '\r' for a carriage return!
	try:
		if len(lines) == 1 and lines[0].find('\r') != -1:
			lines = lines[0].split('\r') 
		for idx, line in enumerate(lines):
			if len(line) == 0: continue
			line = line.split('\t')
			start = float(line[0])
			end = float(line[1])
			if start == end: # then we'll assume these are start times and infer end time...
				if idx != len(lines): end = None
				else: end = float(lines[idx+1].split()[1])-0.05
			writeLine = [start, end]
			writeLine.extend(line[2:])
			timeList.append( writeLine )
	except ValueError:
		print ValueError, "on line", idx, "in", path
	return timeList


def printDict(heading, dict, postLevel, p):
	p.middle(heading, postLevel)
	for key, val in dict.iteritems():
		p.post("%s -> ${RED}%s${NORMAL}"%(key, val), postLevel)
	p.post("", postLevel)


def executeCommand(args):
	import subprocess, os
	sub = subprocess.Popen(args, shell=True)
	exitStatus = os.waitpid(sub.pid, 0)[1]
	if exitStatus != 0:
		p.post(' '.join(args) + " died with " + str(exitStatus), 1)
		exit(10)


def popen_execute_command(commandArgs, exitOnError=True, stdoutReturnDict=None):
	try:
		p = subprocess.Popen(commandArgs, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	except OSError:
		error('commandline', 'Command line call failed: \n\n"%s"'%' '.join(commandArgs))
	out, err = p.communicate()
	#print out
	#print err
	# test for bad exit status
	if exitOnError and err not in [0, '']:
		error('commandline', 'AudioGuide command line call failed: \n"%s"%s%s'%(' '.join(commandArgs), '\n--------\n\n', ''.join(out)))	
	if stdoutReturnDict == None: return out
	dictStore = {}
	# fill output dict if requested
	for o in out.split('\n'):
		o = o.split()
		if len(o) > 1:
			for (str, loc), (key, valloc, valtype) in stdoutReturnDict.iteritems():
				if o[loc] == str:
					dictStore[key] = o[valloc]
					if valtype == int: dictStore[key] = int(dictStore[key])
					if valtype == float: dictStore[key] = float(dictStore[key])
	return out, dictStore



#def trunc(f, n):
#    '''Truncates/pads a float f to n decimal places without rounding'''
#    slen = len('%.*f' % (n, f))
#    return str(f)[:slen]


#def chain(iterables):
#	output = []
#	for it in iterables:
#		output.extend(it)
#	return output


def histogram(l):
	# returns sorted list histogram with highest value first.
	d = {}
	for i in l:
		if d.has_key(i): d[i] += 1
		else: d[i] = 1
	sorty = []
	for k, v in d.iteritems():
		sorty.append((v, k))
	sorty.sort()
	sorty.reverse()
	return sorty


#def sliceListIntoEvenlySpacedLists(l, sliceSize, lowVal, highVal):
#	# for use with quantize and histograms...
#	l.sort()
#	numberSlices = int((highVal-lowVal+1)/sliceSize) # add an extra second just to be sure
#	slices = []
#	for i in range(numberSlices): # fill with enough empty lists
#		slices.append([])
#	for item in l:
#		slices[int((item-lowVal)/sliceSize)].append(item)
#	return slices



def getDirListOnlyExt(path, recur, extensions):
	import os
	# if recursive..
	if recur:
		output = []
		for dirname, dirnames, filenames in os.walk(path):
			for filename in filenames:
				output.append( os.path.abspath(os.path.join(dirname, filename)) )
	else:
		# if just whats in that folder..
		output = os.listdir(path)
	# filter files by extension - case insensative!
	validFiles = []
	for outty in output:
		isValid = False
		fileExt = os.path.splitext(outty)[1]
		for ext in extensions:
			if ext.lower() == fileExt.lower():
				isValid = True
				break
		if isValid: validFiles.append(outty)
	return validFiles


def verifyOutputPath(path, scriptPath):
	''' will use abs path if provided.  if
	relative, it will be placed in the script's 
	directory, creating directories as needed'''
	if os.path.isabs(path): return path
	relativeJoined = os.path.join(scriptPath, path)
	# create directory if needed
	directory = os.path.split(relativeJoined)[0]
	if not os.path.exists(directory):
		os.makedirs(directory)
	return relativeJoined
	

def verifyPath(path, searchPathList):
	abspath = os.path.abspath(path)
	if os.path.exists(abspath): return abspath
	tried = []
	for root in searchPathList:
		possiblepath = os.path.join(root, path)
		tried.append(possiblepath)
		if os.path.exists(possiblepath): return possiblepath
	error("FILENAME", "Couldn't find a file called %s"%' or '.join(tried))


def initStretchedSoundfile(sffile, start, end, stretchcoeff, svpbin, p=None):
	supervp_flags = '''-Afft -Np0 -M0.092879802s -oversamp 8 -Whamming -P1 -td_thresh 1.2 -td_G 2.5 -td_band 0,22050 -td_nument 10 -td_minoff 0.02s -td_mina 9.9999997e-06 -td_minren 0 -td_evstre 1 -td_ampfac 1.5 -td_relax 100 -td_relaxto 1 -FCombineMul -shape 1 -Vuf -4'''
	
	stretcheddir = os.path.join(os.path.dirname(__file__), 'data_stretched_sfs')
	if not os.path.exists(stretcheddir): os.makedirs(stretcheddir)
	# get filename
	sfroot, sfhead = os.path.split(sffile)
	sfheadroot, sfheadext = os.path.splitext(sfhead)
	checksum = listToCheckSum([sffile, start, end, stretchcoeff])
	stretchedfilename = os.path.join(stretcheddir, '%sx%.2f-%s%s'%(sfheadroot, stretchcoeff, checksum, sfheadext))
	if os.path.exists(stretchedfilename): return stretchedfilename
	#################################
	## do supervp time stretching! ##
	#################################
	# make temporary stretch coeff file (needed by supervp)
	stretchParamFile = os.path.join(stretcheddir, 'stretchtmpfile.txt')
	fh = open(stretchParamFile, 'w')
	fh.write("-10 1\n0 %s\n"%(stretchcoeff))
	fh.close()
	# add start time and end time offsets to flags if needed
	if start != None: supervp_flags += ' -B%f'%start
	if end != None: supervp_flags += ' -E%f'%end
	# make supervp command!
	command = '%s -t -Z -U -S"%s" %s -D"%s" "%s"'%(svpbin, sffile, supervp_flags, stretchParamFile, stretchedfilename)
	#print 'TARGET TIME STRETCH - "%s"'%command
	executeCommand( command )
	return stretchedfilename


def parseEquationString(mstr, symbs):
	for symb in symbs:
		if mstr.rfind(symb) != -1: # found it!
			mstr_p = mstr.split(symb)
			return [ mstr_p[0].strip(), symb, mstr_p[1].strip() ]
	# shouldn't get here is everything worked out
	error('parseEquationString', '"%s" - Cannot parse this equation, is not well formed'%mstr)




def getTransposition(tgtseg, cpsseg):
	# NADA
	if cpsseg.transMethod == None: return quantize(0, cpsseg.transQuantize)
	# FORCE A SEMITONE TRANSPOSITION
	elif cpsseg.transMethod.startswith('semitone'):
		trans = int(cpsseg.transMethod.split()[1])
		return trans
	# FORCE A SINGLE CHROMA
	elif cpsseg.transMethod.startswith('single-pitch'):
		pitch = int(cpsseg.transMethod.split()[1])
		srcPitch = cpsseg.desc['MIDIPitch-seg'].get(0, None) 
		print "single-pitch", pitch, srcPitch, pitch-srcPitch
		print "single-pitch", cpsseg.filename, pitch, srcPitch, pitch-srcPitch
		print "single-pitch", pitch, srcPitch, pitch-srcPitch
		print "single-pitch", pitch, srcPitch, pitch-srcPitch
		print "single-pitch", pitch, srcPitch, pitch-srcPitch
		return pitch-srcPitch
	# FORCE A PITCH RANGE!   KINDA HACKY, GOTTA FIND A BETTER WAY TO CODE THIS UI
	elif cpsseg.transMethod.startswith('pitch-range'):
		pitchLow = int(cpsseg.transMethod.split()[1])
		pitchHigh = int(cpsseg.transMethod.split()[2])
		srcPitch = cpsseg.desc['MIDIPitch-seg'].get(0, None) 
		if srcPitch < pitchLow:
			return pitchLow-srcPitch
		elif srcPitch > pitchHigh:
			return pitchHigh-srcPitch
		else:
			return 0.
	# RANDOM RANGE
	elif cpsseg.transMethod.startswith('random'):
		pieces = cpsseg.transMethod.split()
		output = random.uniform(float(pieces[1]), float(pieces[2]))
		return quantize(output, cpsseg.transQuantize)
	# 
	elif cpsseg.transMethod in ['f0']:
		tgtPitch = tgt.desc['f0-seg'].get(tgt.timeInFrames, thisTargetSegmentLength) 
		srcPitch = cpsseg.desc['f0-seg'].get(0, None) 
		if tgtPitch <= 0 or srcPitch <= 0:
			output = 0.
		else:
			output = frq2Midi(tgtPitch)-frq2Midi(srcPitch)
		return quantize(output, quantizef)
	# 
	elif cpsseg.transMethod in ['f0-chroma']:
		tgtPitch = tgt.desc['f0-seg'].get(tgt.timeInFrames, tgt.timeInFrames+thisTargetSegmentLength) 
		srcPitch = cpsseg.desc['f0-seg'].get(0, None) 
		if tgtPitch <= 0 or srcPitch <= 0:
			output = 0.
		else:
			tgtmid = frq2Midi(tgtPitch) % 12
			cpsmid = frq2Midi(srcPitch) % 12
			output = tgtmid-cpsmid
			if output > 6: output = ((output*-1)%12)*-1
			# flip octaves to make smallest possible transposition
		return quantize(output, quantizef)


# MARKOV
#	elif cpsseg.transMethod[0] == 'markov':
#		output = makeMarkovPitchChoice(cpsseg.transMethod[1])
#	elif cpsseg.transMethod[0] == 'matchTgtTemporality':
# match the length of tgt segment
#		scaleTgtDur = 1.3 # to provide a little overlap
#		minTrans = 0.5
#		maxTrans = 2.
#		rawTrans = cpsseg.data['raw']['effDur-seg'][0]/float(thisTargetSegmentLength*1.1)
#		output = np.clip(rawTrans, minTrans, maxTrans)
#	return quantize(output, quantizef)


#def makeMarkovPitchChoice(incomingPitch):
#	global markov1, markov1IntMap
#	if tgt.lastMarkovIntMapChoice == None: # INIT ME
#		#     	m2nd	M2nd	m3rd	M3rd	TT
#		m2nd =[ 30,		10,		10,		20,		10]
#		M2nd =[ 10,		0,		2,		3,		3]
#		m3rd =[ 0,		5,		5,		0,		20]
#		M3rd =[ 30,		2,		0,		1,		3]
#		TT   =[ 60,		10,		0,		10,		10]
#		markov1 = [m2nd, M2nd, m3rd, M3rd, TT]
#		markov1IntMap = [1, 2, 3, 4, 6]
#		for likelihood in markov1:
#			total = 0.0
#			for i in range(0, len(likelihood)):
#				total = total+likelihood[i]
#			for i in range(0, len(likelihood)): # make sure all lists total 1...
#				likelihood[i] = likelihood[i]*(1/total)
#		# write first int val
#		tgt.lastMarkovIntMapChoice = int(random.uniform(0, len(likelihood))) # set it if this is the first note...
#		tgt.lastMarkovPitchChoice = incomingPitch
#		return 0
#	else: # make a markov call...
#		number = random.uniform(0, 1)
#		accum = 0
#		i = 0
#		while accum < number:
#		    accum += markov1[int(tgt.lastMarkovIntMapChoice)][int(i)]
#		    i += 1
#		thisIntMapChoice = i-1
#		thisInterval = markov1IntMap[thisIntMapChoice]
#		thisTargetPitch = thisInterval+incomingPitch
##		print ""
##		print ""
##		print ""
##		print "INCOMING PITCH:", incomingPitch, "INCOMING PC:", incomingPitch%12
##		print "CHOSEN INTERVAL:", thisInterval, "LAST PITCH:", tgt.lastMarkovPitchChoice
##		print "TARGET PITCH:", (tgt.lastMarkovPitchChoice+thisInterval), "TARGET PC:", (tgt.lastMarkovPitchChoice+thisInterval)%12
#		subtractPC = (tgt.lastMarkovPitchChoice+thisInterval)%12-(incomingPitch%12)
#		addPC = (tgt.lastMarkovPitchChoice+thisInterval)%12+(incomingPitch%12)
#		if abs(addPC) <= abs(subtractPC): trans = addPC
#		else: trans = subtractPC
#		while trans > 6: trans -= 12
#		while trans < -6: trans += 12
##		print "CHOSEN TRANS:", trans
##		print ""
#		tgt.lastMarkovPitchChoice = incomingPitch+trans
#		return trans





#def printableList(listOfLists):
#	# find max list length
#	maxLength = 0
#	for line in listOfLists:
#		if len(line) > maxLength: maxLength = len(line)
#	# make a list of the longest string lengths for each field
#	maxStrLen = [0]*maxLength
#	for line in listOfLists:
#		if line[0][0] == ";": continue # just a comment
#		for (idx, val) in enumerate(line):
#			if len(val) > maxStrLen[idx]: maxStrLen[idx] = len(val)
#	outputListOfLists = []
#	# makes sure that each param has a fixed number of chars
#	for line in listOfLists:
#		if line[0][0] == ";":
#			outputListOfLists.append(' '.join(line)) # comment
#			continue
#		outStr = ""
#		for idx, val in enumerate(line):
#			outStr += str(val)+(" "*(maxStrLen[idx]-len(val)+1))
#		outputListOfLists.append(outStr+'\n')
#	return outputListOfLists
#	
#
#def getTargetCorpusTimbreRemapChecksum(tgt, agSourceHandles, descriptorList):
#	clusterChecksumItems = [tgt.name, tgt.scaleDb]
#	for tup in enumerate(tgt.segFrames): clusterChecksumItems.extend(list(tup))
#	for handle in agSourceHandles:
#		clusterChecksumItems.extend([handle.name, handle.startSec, handle.endSec, handle.scaleDb])
#	for d in descriptorList:
#		clusterChecksumItems.extend([d.name, d.weight])
#	return listToCheckSum(clusterChecksumItems)



def listToCheckSum(items):
	import hashlib
	m = hashlib.md5()
	for item in items:
		m.update(str(item))
	output = m.hexdigest()
	return output


def getDurationFromValueOrString(input1, input2):
	'''this function returns the same value if it is a float/int.
	alternatively, it computes a percentage of input2 if input1 is
	a string with a '%' at the end, e.g. '50%' = half of input2'''
	if type(input1) == str and input1.find('%') != -1:
		return input2*(float(input1.replace('%',''))/100.)
	elif type(input1) in [float, int]:
		return input1
	else:
		print("ERROR in % string here : '%s'!"%input1)
		sys.exit(1)

