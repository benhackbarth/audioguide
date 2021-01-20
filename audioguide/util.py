############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

from math import log10, log
import sys, os, subprocess, random
import numpy as np

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
     _.-"   `__'   (/) ".
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
	sys.exit(1)


def error(errorType, errorData, exitcode=1):
	print(ladytext("%s ERROR: %s"%(bold(errorType.upper()), errorData)))
	exit(exitcode)



def missing_module(modulename, exitcode=1):
	print("\n\nYou are missing python's %s package. To install with pip, try the following terminal command:"%modulename)
	print("\n%s -m pip install %s\n"%(sys.executable, modulename))
	print("\nif you do not have pip, run: sudo easy_install pip\n\n")
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



def matchString(testString, matchStr, caseSensative=True):
	if not caseSensative:
		testString = testString.lower()
		matchStr = matchStr.lower()
	return testString.find(matchStr) != -1


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
		print(ValueError, "on line", idx, "in", path)
	return timeList


def printDict(heading, dict, postLevel, p):
	p.middle(heading, postLevel)
	for key, val in dict.items():
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
	import subprocess, os
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
			for (str, loc), (key, valloc, valtype) in stdoutReturnDict.items():
				if o[loc] == str:
					dictStore[key] = o[valloc]
					if valtype == int: dictStore[key] = int(dictStore[key])
					if valtype == float: dictStore[key] = float(dictStore[key])
	return out, dictStore




def histogram(l):
	# returns sorted list histogram with highest value first.
	d = {}
	for i in l:
		if i in d: d[i] += 1
		else: d[i] = 1
	sorty = []
	for k, v in d.items():
		sorty.append((v, k))
	sorty.sort()
	sorty.reverse()
	return sorty




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


def verifyPathIsValidSoundfile(file):
	fileExtension = os.path.splitext(file)[1]
	isValidSoundfile = False
	for ext in ['.wav', '.aiff', '.aif', '.au']:
		if ext.lower() == fileExtension.lower():
			isValidSoundfile = True
			break
	return isValidSoundfile


def cpsPathToTrackName(fileordir):
	output = os.path.split(fileordir)[1]
	if os.path.isdir(fileordir): output += '/'
	return output



#def initStretchedSoundfile(sffile, start, end, stretchcoeff, svpbin, p=None):
#	supervp_flags = '''-Afft -Np0 -M0.092879802s -oversamp 8 -Whamming -P1 -td_thresh 1.2 -td_G 2.5 -td_band 0,22050 -td_nument 10 -td_minoff 0.02s -td_mina 9.9999997e-06 -td_minren 0 -td_evstre 1 -td_ampfac 1.5 -td_relax 100 -td_relaxto 1 -FCombineMul -shape 1 -Vuf -4'''
#	
#	stretcheddir = os.path.join(os.path.dirname(__file__), 'data_stretched_sfs')
#	if not os.path.exists(stretcheddir): os.makedirs(stretcheddir)
#	# get filename
#	sfroot, sfhead = os.path.split(sffile)
#	sfheadroot, sfheadext = os.path.splitext(sfhead)
#	checksum = listToCheckSum([sffile, start, end, stretchcoeff])
#	stretchedfilename = os.path.join(stretcheddir, '%sx%.2f-%s%s'%(sfheadroot, stretchcoeff, checksum, sfheadext))
#	if os.path.exists(stretchedfilename): return stretchedfilename
#	#################################
#	## do supervp time stretching! ##
#	#################################
#	# make temporary stretch coeff file (needed by supervp)
#	stretchParamFile = os.path.join(stretcheddir, 'stretchtmpfile.txt')
#	fh = open(stretchParamFile, 'w')
#	fh.write("-10 1\n0 %s\n"%(stretchcoeff))
#	fh.close()
#	# add start time and end time offsets to flags if needed
#	if start != None: supervp_flags += ' -B%f'%start
#	if end != None: supervp_flags += ' -E%f'%end
#	# make supervp command!
#	command = '%s -t -Z -U -S"%s" %s -D"%s" "%s"'%(svpbin, sffile, supervp_flags, stretchParamFile, stretchedfilename)
#	#print 'TARGET TIME STRETCH - "%s"'%command
#	executeCommand( command )
#	return stretchedfilename


def parseEquationString(mstr, symbs):
	# need to sort by reverse order length so that the longest strings are tested first
	symbs = sorted(symbs, key=len, reverse=True) 
	for symb in symbs:
		if mstr.rfind(symb) != -1: # found it!
			mstr_p = mstr.split(symb)
			return [ mstr_p[0].strip(), symb, mstr_p[1].strip() ]
	# shouldn't get here is everything worked out
	error('parseEquationString', '"%s" - Cannot parse this equation, is not well formed'%mstr)



def getScaleDb(scaleDb, sfsegmentObj):
	# just a float
	if True in [isinstance(scaleDb, int), isinstance(scaleDb, float)]:
		return scaleDb
	elif scaleDb == 'filenamedyn':
		return sfsegmentObj.rmsAmplitudeFromFilename
	else:
		print("\n\nerror - no known scaleDb argument type", scaleDb)
		sys.exit()



def getTransposition(tgtseg, cpsseg):
	# NADA
	if cpsseg.transMethod == None: return quantize(0, cpsseg.transQuantize)
	# FORCE A SEMITONE TRANSPOSITION
	elif cpsseg.transMethod.startswith('semitone'):
		trans = float(cpsseg.transMethod.split()[1])
		return trans
	# RANDOM RANGE
	elif cpsseg.transMethod.startswith('random'):
		pieces = cpsseg.transMethod.split()
		output = random.uniform(float(pieces[1]), float(pieces[2]))
		return quantize(output, cpsseg.transQuantize)
	# 
	elif cpsseg.transMethod in ['f0']:
		tgtPitch = tgtseg.desc.get('f0-seg') 
		srcPitch = cpsseg.desc.get('f0-seg') 
		if tgtPitch <= 0 or srcPitch <= 0:
			output = 0.
		else:
			output = frq2Midi(tgtPitch)-frq2Midi(srcPitch)
		return quantize(output, cpsseg.transQuantize)
	# 
	elif cpsseg.transMethod in ['f0-chroma']:
		tgtPitch = tgtseg.desc.get('f0-seg') 
		srcPitch = cpsseg.desc.get('f0-seg') 
		if tgtPitch <= 0 or srcPitch <= 0:
			output = 0.
		else:
			tgtmid = frq2Midi(tgtPitch) % 12
			cpsmid = frq2Midi(srcPitch) % 12
			output = tgtmid-cpsmid
			if output > 6: output = ((output*-1)%12)*-1
			# flip octaves to make smallest possible transposition
		return quantize(output, cpsseg.transQuantize)





def listToCheckSum(items, enc="latin1"):
	import hashlib
	m = hashlib.md5()
	for item in items:
		if type(item) in [int, float, np.float64]:
			item = str(item).encode(enc)
		elif type(item) in [str]:
			item = item.encode('utf-8').decode(enc).encode(enc)
		m.update(item)
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
		print("ERROR in %% string here : '%s'!"%input1)
		sys.exit(1)






