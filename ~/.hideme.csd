<CsoundSynthesizer>
<CsOptions>
-o "/Users/ben/Documents/audioguide/output/2026-11-17_14-02-13-output.wav" --format=wav -s --omacro:channelRenderMethod=0 --omacro:durationStretchMethod=0 --omacro:useTargetAmplitude=0 
</CsOptions>
<CsInstruments>
sr = 48000
ksmps = 128
nchnls = 1

giNoteCounter init 1
gkTargetRms   init 0.
0dbfs = 1


opcode   getTargetDescriptorFromTable, k, i
	iftable	xin
	kabstime timek
	kdesc    table3   kabstime, iftable, 0
	printks "ktime = %.5f val = %.5f\n", 0.1, kabstime, kdesc
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
		printks "tgt = %.5f cps = %.5f scalar = %.5f\n", 0.1, gkTargetRms, krmscorpus, kampscalar
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
; p2 = start time, p3 = duration, p4 = gain in dB (0=no gain), p5 = segment filename, p6 = sf filetime skip, p7 = semitone transposition, p8 = rms peak amp, p9 = peak time in sec, p10 = effective duration in sec, p11 = attack time in sec, p12 = decay time in sec, p13 = envelope slope, p14 = corpus idx, p15 = instrument idx, p16 = superimposition idx, p17 = target segment duration, p18 = target segment idx, p19 = classification, p20 = duration stretch code, p21 = channel render mode

i2  0.  11.403447  0.000000  "/Users/ben/Documents/audioguide/examples/cage.aiff"  0.000000  0

