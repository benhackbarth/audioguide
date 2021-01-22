############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import subprocess, platform, sys, os
import audioguide.util as util



def makeConcatenationCsdFile(outputCsdPath, outputSoundfilePath, channelRenderMethod, sr, kr, scoreText, cpsLength, listOfSfchannelsInScore, maxOverlaps, instruments, numberClasses, bits=32, useTargetAmplitude=0):	
	if channelRenderMethod == "corpusmax":
		nchnls = max(listOfSfchannelsInScore) # use maximum number of channels for a corpus item
	elif channelRenderMethod in ["mix", "stereo", "targetoutputmix"]:
		nchnls = 2 # mono of stereo depending on corpus sf
	elif channelRenderMethod == "oneChannelPerVoice":
		nchnls = cpsLength
	elif channelRenderMethod == "oneChannelPerOverlap":
		nchnls = maxOverlaps + 1
	elif channelRenderMethod == "oneChannelPerInstrument":
		nchnls = len(instruments.instruments)
	elif channelRenderMethod == "oneChannelPerClassification":
		nchnls = numberClasses
	else:
		util.error("csdrenderer", "No known channel render method '%s'\n"%channelRenderMethod)

	if bits == 16: bitflag = '-s'
	elif bits == 24: bitflag = '-3'
	elif bits == 32: bitflag = '-f'


	fh = open(outputCsdPath, 'w')
	fh.write( '''<CsoundSynthesizer>
<CsOptions>
-o %s --format=%s %s --omacro:channelRenderMethod=0 --omacro:durationStretchMethod=0 --omacro:useTargetAmplitude=%i 
</CsOptions>
<CsInstruments>
sr = %i
ksmps = %i
nchnls = %i

giNoteCounter init 1
gkTargetRms   init 0.
0dbfs = 1


opcode   getTargetDescriptorFromTable, k, i
	iftable	xin
	kabstime timek
	kdesc    table3   kabstime, iftable, 0
	printks "ktime = %%.5f val = %%.5f\\n", 0.1, kabstime, kdesc
	xout	   kdesc	
endop


opcode	pvsbuffer_module, a, akkkiiii
	ain, kspeed, kbuflen, kscale, iFFTsize, ioverlap, iwinsize, iwintype	xin
	kPhOffset	=	0
	ktrig		changed		kbuflen
	ibuflen	init	1
	kspeed	init	1
	kscale	init	1
	if ktrig==1 then
	 reinit	UPDATE
	endif
	UPDATE:
	ibuflen		=	i(kbuflen)
	iphasor		ftgenonce		0, 0, 65536, 7, 0, 65536, 1
	aread 		osciliktp 	kspeed/ibuflen, iphasor, kPhOffset
	kread		downsamp	  aread
	kread		=		kread * ibuflen
	aFB		init		0
	f_anal 		pvsanal		ain+aFB, iFFTsize, ioverlap, iwinsize, iwintype
	ibuffer,ktime  	pvsbuffer   	f_anal, ibuflen
	rireturn
	khandle		init 		ibuffer
	f_buf  		pvsbufread  	kread , khandle
	f_scale		pvscale 	f_buf, kscale
	aresyn 		pvsynth  	f_scale
	xout		   aresyn	
endop



instr 1
	iCpsSegDur = p3
	iCpsAmpDb = p4
	SCpsFile   strget   p5
	iStartRead = p6
	iTransposition = semitone(p7)
	iRmsAmp = p8
	iPeakTime = p9
	iEffDur = p10
	iAttackTime = p11
	iDecayTime = p12
	iEnvSlope = p13
	iCorpusIdx = p14
	iInstrumentIdx = p15
	iSimSelectNumb = p16
	iTgtSegDur = p17
	iTgtSegNumb = p18
	iClassification = p19
	SstretchCode   strget   p20
	SchannelRenderType   strget   p21
	
	print giNoteCounter ; used by audioguide for its printed progress bar

	iStrCmpResult  strcmp   SstretchCode, "transpose"
	if (iStrCmpResult == 0) then ; TAPE HEAD TIME STRETCHING (transposition change)
		istretch = iCpsSegDur/iTgtSegDur
		iCpsSegDur = iCpsSegDur * (1/istretch)
		iDecayTime = iDecayTime * (1/istretch)
		iTransposition = istretch ; overwrites any ag-supplied transposition !
		p3 = iTgtSegDur
	endif 

	; do envelope
	if (iAttackTime == 0 && iDecayTime == 0) then
		aAmp init 1
	elseif (iAttackTime == 0) then
		aAmp    linseg   1, iCpsSegDur-iDecayTime, 1, iDecayTime, 0
	elseif (iDecayTime == 0) then
		aAmp    linseg   0, iAttackTime, 1, iCpsSegDur-iAttackTime, 1
	else
		aAmp    linseg   0, iAttackTime, 1, iCpsSegDur-iDecayTime-iAttackTime, 1, iDecayTime, 0
	endif
	aAmp   pow    aAmp, iEnvSlope
	aAmp = aAmp * ampdbfs(iCpsAmpDb)


	asnd1 init 0
	asnd2 init 0
	asnd3 init 0
	asnd4 init 0
	
	; get input sound for this corpus segment	
	iFileChannels   filenchnls   SCpsFile
	if (iFileChannels == 1) then
		asnd1     diskin2 SCpsFile, iTransposition, iStartRead
		asnd1 = asnd1 * aAmp
	elseif (iFileChannels == 2) then
		asnd1, asnd2  diskin2 SCpsFile, iTransposition, iStartRead
		asnd1 = asnd1 * aAmp
		asnd2 = asnd2 * aAmp
	elseif (iFileChannels == 4) then
		asnd1, asnd2, asnd3, asnd4  diskin2 SCpsFile, iTransposition, iStartRead
		asnd1 = asnd1 * aAmp
		asnd2 = asnd2 * aAmp
		asnd3 = asnd3 * aAmp
		asnd4 = asnd4 * aAmp
	endif 


	iStrCmpResult  strcmp   SstretchCode, "pv"
	if (iStrCmpResult == 0) then ; DO PHASE VOCODER TIME STRETCHING
		istretch = iCpsSegDur/iTgtSegDur
		iCpsSegDur = iCpsSegDur * (1/istretch)
		iDecayTime = iDecayTime * (1/istretch)
		p3 = iTgtSegDur
		kbuflen = 1
		if (iFileChannels == 1) then
			asnd1   pvsbuffer_module   asnd1, istretch, kbuflen, iTransposition, 1024, 256, 1024, 1
		elseif (iFileChannels == 2) then
			asnd1   pvsbuffer_module   asnd1, istretch, kbuflen, iTransposition, 1024, 256, 1024, 1
			asnd2   pvsbuffer_module   asnd2, istretch, kbuflen, iTransposition, 1024, 256, 1024, 1
		elseif (iFileChannels == 4) then
			asnd1   pvsbuffer_module   asnd1, istretch, kbuflen, iTransposition, 1024, 256, 1024, 1
			asnd2   pvsbuffer_module   asnd2, istretch, kbuflen, iTransposition, 1024, 256, 1024, 1
			asnd3   pvsbuffer_module   asnd3, istretch, kbuflen, iTransposition, 1024, 256, 1024, 1
			asnd4   pvsbuffer_module   asnd4, istretch, kbuflen, iTransposition, 1024, 256, 1024, 1
		endif 
	endif

	if ($useTargetAmplitude == 1) then
		krmscorpus   rms  (asnd1)
		kampscalar   = gkTargetRms/krmscorpus
		kampscalar   limit  kampscalar, 0, 1 ; dont boost over 1.0
		printks "tgt = %%.5f cps = %%.5f scalar = %%.5f\\n", 0.1, gkTargetRms, krmscorpus, kampscalar
		if (iFileChannels == 1) then
			asnd1 = asnd1 * kampscalar
		elseif (iFileChannels == 2) then
			asnd1 = asnd1 * kampscalar
			asnd2 = asnd2 * kampscalar
		elseif (iFileChannels == 4) then
			asnd1 = asnd1 * kampscalar
			asnd2 = asnd2 * kampscalar
			asnd3 = asnd3 * kampscalar
			asnd4 = asnd4 * kampscalar
		endif 
	endif






	; NEW write to file
	anull init 0
	iStrCmpResult  strcmp   SchannelRenderType, "corpusmax"
	if (iStrCmpResult == 0) then
		if (iFileChannels == 1) then ; MONO SOUNDS go into ALL CHANNELS
			if (nchnls == 1) then
				out    asnd1
			elseif (nchnls == 2) then
				outs   asnd1, asnd1
			elseif (nchnls == 4) then
				outq   asnd1, asnd1, asnd1, asnd1
			endif 
		elseif (iFileChannels == 2) then ; STEREO SOUNDS
			if (nchnls == 1) then
				out    asnd1+asnd2
			elseif (nchnls == 2) then
				outs   asnd1, asnd2
			elseif (nchnls == 4) then
				outq   asnd1, asnd2, asnd1, asnd2
			endif 
		elseif (iFileChannels == 4) then; QUAD SOUNDS
			if (nchnls == 1) then
				out    asnd1+asnd2+asnd3+asnd4
			elseif (nchnls == 2) then
				outs   asnd1+asnd2, asnd3+asnd4
			elseif (nchnls == 4) then
				outq   asnd1, asnd2, asnd3, asnd4
			endif 			
		endif 
	endif


	iStrCmpResult  strcmp   SchannelRenderType, "stereo"
	if (iStrCmpResult == 0) then
		if (iFileChannels == 1) then ; a MONO file
			outs   asnd1, asnd1
		elseif (iFileChannels == 2) then
			outs   asnd1, asnd2
		elseif (iFileChannels == 4) then
			outs   asnd1+asnd2, asnd3+asnd4 ; hmmmmm..
		endif 
	endif

	iStrCmpResult  strcmp   SchannelRenderType, "oneChannelPerVoice"
	if (iStrCmpResult == 0) then
		if (iFileChannels == 1) then
			outch     int(p14+1), asnd1
		elseif (iFileChannels == 2) then
			outch     int(p14+1), asnd1+asnd2
		elseif (iFileChannels == 4) then
			outch     int(p14+1), asnd1+asnd2+asnd3+asnd4
		endif 
	endif

	iStrCmpResult  strcmp   SchannelRenderType, "oneChannelPerOverlap"
	if (iStrCmpResult == 0) then
		if (iFileChannels == 1) then
			outch     int(p16+1), asnd1
		elseif (iFileChannels == 2) then
			outch     int(p16+1), asnd1+asnd2
		elseif (iFileChannels == 4) then
			outch     int(p16+1), asnd1+asnd2+asnd3+asnd4
		endif 
	endif
	
	iStrCmpResult  strcmp   SchannelRenderType, "oneChannelPerClassification"
	if (iStrCmpResult == 0) then
		if (iFileChannels == 1) then
			outch     int(iClassification+1), asnd1
		elseif (iFileChannels == 2) then
			outch     int(iClassification+1), asnd1+asnd2
		elseif (iFileChannels == 4) then
			outch     int(iClassification+1), asnd1+asnd2+asnd3+asnd4
		endif 
	endif
	
	iStrCmpResult  strcmp   SchannelRenderType, "oneChannelPerInstrument"
	if (iStrCmpResult == 0) then
		if (iFileChannels == 1) then
			outch     int(p15+1), asnd1
		elseif (iFileChannels == 2) then
			outch     int(p15+1), asnd1+asnd2
		elseif (iFileChannels == 4) then
			outch     int(p15+1), asnd1+asnd2+asnd3+asnd4
		endif 
	endif

	iStrCmpResult  strcmp   SchannelRenderType, "targetoutputmix"
	if (iStrCmpResult == 0) then
		atmp init 0
		if (iFileChannels == 1) then ; a MONO file
			outs   atmp, asnd1
		elseif (iFileChannels == 2) then
			outs   atmp, asnd1+asnd2
		elseif (iFileChannels == 4) then
			outs   atmp, asnd1+asnd2+asnd3+asnd4 ; hmmmmm..
		endif 
	endif
	
	giNoteCounter = giNoteCounter+1 ; increment note counter
endin













instr 2 ; target sound
	iDur = p3
	iScaleDb = p4
	StgtFile   strget   p5
	iStartRead = p6
	iPlaySoundChn1Bool = p7
	
	iFileChannels   filenchnls   StgtFile

	if (iFileChannels == 2) then ; STEREO
		asnd1, asnd2  diskin2 StgtFile, 1, iStartRead
	elseif (iFileChannels == 1) then ; MONO
		asnd1         diskin2 StgtFile, 1, iStartRead
		asnd2 = asnd1 ; equal balance between L and R
	endif 
	gkTargetRms  rms  asnd1+asnd2
	if (iPlaySoundChn1Bool == 1) then
		atmp init 0
		outs (asnd1+asnd2)*ampdbfs(iScaleDb), atmp
	endif
endin

</CsInstruments>
<CsScore>
%s

%s
e
</CsScore>
</CsoundSynthesizer>'''%(outputSoundfilePath, os.path.splitext(outputSoundfilePath)[1][1:], bitflag, useTargetAmplitude, sr, kr, nchnls, instru2helpstring(), scoreText) )




