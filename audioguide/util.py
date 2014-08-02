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
	ALERT_ON_ERROR = True
	if ALERT_ON_ERROR:  # beep?
		sys.stdout.write('\a')
		sys.stdout.flush()
	print "\n"
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


def quantizeNoteSequence(inputNotes, quant):
	if quant not in [None, 0]: # then quantize the score
		startTimes = []
		for entry in inputNotes:
			if str(entry[0])[0] == ";": continue # just a comment
			startTimes.append(float(entry[0]))
		quantizes = sliceListIntoEvenlySpacedLists(startTimes, quant, 0, max(startTimes)+1)
		# do histogram to find most common attack point for each window...
		for idx, noteList in enumerate(quantizes): 
			if len(quantizes[idx]) > 0: quantizes[idx] = histogram(noteList)[0][1] # only if there are notes
		# make the changes
		for entry in inputNotes:
			if str(entry[0])[0] == ";": continue # just a comment
			idx = int(float(entry[0])/quant)
			entry[0] = quantizes[idx] # change start time of this note
	return inputNotes



def ampToDb(amp):
	return (20*log10(max(amp, 0.0000000000001))) # amp to dB


def dbToAmp(db):
	return pow(10, db/20.0) # dB to amp


def frq2Midi(frq):
	if frq == 0.0: frq = 0.000001
	return round(12*log(frq/440.0), 2)+69


def limit(inValue, low, high):
	if high != None:
		if inValue > high: inValue = high
	if low != None:
		if inValue < low: inValue = low
	return inValue


def interpolateVal(scalar, low, high):
	return ((high-low)*scalar)+low


def product(*args, **kwds):
    # product('ABCD', 'xy') --> Ax Ay Bx By Cx Cy Dx Dy
    # product(range(2), repeat=3) --> 000 001 010 011 100 101 110 111
    pools = map(tuple, args) * kwds.get('repeat', 1)
    result = [[]]
    for pool in pools:
        result = [x+[y] for x in result for y in pool]
    for prod in result:
        yield tuple(prod)


def combinations(iterable, r):
    # combinations('ABCD', 2) --> AB AC AD BC BD CD
    # combinations(range(4), 3) --> 012 013 023 123
    pool = tuple(iterable)
    n = len(pool)
    if r > n:
        return
    indices = range(r)
    yield tuple(pool[i] for i in indices)
    while True:
        for i in reversed(range(r)):
            if indices[i] != i + n - r:
                break
        else:
            return
        indices[i] += 1
        for j in range(i+1, r):
            indices[j] = indices[j-1] + 1
        yield tuple(pool[i] for i in indices)


def permutations(iterable, r=None):
    # permutations('ABCD', 2) --> AB AC AD BA BC BD CA CB CD DA DB DC
    # permutations(range(3)) --> 012 021 102 120 201 210
    pool = tuple(iterable)
    n = len(pool)
    r = n if r is None else r
    if r > n:
        return
    indices = range(n)
    cycles = range(n, n-r, -1)
    yield tuple(pool[i] for i in indices[:r])
    while n:
        for i in reversed(range(r)):
            cycles[i] -= 1
            if cycles[i] == 0:
                indices[i:] = indices[i+1:] + indices[i:i+1]
                cycles[i] = n - i
            else:
                j = cycles[i]
                indices[i], indices[-j] = indices[-j], indices[i]
                yield tuple(pool[i] for i in indices[:r])
                break
        else:
            return


def interpArray(array, desiredSize, interpMask=None):
	x = np.arange(array.size)
	if interpMask == None:
		interpMask = np.linspace(0, len(array)-1, desiredSize)
	return np.interp(interpMask, x, array)


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
	# test for bad exit status
	if exitOnError and err not in [0, '']:
		error('commandline', 'AudioGuide command line call failed: \n"%s"%s%s'%(' '.join(commandArgs), '\n--------\n\n', ''.join(out)))	
	if stdoutReturnDict == None: return None
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
	return dictStore



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
	# FORCE A SINGLE CHROMA
	elif cpsseg.transMethod.startswith('single-pitch'):
		pitch = int(cpsseg.transMethod.split()[1])
		srcPitch = cpsseg.desc['MIDIPitch-seg'].get(0, None) 
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
		return quantize(output, quantizef)
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

