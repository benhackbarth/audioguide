import os
import numpy as np
import audioguide.util as util


#########################
## things to implement ##
#########################
#  * second staff with "other" choices that didn't make it in? or a second bachroll output?
#  * enforced minimum of sounds per instrument per segment?
#  * change signal decomp to support MW - modolus of target segment times before concate?

################################################################################
class instruments:
	def __init__(self, scoreFromUserOptions, usercorpus, outputfile, tgtlength, hopsizesec, p):
		self.active = scoreFromUserOptions != None and len(scoreFromUserOptions.instrumentobjs) != 0
		if not self.active: return

		#
		self.outputfile = outputfile
		self.tgtlength = tgtlength
		self.internaldata = {'notes': 0, 'non_instrument_events': 0, 'selections_per_voice': {}}
		for vidx in range(len(usercorpus)): self.internaldata['selections_per_voice'][vidx] = {}
		
		self.hopsizesec = hopsizesec
		self.instruments = {}
		self.instrument_names = []
		for iidx, ins in enumerate(scoreFromUserOptions.instrumentobjs):
			if ins.name not in self.instrument_names: self.instrument_names.append(ins.name)
			k = '%i-%s'%(iidx, ins.name)
			self.instruments[k] = {}
			self.instruments[k]['notes'] = {}
			self.instruments[k]['params'] = ins
			self.instruments[k]['displayname'] = ins.name
			self.instruments[k]['cpsTags'] = ins.params['cpsTags']
			self.instruments[k]['all_selected_times_in_frames'] = []
			self.instruments[k]['selected_pitches'] = {}
			# this variable holds all valid voices for this instrument
			self.instruments[k]['cps'] = {}
			for c in usercorpus:
				if not c.instrTag in self.instruments[k]['cpsTags']: continue
				self.instruments[k]['cps'][c.voiceID] = ins.params.copy()
				# update with instrument params if not user-supplied at corpus level
				# add values if not supplied
				voiceparam_defaults = {'technique': None, 'notehead': None, 'annotation': None, 'articulation': None, 'canPlayWhileDoingSomethingElse': False}
				voiceparam_defaults.update(c.instrParams)
				self.instruments[k]['cps'][c.voiceID].update(voiceparam_defaults)
				# other internal shit
				self.instruments[k]['cps'][c.voiceID]['overlap_frames'] = np.zeros(tgtlength, dtype=np.int)
				self.instruments[k]['cps'][c.voiceID]['selected_times_in_frames'] = []
				self.instruments[k]['cps'][c.voiceID]['selected_pitches'] = {}
				self.instruments[k]['cps'][c.voiceID]['selected_dbs'] = {}
				
			# temporal restrictions in hop-sized frames
			for voiceID in self.instruments[k]['cps']:
				self.instruments[k]['cps'][voiceID]['minspeed_frames'] = self._s2f(self.instruments[k]['cps'][voiceID]['minspeed'])
			self.instruments[k]['technique_time_constraints'] = {}
			self.instruments[k]['overlap_frames_by_technique'] = {}
			for idx, (constrainingtech, querytech, timesec) in enumerate(ins.params['technique_switch_delay_map']):
				#self.instruments[k]['technique_switch_delay_map'].append([querytech, constrainingtech, self._s2f(timesec)])
				self.instruments[k]['technique_time_constraints'][(querytech, constrainingtech, 'past')] = self._s2f(timesec)
				# add cross associations
				self.instruments[k]['technique_time_constraints'][(constrainingtech, querytech, 'future')] = self._s2f(timesec)
				self.instruments[k]['overlap_frames_by_technique'][querytech] = np.zeros(tgtlength, dtype=np.int)

		self.scoreparams = scoreFromUserOptions.params
	########################################
	def _s2f(self, timesec):
		frame = timesec/self.hopsizesec
		intframe = int(frame)
		if frame > intframe: intframe += 1
		return intframe
	########################################
	def _f2s(self, timeframe):
		sec = timeframe*self.hopsizesec
		return sec
	########################################
	def _testPresenceOfOtherSelections(self, targettimeinframes, instru, voiceID):
		return [vcid for vcid in self.instruments[instru]['cps'] if self.instruments[instru]['cps'][vcid]['overlap_frames'][targettimeinframes] > 0  and vcid != voiceID and not self.instruments[instru]['cps'][vcid]['canPlayWhileDoingSomethingElse']]
	########################################
	def _testOverlapThreshold(self, targettimeinframes, instru, voiceID):
		return self.instruments[instru]['cps'][voiceID]['overlap_frames'][targettimeinframes] >= self.instruments[instru]['cps'][voiceID]['polyphony_max_voices']
	########################################
	def evaluate_voices(self, targettimeinframes, validVoicesList):
		if not self.active: return		
		# first test for valid techniques at this times
		instrumentInvalidTechniques = {}
		instrumentNearestEventInFrames = {}
		for i in self.instruments:
			# test to see what techniques are invalid according to "technique_time_constraints"
			instrumentInvalidTechniques[i] = []
			for (testtech, constrainingtech, direction), minframes in self.instruments[i]['technique_time_constraints'].items():
				if direction == 'past':
					testf = (max(0, targettimeinframes-minframes), targettimeinframes)
				elif direction == 'future':
					testf = (targettimeinframes, targettimeinframes+minframes)
				testslice = self.instruments[i]['overlap_frames_by_technique'][constrainingtech][testf[0]:testf[1]]
				if np.sum(testslice) > 0:
					instrumentInvalidTechniques[i].append(testtech)
			# make speed test info
			seldiff_frames = [targettimeinframes-v for v in self.instruments[i]['all_selected_times_in_frames'] if v != targettimeinframes]
			if len(seldiff_frames) > 0:
				instrumentNearestEventInFrames[i] = np.min(np.abs(seldiff_frames))
			else:
				instrumentNearestEventInFrames[i] = None
		######
		self.valid_instruments_per_voice = {}
		for vc in validVoicesList:
			self.valid_instruments_per_voice[vc] = []
			for i in self.instruments:			
				##########################
				## test if name matches ##
				##########################
				if vc not in self.instruments[i]['cps']:
					continue
				##########################################################################
				## see if any other sounds have already been chosen for this instrument ##
				##########################################################################
				otherActiveVoices = self._testPresenceOfOtherSelections(targettimeinframes, i, vc)
				if len(otherActiveVoices) > 0:
					continue

				###########################################################################
				## see if overlaps are at a max for any other techniques for this instru ##
				###########################################################################
				reachedMaxDensityInVoicesBoolList = [self._testOverlapThreshold(targettimeinframes, i, v) for v in self.instruments[i]['cps']]
				if True in reachedMaxDensityInVoicesBoolList:
					continue

				###########################################
				## test if valid given time restrictions ##
				###########################################
				if self.instruments[i]['cps'][vc]['technique'] in instrumentInvalidTechniques[i]:
					continue

				###################################
				## MINSPEED temporal restriction ##
				###################################
				if instrumentNearestEventInFrames[i] != None and instrumentNearestEventInFrames[i] < self.instruments[i]['cps'][vc]['minspeed_frames']:
					continue
					
				self.valid_instruments_per_voice[vc].append(i)


	########################################
	def setup_corpus_tests(self, tidx):
		if not self.active: return True
		'''creates a list of boolean tests for corpus segment pitch and dB that must be passed for a sample to be considered for selection'''
		self.instrument_tests = {}
		# loop through all instruments
		for i in self.instruments:	
			# loop through each voice available to each instrument
			for v in self.instruments[i]['cps']:
				# set up the test dict
				self.instrument_tests[i, v] = {'pitch': [], 'pitch2': [], 'db2': []}
				if tidx in self.instruments[i]['cps'][v]['selected_pitches']:
					# make tests
					minp, maxp = min(self.instruments[i]['cps'][v]['selected_pitches'][tidx]), max(self.instruments[i]['cps'][v]['selected_pitches'][tidx])
					# max range
					if self.instruments[i]['cps'][v]['polyphony_max_range'] != None:
						extra_room_in_range = self.instruments[i]['cps'][v]['polyphony_max_range']-(maxp-minp)
						self.instrument_tests[i, v]['pitch2'].append('%%f >= %f and %%f <= %f'%(minp-extra_room_in_range, maxp+extra_room_in_range))
					# min range
					if self.instruments[i]['cps'][v]['polyphony_min_range'] != None:
						extra_room_in_minrange = self.instruments[i]['cps'][v]['polyphony_min_range']-(maxp-minp)
						self.instrument_tests[i, v]['pitch2'].append('%%f <= %f or %%f >= %f'%(minp-extra_room_in_minrange, maxp+extra_room_in_minrange))
					# unison tests
					if not self.instruments[i]['cps'][v]['polyphony_permit_unison']:
						for p in self.instruments[i]['cps'][v]['selected_pitches'][tidx]:
							self.instrument_tests[i, v]['pitch'].append('%%f != %f'%(p))
				
				if tidx in self.instruments[i]['cps'][v]['selected_dbs']:
					# make tests
					# max db
					mindb, maxdb = min(self.instruments[i]['cps'][v]['selected_dbs'][tidx]), max(self.instruments[i]['cps'][v]['selected_dbs'][tidx])
					if self.instruments[i]['cps'][v]['polyphony_max_db_difference'] != None:
						extra_room_in_minrange = self.instruments[i]['cps'][v]['polyphony_max_db_difference']-(maxdb-mindb)
						self.instrument_tests[i, v]['db2'].append('%%f >= %f and %%f <= %f'%(mindb-extra_room_in_minrange, maxdb+extra_room_in_minrange))
			# INSTRUMENT-LEVEL RESTRICTIONS
			# do shit for pitch restriction in time
			globalOrLocalScope = 'global'
			# the line below needs to be redone as a global variable for this instr!!!!!!!
			# the line below needs to be redone as a global variable for this instr!!!!!!!
			# the line below needs to be redone as a global variable for this instr!!!!!!!
			# the line below needs to be redone as a global variable for this instr!!!!!!!
			# the line below needs to be redone as a global variable for this instr!!!!!!!
			if self.instruments[i]['cps'][v]['pitch_limit_change_per_sec'] != None:
				semitoneMovePerFrame = self.instruments[i]['cps'][v]['pitch_limit_change_per_sec']/self._s2f(1)
				prevNotes = [(tidx-ttidx, pitchlist) for ttidx, pitchlist in self.instruments[i]['selected_pitches'].items() if ttidx < tidx]
				futureNotes = [(ttidx-tidx, pitchlist) for ttidx, pitchlist in self.instruments[i]['selected_pitches'].items() if ttidx > tidx]
				for notes in [prevNotes, futureNotes]:
					if len(notes) > 0:
						notes.sort()
						closestFrame, closestPitches = notes[0]
						minp, maxp = min(closestPitches), max(closestPitches)
						semidev = closestFrame*semitoneMovePerFrame
						for v in self.instruments[i]['cps']:
							self.instrument_tests[i, v]['pitch2'].append('%%f >= %f and %%f <= %f'%(minp-semidev, maxp+semidev))

	########################################
	def test_corpus_segment(self, tidx, cobj):
		'''this test happens on the corpus at a segment-by-segment basis'''
		if not self.active: return True
		if len(self.valid_instruments_per_voice[cobj.voiceID]) == 0: return False
		cobj.instrument_candidates = []

		PITCH = cobj.desc['MIDIPitch-seg'].get(None, None)
		if cobj.transMethod != None and cobj.transMethod.startswith("semitone"):
			# exception for midipitch to incorporate transposition
			PITCH += float(cobj.transMethod.split()[1])
		DB = util.ampToDb(cobj.desc['power-seg'].get(None, None)) + cobj.envDb
		
		for i in self.valid_instruments_per_voice[cobj.voiceID]:
			add_this_instr = True
			################################################
			## test for descriptor-based polophony limits ##
			################################################
			tests = []
			# single pitch conditionals
			tests.extend([teststring%(PITCH) for teststring in self.instrument_tests[i, cobj.voiceID]['pitch']])
			# double pitch conditionals
			tests.extend([teststring%(PITCH, PITCH) for teststring in self.instrument_tests[i, cobj.voiceID]['pitch2']])
			# double dB conditionals			
			tests.extend([teststring%(DB, DB) for teststring in self.instrument_tests[i, cobj.voiceID]['db2']])
			for t in tests:
				if not eval(t):
					add_this_instr = False
					break





			if add_this_instr: cobj.instrument_candidates.append(i)
		if len(cobj.instrument_candidates) == 0: return False
		else: return True
	########################################
	def increment(self, start, dur, oeObj):
		if not self.active: return
		
		if oeObj.sfseghandle.instrTag not in self.instrument_names:
			oeObj.selectedinstrument = None
			self.internaldata['non_instrument_events'] += 1
			return
		# if we're passing this point, we're picking the instrument
		vc = oeObj.sfseghandle.voiceID
		oeObj.selectedinstrument = oeObj.sfseghandle.instrument_candidates[0]
		thisinstr = self.instruments[oeObj.selectedinstrument]
		
		incrdur = min(dur, oeObj.sfseghandle.lengthInFrames)
		# add event
		event = {}
		event['technique'] = thisinstr['cps'][vc]['technique']
		if thisinstr['cps'][vc]['temporal_mode'] in ['artic']: event['time_tuple'] = np.array([start, start+1]) # duration-less
		else: event['time_tuple'] = np.array([start, start+incrdur]) # duration
		#self.events.append(event)

		# increment shit
		thisinstr['all_selected_times_in_frames'].append(start)
		thisinstr['cps'][vc]['selected_times_in_frames'].append(start)
		thisinstr['cps'][vc]['overlap_frames'][start:start+dur] += 1

		if thisinstr['cps'][vc]['technique'] in thisinstr['overlap_frames_by_technique']:
			thisinstr['overlap_frames_by_technique'][thisinstr['cps'][vc]['technique']][event['time_tuple'][0]:event['time_tuple'][1]] += 1

		# pitch selection for the whole instrument
		if start not in thisinstr['selected_pitches']: thisinstr['selected_pitches'][start] = []
		thisinstr['selected_pitches'][start].append(oeObj.midi)
		if start not in thisinstr['cps'][vc]['selected_pitches']: thisinstr['cps'][vc]['selected_pitches'][start] = []
		thisinstr['cps'][vc]['selected_pitches'][start].append(oeObj.midi)
		if start not in thisinstr['cps'][vc]['selected_dbs']: thisinstr['cps'][vc]['selected_dbs'][start] = []
		thisinstr['cps'][vc]['selected_dbs'][start].append(oeObj.rmsSeg+oeObj.envDb)

		self.internaldata['notes'] += 1
	########################################
	def write(self, outputEvents):
		if not self.active: return
		
		meter_nom, meter_denom = self.scoreparams['meter'].split('/')
		beats_per_bar = float(meter_nom)
		bar_duration = beats_per_bar*(self.scoreparams['tempo']/60.)	

		dictByInstrument = {}
		slopMapping = {
		'dynamics': 20,
		'articulation': 22,
		'notehead': 23,
		'annotation': 24,
		}
		
		for eobj in outputEvents:
			if eobj.selectedinstrument == None: continue
			if eobj.selectedinstrument not in dictByInstrument: dictByInstrument[eobj.selectedinstrument] = {}
			thiscps = self.instruments[eobj.selectedinstrument]['cps'][eobj.voiceID]

			timeinMs = int(eobj.timeInScore*1000)
			durationInMs = int(eobj.tgtsegdur*1000) # cps duration may be modified by clipDurationToTarget; duration is the sf duration.
			if thiscps['pitchoverride'] == None:
				pitchInCents = int((eobj.midi)*100) # eobj.midi incorperates transposition
			else:
				pitchInCents = int((thiscps['pitchoverride'])*100)
			amp127 = 100
			# do slots stuff
			slotData = {}
			# slots text
			if thiscps['annotation'] != None:
				if thiscps['annotation'] == 'filename':
					slotData[slopMapping['annotation']] = os.path.split(eobj.filename)[1]
				else:
					slotData[slopMapping['annotation']] = "%s"%thiscps['annotation']
			if thiscps['articulation'] != None:
				slotData[slopMapping['articulation']] = "%s"%thiscps['articulation']
			if eobj.dynamicFromFilename != None:
				slotData[slopMapping['dynamics']] = eobj.dynamicFromFilename
			if thiscps['notehead'] != None:
				slotData[slopMapping['notehead']] = "%s"%thiscps['notehead']

			# test if duration should be written
			if thiscps['temporal_mode'] in ['artic']:
				#durationInMs = 0 NOPE, zero duration not possible in bach when quantizing.
				pass
			if timeinMs not in self.instruments[eobj.selectedinstrument]['notes']:
				self.instruments[eobj.selectedinstrument]['notes'][timeinMs] = [[], slotData]
			self.instruments[eobj.selectedinstrument]['notes'][timeinMs][0].append([pitchInCents, durationInMs, amp127])
		
		bachstring = 'roll '
		# set up clefs
		clefs = ['clefs'] + [self.instruments[i]['params'].params['clef'] for i in self.instruments]
		bachstring += "[%s] "%' '.join(clefs)
		# set up voices
		voicenames = ['voicenames'] + [self.instruments[i]['displayname'] for i in self.instruments]
		bachstring += "[%s] "%' '.join(voicenames)
		
		for instru in self.instruments:
			bachstring += '[ ' # instrument start
			for time, (notelist, slotDict) in self.instruments[instru]['notes'].items():
				bachstring += '[%i.'%time # note start
				for didx, d in enumerate(notelist):
					# only write slots for first note
					if didx == 0:
						slotstring = '[slots %s ]'%' '.join(['[%i %s]'%(slotnumb, slotdata) for slotnumb, slotdata in slotDict.items()])
					else: #already wrote slots on a prev not in this chord
						slotstring = '0'						
					bachstring += ' [%i %i %i %s] '%(d[0], d[1], d[2], slotstring)
				bachstring += '] ' # note end
			bachstring += '] ' # instrument end
			
		fh = open(self.outputfile, 'w')
		fh.write(bachstring)
		fh.close()
	########################################