def instru2helpstring():
	return '''; p2 = start time, p3 = duration, p4 = gain in dB (0=no gain), p5 = segment filename, p6 = sf filetime skip, p7 = semitone transposition, p8 = rms peak amp, p9 = peak time in sec, p10 = effective duration in sec, p11 = attack time in sec, p12 = decay time in sec, p13 = envelope slope, p14 = corpus idx, p15 = instrument idx, p16 = superimposition idx, p17 = target segment duration, p18 = target segment idx, p19 = classification, p20 = duration stretch code, p21 = channel render mode'''



def makeSimpleCsdFile(outputCsdPath, outputSoundfilePath, sr, kr, scoreText):
	fh = open(outputCsdPath, 'w')
	fh.write( '''<CsoundSynthesizer>
<CsOptions>
-o %s --format=%s
</CsOptions>
<CsInstruments>
sr = %i
ksmps = %i
nchnls = 2

giNoteCounter init 1
0dbfs = 1


instr 1 ; simple player
	iDur = p3
	SCpsFile   strget   p4
	iStartRead = p5
	
	iFileChannels   filenchnls   SCpsFile
	print giNoteCounter ; used by audioguide for its printed progress bar

	; get input sound for this corpus segment	
	if (iFileChannels == 2) then ; STEREO
		asnd1, asnd2  diskin2 SCpsFile, 1, iStartRead
	elseif (iFileChannels == 1) then ; MONO
		asnd1         diskin2 SCpsFile, 1, iStartRead
		asnd2 = asnd1 ; equal balance between L and R
	endif 

	outs asnd1, asnd2
	giNoteCounter = giNoteCounter+1 ; increment note counter
endin

</CsInstruments>
<CsScore>
%s
e
</CsScore>
</CsoundSynthesizer>'''%(outputSoundfilePath, os.path.splitext(outputSoundfilePath)[1][1:], sr, kr, scoreText) )




