import subprocess, platform, sys, os, util



def makeConcatenationCsdFile(outputCsdPath, outputSoundfilePath, channelRenderMethod, sr, kr, scoreText, cpsLength, maxOverlaps):
	if channelRenderMethod in ["mix", None]:
		nchnls = 2 # mono of stereo depending on corpus sf
	elif channelRenderMethod == "oneChannelPerVoice":
		nchnls = cpsLength
	elif channelRenderMethod == "oneChannelPerOverlap":
		nchnls = maxOverlaps
	else:
		util.error("csdrenderer", "no know render method %s\n"%channelRenderMethod)

	fh = open(outputCsdPath, 'w')
	fh.write( '''<CsoundSynthesizer>
<CsOptions>
-o %s --format=%s
</CsOptions>
<CsInstruments>
sr = %i
ksmps = %i
nchnls = %i

giNoteCounter init 1
0dbfs = 1

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
	iSimSelectNumb = p15
	iTgtSegDur = p16
	iTgtSegNumb = p17
	SstretchCode   strget   p18
	SchannelRenderType   strget   p19
	
	iFileChannels   filenchnls   SCpsFile
	print giNoteCounter ; used by audioguide for its printed progress bar

	iStrCmpResult  strcmp   SstretchCode, "transpose"
	if (iStrCmpResult == 0) then ; TAPE HEAD TIME STRETCHING (transposition change)
		istretch = iCpsSegDur/iTgtSegDur
		iCpsSegDur = iCpsSegDur * (1/istretch)
		iDecayTime = iDecayTime * (1/istretch)
		iTransposition = istretch ; overwrites any ag-supplied transposition !
		p3 = iTgtSegDur
	endif 

	; get input sound for this corpus segment	
	if (iFileChannels == 2) then ; STEREO
		asnd1, asnd2  diskin2 SCpsFile, iTransposition, iStartRead
	elseif (iFileChannels == 1) then ; MONO
		asnd1         diskin2 SCpsFile, iTransposition, iStartRead
		asnd2 = asnd1 ; equal balance between L and R
	endif 

	iStrCmpResult  strcmp   SstretchCode, "pv"
	if (iStrCmpResult == 0) then ; DO PHASE VOCODER TIME STRETCHING
		istretch = iCpsSegDur/iTgtSegDur
		iCpsSegDur = iCpsSegDur * (1/istretch)
		iDecayTime = iDecayTime * (1/istretch)
		p3 = iTgtSegDur
		kbuflen = 100
		asnd1    pvsbuffer_module   asnd1, istretch, kbuflen, iTransposition, 1024, 256, 1024, 1
	endif

	; do envelope
	aAmp    linseg   0, iAttackTime, 1, iCpsSegDur-iDecayTime-iAttackTime, 1, iDecayTime, 0
	aAmp   pow    aAmp, iEnvSlope
	aAmp = aAmp * ampdbfs(iCpsAmpDb)
	asnd1 = asnd1 * aAmp
	asnd2 = asnd2 * aAmp
	
	; write to file
	iStrCmpResult  strcmp   SchannelRenderType, "mix"
	if (iStrCmpResult == 0) then
		iOutCh1 = 1
		iOutCh2 = 2
	endif
	iStrCmpResult  strcmp   SchannelRenderType, "oneChannelPerVoice"
	if (iStrCmpResult == 0) then
		iOutCh1 = p14+1
		iOutCh2 = p14+1
	endif
	iStrCmpResult  strcmp   SchannelRenderType, "oneChannelPerOverlap"
	if (iStrCmpResult == 0) then
		iOutCh1 = p15+1
		iOutCh2 = p15+1
	endif

	outch     int(iOutCh1), asnd1, int(iOutCh2), asnd2
	giNoteCounter = giNoteCounter+1 ; increment note counter
endin





instr 2 ; simple player
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
; p2 - corpus segment start time
; p3 - corpus segment duration
; p4 - envelope gain in dB (0=no gain)
; p5 - corpus segment filename (string)
; p6 - corpus segment start time (skip into file)
; p7 - corpus segment transposition in semitones
; p8 - corpus segment rms peak amp
; p9 - corpus segment peak time in sec
; p10 - corpus segment effective duration in sec
; p11 - envelope attack time in sec
; p12 - envelope release time in sec
; p13 - envelope slope - 1=linear, 2=exp, 0.5=log
; p14 - corpus segment's index in the user's corpus entry
; p15 - how many other sounds have been selected at this same time
; p16 - the corresponding target segment's duration
; p17 - the corresponding target segment's number
; p18 - the stretch mapping the target and corpus durations.  none=no change, 

%s
e
</CsScore>
</CsoundSynthesizer>'''%(outputSoundfilePath, os.path.splitext(outputSoundfilePath)[1][1:], sr, kr, nchnls, scoreText) )




def render(file, totalEvents, printerobj=None):
	eventCounter = 0
	if printerobj != None: printerobj.startPercentageBar(upperLabel="RENDERING with CSOUND", total=totalEvents)
	csoundCommand = ['ulimit -n 2000 ;', 'csound', file]
	#print('\tRENDER WITH CSOUND --> "' + ' '.join(csoundCommand)+ '"\n')
	cs = subprocess.Popen(' '.join(csoundCommand), shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	while True:
		o = cs.stderr.readline()
		if o == '' and cs.poll() != None: break
		o = o.split()
		if len(o) < 3: continue
		if o[2] == 'giNoteCounter': 
			if printerobj != None: printerobj.percentageBarNext(lowerLabel="f")
			eventCounter += 1
	if printerobj != None: printerobj.percentageBarClose(txt="Rendered %i events."%eventCounter)





def playFile(file):
	commandLinePlayers = {'Darwin': 'afplay', 'Linux': 'aplay', 'Windows': 'mplay32 \play'}
	command = '%s "%s"'%(commandLinePlayers[platform.system()], file)
	try:
		cs = subprocess.call(command, shell=True)
	except KeyboardInterrupt:
		print('\n\n')
		sys.exit(0)




	