i1  0.244  0.279  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  51.258  0.000  -29.288  0.052  0.255  0.010  0.084  1.000  0.000  -1  0  0.325079  0  0  "None"  "corpusmax"
i1  0.279  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  17.578  0.000  -32.534  0.017  0.313  0.010  0.104  1.000  0.000  -1  1  0.290249  0  0  "None"  "corpusmax"
i1  0.290  0.209  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  48.135  0.000  -30.101  0.017  0.209  0.010  0.063  1.000  0.000  -1  2  0.278639  0  0  "None"  "corpusmax"
i1  0.302  0.267  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  50.968  0.000  -33.807  0.075  0.267  0.010  0.080  1.000  0.000  -1  3  0.267029  0  0  "None"  "corpusmax"
i1  0.615  0.186  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  0.406  0.000  -24.411  0.087  0.186  0.010  0.056  1.000  0.000  -1  0  0.452789  1  0  "None"  "corpusmax"
i1  0.615  0.418  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  48.356  0.000  -34.228  0.006  0.383  0.010  0.125  1.000  0.000  -1  1  0.452789  1  0  "None"  "corpusmax"
i1  0.673  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  14.373  0.000  -33.087  0.029  0.325  0.010  0.104  1.000  0.000  -1  2  0.394739  1  0  "None"  "corpusmax"
i1  0.697  0.313  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  1.022  0.000  -32.796  0.029  0.290  0.010  0.094  1.000  0.000  -1  3  0.371519  1  0  "None"  "corpusmax"
i1  1.091  0.209  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  52.048  0.000  -38.664  0.041  0.197  0.010  0.063  1.000  0.000  -1  0  0.336689  2  0  "None"  "corpusmax"
i1  1.091  0.267  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  50.968  0.000  -33.807  0.075  0.267  0.010  0.080  1.000  0.000  -1  1  0.336689  2  0  "None"  "corpusmax"
i1  1.103  0.337  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  5.492  0.000  -31.192  0.041  0.313  0.010  0.101  1.000  0.000  -1  2  0.325079  2  0  "None"  "corpusmax"
i1  1.103  0.290  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  36.978  0.000  -24.003  0.017  0.279  0.010  0.087  1.000  0.000  -1  3  0.325079  2  0  "None"  "corpusmax"
i1  1.463  0.232  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  49.888  0.000  -29.685  0.052  0.221  0.010  0.070  1.000  0.000  -1  0  0.638549  3  0  "None"  "corpusmax"
i1  1.463  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  14.373  0.000  -33.087  0.029  0.325  0.010  0.104  1.000  0.000  -1  1  0.638549  3  0  "None"  "corpusmax"
i1  1.463  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  20.503  0.000  -32.794  0.029  0.313  0.010  0.104  1.000  0.000  -1  2  0.638549  3  0  "None"  "corpusmax"
i1  1.463  0.325  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  5.851  0.000  -35.200  0.017  0.302  0.010  0.098  1.000  0.000  -1  3  0.638549  3  0  "None"  "corpusmax"
i1  4.354  0.093  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  20.886  0.000  -39.252  0.041  0.093  0.010  0.028  1.000  0.000  -1  0  0.116100  4  0  "None"  "corpusmax"
i1  4.354  0.104  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  1.509  0.000  -39.619  0.029  0.104  0.010  0.031  1.000  0.000  -1  1  0.116100  4  0  "None"  "corpusmax"
i1  4.354  0.104  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  34.853  0.000  -36.844  0.017  0.104  0.010  0.031  1.000  0.000  -1  2  0.116100  4  0  "None"  "corpusmax"
i1  4.354  0.093  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  0.000  0.000  -49.494  0.006  0.093  0.010  0.028  1.000  0.000  -1  3  0.116100  4  0  "None"  "corpusmax"
i1  4.528  0.209  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  52.048  0.000  -38.664  0.041  0.197  0.010  0.063  1.000  0.000  -1  0  0.208980  5  0  "None"  "corpusmax"
i1  4.528  0.209  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  48.135  0.000  -30.101  0.017  0.209  0.010  0.063  1.000  0.000  -1  1  0.208980  5  0  "None"  "corpusmax"
i1  4.528  0.163  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  17.937  0.000  -25.349  0.029  0.163  0.010  0.049  1.000  0.000  -1  2  0.208980  5  0  "None"  "corpusmax"
i1  4.528  0.186  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  0.406  0.000  -24.411  0.087  0.186  0.010  0.056  1.000  0.000  -1  3  0.208980  5  0  "None"  "corpusmax"
i1  4.760  0.186  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  30.871  0.000  -34.585  0.017  0.174  0.010  0.056  1.000  0.000  -1  0  0.406349  6  0  "None"  "corpusmax"
i1  4.760  0.337  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  5.492  0.000  -31.192  0.041  0.313  0.010  0.101  1.000  0.000  -1  1  0.406349  6  0  "None"  "corpusmax"
i1  4.760  0.325  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  5.851  0.000  -35.200  0.017  0.302  0.010  0.098  1.000  0.000  -1  2  0.406349  6  0  "None"  "corpusmax"
i1  4.760  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  17.578  0.000  -32.534  0.017  0.313  0.010  0.104  1.000  0.000  -1  3  0.406349  6  0  "None"  "corpusmax"
i1  5.178  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  51.548  0.000  -37.024  0.029  0.325  0.010  0.104  1.000  0.000  -1  0  0.383129  7  0  "None"  "corpusmax"
i1  5.178  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  14.373  0.000  -33.087  0.029  0.325  0.010  0.104  1.000  0.000  -1  1  0.383129  7  0  "None"  "corpusmax"
i1  5.178  0.337  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  62.578  0.000  -28.559  0.110  0.325  0.010  0.101  1.000  0.000  -1  2  0.383129  7  0  "None"  "corpusmax"
i1  5.178  0.313  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  1.022  0.000  -32.796  0.029  0.290  0.010  0.094  1.000  0.000  -1  3  0.383129  7  0  "None"  "corpusmax"
i1  6.153  0.209  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  52.048  0.000  -38.664  0.041  0.197  0.010  0.063  1.000  0.000  -1  0  0.267029  8  0  "None"  "corpusmax"
i1  6.153  0.209  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  48.135  0.000  -30.101  0.017  0.209  0.010  0.063  1.000  0.000  -1  1  0.267029  8  0  "None"  "corpusmax"
i1  6.177  0.232  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  34.609  0.000  -40.015  0.087  0.232  0.010  0.070  1.000  0.000  -1  2  0.243810  8  0  "None"  "corpusmax"
i1  6.177  0.267  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  50.968  0.000  -33.807  0.075  0.267  0.010  0.080  1.000  0.000  -1  3  0.243810  8  0  "None"  "corpusmax"
i1  6.432  0.174  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  54.126  0.000  -32.093  0.064  0.174  0.010  0.052  1.000  0.000  -1  0  0.406349  9  0  "None"  "corpusmax"
i1  6.432  0.186  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  14.025  0.000  -42.588  0.017  0.174  0.010  0.056  1.000  0.000  -1  1  0.406349  9  0  "None"  "corpusmax"
i1  6.432  0.186  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  0.406  0.000  -24.411  0.087  0.186  0.010  0.056  1.000  0.000  -1  2  0.406349  9  0  "None"  "corpusmax"
i1  6.432  0.209  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  20.143  0.000  -35.794  0.017  0.186  0.010  0.063  1.000  0.000  -1  3  0.406349  9  0  "None"  "corpusmax"
i1  6.850  0.128  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  52.941  0.000  -30.226  0.029  0.116  0.010  0.038  1.000  0.000  -1  0  0.220590  10  0  "None"  "corpusmax"
i1  6.850  0.221  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  40.171  0.000  -44.656  0.006  0.197  0.010  0.066  1.000  0.000  -1  1  0.220590  10  0  "None"  "corpusmax"
i1  6.850  0.174  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  6.908  0.000  -31.279  0.017  0.163  0.010  0.052  1.000  0.000  -1  2  0.220590  10  0  "None"  "corpusmax"
i1  6.850  0.209  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  52.048  0.000  -38.664  0.041  0.197  0.010  0.063  1.000  0.000  -1  3  0.220590  10  0  "None"  "corpusmax"
i1  7.117  0.093  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  0.000  0.000  -49.494  0.006  0.093  0.010  0.028  1.000  0.000  -1  0  0.162540  11  0  "None"  "corpusmax"
i1  7.117  0.128  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  23.034  0.000  -43.258  0.029  0.128  0.010  0.038  1.000  0.000  -1  1  0.162540  11  0  "None"  "corpusmax"
i1  7.117  0.116  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  36.304  0.000  -39.641  0.017  0.116  0.010  0.035  1.000  0.000  -1  2  0.162540  11  0  "None"  "corpusmax"
i1  7.129  0.128  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  23.243  0.000  -30.759  0.029  0.116  0.010  0.038  1.000  0.000  -1  3  0.150930  11  0  "None"  "corpusmax"
i1  7.291  0.186  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  30.871  0.000  -34.585  0.017  0.174  0.010  0.056  1.000  0.000  -1  0  0.325079  12  0  "None"  "corpusmax"
i1  7.303  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  17.578  0.000  -32.534  0.017  0.313  0.010  0.104  1.000  0.000  -1  1  0.313469  12  0  "None"  "corpusmax"
i1  7.303  0.279  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  51.258  0.000  -29.288  0.052  0.255  0.010  0.084  1.000  0.000  -1  2  0.313469  12  0  "None"  "corpusmax"
i1  7.314  0.255  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  0.592  0.000  -24.579  0.029  0.244  0.010  0.077  1.000  0.000  -1  3  0.301859  12  0  "None"  "corpusmax"
i1  7.837  0.337  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  6.560  0.000  -19.835  0.041  0.337  0.010  0.101  1.000  0.000  -1  0  0.580499  13  0  "None"  "corpusmax"
i1  7.837  0.163  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  17.937  0.000  -25.349  0.029  0.163  0.010  0.049  1.000  0.000  -1  1  0.580499  13  0  "None"  "corpusmax"
i1  7.837  0.488  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  49.389  0.000  -28.978  0.041  0.441  0.010  0.146  1.000  0.000  -1  2  0.580499  13  0  "None"  "corpusmax"
i1  7.883  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  20.503  0.000  -32.794  0.029  0.313  0.010  0.104  1.000  0.000  -1  3  0.534059  13  0  "None"  "corpusmax"
i1  8.557  0.279  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  51.258  0.000  -29.288  0.052  0.255  0.010  0.084  1.000  0.000  -1  0  0.359909  14  0  "None"  "corpusmax"
i1  8.568  0.337  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  5.492  0.000  -31.192  0.041  0.313  0.010  0.101  1.000  0.000  -1  1  0.348299  14  0  "None"  "corpusmax"
i1  8.568  0.221  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  52.547  0.000  -34.778  0.052  0.221  0.010  0.066  1.000  0.000  -1  2  0.348299  14  0  "None"  "corpusmax"
i1  8.615  0.186  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  0.406  0.000  -24.411  0.087  0.186  0.010  0.056  1.000  0.000  -1  3  0.301859  14  0  "None"  "corpusmax"
i1  8.951  0.174  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  54.126  0.000  -32.093  0.064  0.174  0.010  0.052  1.000  0.000  -1  0  0.336689  15  0  "None"  "corpusmax"
i1  8.951  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  14.373  0.000  -33.087  0.029  0.325  0.010  0.104  1.000  0.000  -1  1  0.336689  15  0  "None"  "corpusmax"
i1  8.951  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  20.503  0.000  -32.794  0.029  0.313  0.010  0.104  1.000  0.000  -1  2  0.336689  15  0  "None"  "corpusmax"
i1  8.975  0.267  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  50.968  0.000  -33.807  0.075  0.267  0.010  0.080  1.000  0.000  -1  3  0.313469  15  0  "None"  "corpusmax"
i1  9.497  0.534  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  25.588  0.000  -27.638  0.041  0.499  0.010  0.160  1.000  0.000  -1  0  0.626939  16  0  "None"  "corpusmax"
i1  9.497  0.488  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  50.457  0.000  -27.697  0.052  0.453  0.010  0.146  1.000  0.000  -1  1  0.626939  16  0  "None"  "corpusmax"
i1  9.497  0.488  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  49.389  0.000  -28.978  0.041  0.441  0.010  0.146  1.000  0.000  -1  2  0.626939  16  0  "None"  "corpusmax"
i1  9.509  0.639  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  21.641  0.000  -33.082  0.029  0.592  0.010  0.192  1.000  0.000  -1  3  0.615329  16  0  "None"  "corpusmax"
i1  10.310  0.221  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  23.382  0.000  -32.889  0.099  0.221  0.010  0.066  1.000  0.000  -1  0  0.232200  17  0  "None"  "corpusmax"
i1  10.310  0.151  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  0.859  0.000  -30.597  0.029  0.151  0.010  0.045  1.000  0.000  -1  1  0.232200  17  0  "None"  "corpusmax"
i1  10.356  0.186  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  0.406  0.000  -24.411  0.087  0.186  0.010  0.056  1.000  0.000  -1  2  0.185760  17  0  "None"  "corpusmax"
i1  10.356  0.128  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  23.034  0.000  -43.258  0.029  0.128  0.010  0.038  1.000  0.000  -1  3  0.185760  17  0  "None"  "corpusmax"
i1  10.553  0.232  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  34.609  0.000  -40.015  0.087  0.232  0.010  0.070  1.000  0.000  -1  0  0.325079  18  0  "None"  "corpusmax"
i1  10.553  0.348  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  20.503  0.000  -32.794  0.029  0.313  0.010  0.104  1.000  0.000  -1  1  0.325079  18  0  "None"  "corpusmax"
i1  10.577  0.221  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  40.171  0.000  -44.656  0.006  0.197  0.010  0.066  1.000  0.000  -1  2  0.301859  18  0  "None"  "corpusmax"
i1  10.588  0.174  0.000  "/Users/ben/Documents/audioguide/examples/lachenmann.aiff"  35.260  0.000  -39.673  0.017  0.174  0.010  0.052  1.000  0.000  -1  3  0.290249  18  0  "None"  "corpusmax"

e
</CsScore>
</CsoundSynthesizer>