def makeFtableFromDescriptor(descriptorArray, descriptorName, f2s, csoundSr, csoundKr, tabNumb=1):
	import numpy as np
	lastval = sys.maxsize
	lasttime = -1
	control = int(csoundSr/csoundKr)
	outputStr = 'f%i 0  %%i  -27'%(tabNumb)
	for idx, thisval in enumerate(descriptorArray): 
		if thisval == lastval: continue
		thistime = int((idx*f2s)*control)
		if thistime == lasttime: continue
		outputStr += '  %i  %f'%(thistime, thisval)
		lasttime = thistime
		lastval = thisval
	outputStr += '; %s\n'%descriptorName
	outputStr = outputStr%util.nextPowerOfTwo(thistime) # add table length as power of two
	return outputStr



def render(file, totalEvents, printerobj=None):
	eventCounter = 0
	if printerobj != None: printerobj.startPercentageBar(upperLabel="RENDERING with CSOUND", total=totalEvents)
	csoundCommand = ['ulimit -n 2000 ;', 'csound', '"%s"'%file]
	cs = subprocess.Popen(' '.join(csoundCommand), shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	while True:
		o = cs.stderr.readline().decode("utf-8")
		if o == '' and cs.poll() != None: break
		o = o.split()
		if len(o) < 3: continue
		if o[2] == 'giNoteCounter': 
			if printerobj != None: printerobj.percentageBarNext(lowerLabel="f")
			eventCounter += 1
	if printerobj != None: printerobj.percentageBarClose(txt="Rendered %i events."%eventCounter)








def normalize(file, db=-3):
	cs = subprocess.Popen('scale -F 0.0 %s'%file, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	scalefactor = 'notfound'
	while True:
		o = cs.stderr.readline().decode("utf-8")
		if o == '' and cs.poll() != None: break
		if o.startswith('Max scale factor'):
			scalefactor = float(o.split()[4]) * util.dbToAmp(db)
	if scalefactor == 'notfound':
		print ("ERROR in csound normalization algorithm")
		return
	# scale to temporary file
	cs = subprocess.Popen("scale -o /tmp/%s -F %f %s"%(os.path.split(file)[1], scalefactor, file), shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	while True:
		o = cs.stderr.readline().decode("utf-8")
		if o == '' and cs.poll() != None: break
	# replace file with new file
	cs = subprocess.call("mv /tmp/%s %s"%(os.path.split(file)[1], file), shell=True)






def playFile(file):
	commandLinePlayers = {'Darwin': 'afplay', 'Linux': 'aplay', 'Windows': 'mplay32 \play'}
	command = '%s "%s"'%(commandLinePlayers[platform.system()], file)
	try:
		cs = subprocess.call(command, shell=True)
	except KeyboardInterrupt:
		print('\n\n')
		sys.exit(0)




	


