import os
import numpy as np
import audioguide.util as util


#########################
## things to implement ##
#########################
#  * temporal_limit_by_descriptor_per_second = {'MIDIPitch': 4} # can only change by 4 semintones per sec
#  * second staff with "other" choices that didn't make it in?
#  * enforced minimum of sounds per instrument per segment?
#  * need a way for non-instrument sounds to work with contactenation! at the moment they are not used
#  * reverse technique_switch_delay_map

################################################################################
class instruments:
	def __init__(self, scoreFromUserOptions, usercorpus, outputfile, tgtlength, hopsizesec, p):
		self.active = scoreFromUserOptions != None and len(scoreFromUserOptions.instrumentobjs) != 0
		if not self.active: return

		#
		self.outputfile = outputfile
		self.tgtlength = tgtlength
		self.internaldata = {'notes': 0, 'non_instrument_events': 0, 'selections_per_voice': {}}
		#self.events = []
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
			self.instruments[k]['cpstag'] = ins.name
			self.instruments[k]['all_selected_times_in_frames'] = []
			self.instruments[k]['time_in_frames_to_pitch_minmax'] = {}
			# this variable holds all valid voices for this instrument
			self.instruments[k]['cps'] = {}
			for c in usercorpus:
				if not c.instrTag == ins.name: continue
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
		self.instrument_tests = {}
		# loop through all instruments
		for i in self.instruments:	
			# loop through each voice available to each instrument
			for v in self.instruments[i]['cps']:
				# set up the test dict
				self.instrument_tests[i, v] = {'pitch': [], 'db': []}
				# if nothing selected for this frame, don't worry about it
				if tidx in self.instruments[i]['cps'][v]['selected_pitches']:
					# make tests
					minp, maxp = min(self.instruments[i]['cps'][v]['selected_pitches'][tidx]), max(self.instruments[i]['cps'][v]['selected_pitches'][tidx])
					# max range
					if self.instruments[i]['cps'][v]['polyphony_max_range'] != None:
						extra_room_in_range = self.instruments[i]['cps'][v]['polyphony_max_range']-(maxp-minp)
						self.instrument_tests[i, v]['pitch'].append('%%f >= %f and %%f <= %f'%(minp-extra_room_in_range, maxp+extra_room_in_range))
					# min range
					if self.instruments[i]['cps'][v]['polyphony_min_range'] != None:
						extra_room_in_minrange = self.instruments[i]['cps'][v]['polyphony_min_range']-(maxp-minp)
						self.instrument_tests[i, v]['pitch'].append('%%f <= %f or %%f >= %f'%(minp-extra_room_in_minrange, maxp+extra_room_in_minrange))
				if tidx in self.instruments[i]['cps'][v]['selected_dbs']:
					# make tests
					# max db
					mindb, maxdb = min(self.instruments[i]['cps'][v]['selected_dbs'][tidx]), max(self.instruments[i]['cps'][v]['selected_dbs'][tidx])
					if self.instruments[i]['cps'][v]['polyphony_max_db_difference'] != None:
						extra_room_in_minrange = self.instruments[i]['cps'][v]['polyphony_max_db_difference']-(maxdb-mindb)
						self.instrument_tests[i, v]['db'].append('%%f >= %f and %%f <= %f'%(mindb-extra_room_in_minrange, maxdb+extra_room_in_minrange))
				# interval tests
#				if tidx in self.instruments[i]['cps'][v]['selected_pitches']:
#					for teststring in self.instruments[i]['cps'][v]['polyphony_interval_tests']:
#						
#						print([[teststring, p] for p in self.instruments[i]['cps'][v]['selected_pitches'][tidx]])
#						sys.exit()

				
	########################################
	def test_corpus_segment(self, tidx, cobj):
		'''this test happens at the corpus segment level'''
		if not self.active: return True
		if len(self.valid_instruments_per_voice[cobj.voiceID]) == 0: return False
		cobj.instrument_candidates = []


		for i in self.valid_instruments_per_voice[cobj.voiceID]:
			add_this_instr = True
			################################################
			## test for descriptor-based polophony limits ##
			################################################
			tests = []
			testpitch = cobj.desc['MIDIPitch-seg'].get(None, None)
			if len(self.instrument_tests[i, cobj.voiceID]['pitch']) > 0:
				# exception for midipitch to incorporate transposition
				if cobj.transMethod != None and cobj.transMethod.startswith("semitone"):
					testpitch += float(cobj.transMethod.split()[1])
				tests.extend([teststring%(testpitch, testpitch) for teststring in self.instrument_tests[i, cobj.voiceID]['pitch']])
							
			if len(self.instrument_tests[i, cobj.voiceID]['db']) > 0:
				testdb = util.ampToDb(cobj.desc['power-seg'].get(None, None)) + cobj.envDb
				
				# exception for midipitch to incorporate transposition
				tests.extend([teststring%(testdb, testdb) for teststring in self.instrument_tests[i, cobj.voiceID]['db']])

			if len(tests) > 0:
				add_this_instr = all([eval(t) for t in tests])

			#if self.instruments[i]['cps'][cobj.voiceID]['polyphony_permit_unison']




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

		# add min/max pitch info
		if start not in thisinstr['time_in_frames_to_pitch_minmax']:
			thisinstr['time_in_frames_to_pitch_minmax'][start] = [oeObj.midi, oeObj.midi]
		else:
			thisinstr['time_in_frames_to_pitch_minmax'][start][0] = min(thisinstr['time_in_frames_to_pitch_minmax'][start][0], oeObj.midi)
			thisinstr['time_in_frames_to_pitch_minmax'][start][1] = max(thisinstr['time_in_frames_to_pitch_minmax'][start][1], oeObj.midi)
		
		
		if thisinstr['cps'][vc]['technique'] in thisinstr['overlap_frames_by_technique']:
			thisinstr['overlap_frames_by_technique'][thisinstr['cps'][vc]['technique']][event['time_tuple'][0]:event['time_tuple'][1]] += 1
		
		if start not in thisinstr['cps'][vc]['selected_pitches']: thisinstr['cps'][vc]['selected_pitches'][start] = []
		thisinstr['cps'][vc]['selected_pitches'][start].append(oeObj.midi)
		if start not in thisinstr['cps'][vc]['selected_dbs']: thisinstr['cps'][vc]['selected_dbs'][start] = []
		thisinstr['cps'][vc]['selected_dbs'][start].append(oeObj.rmsSeg+oeObj.envDb)
		# add values for polyphony limit by descriptor
		#if start not in self.internaldata['selections_per_voice'][vc]:
		#	self.internaldata['selections_per_voice'][vc][start] = {d:[] for d in thisinstr['cps'][vc]['polyphony_limit_range']}
		#for d, lims in thisinstr['cps'][vc]['polyphony_limit_range'].items():
		#	dvalue = oeObj.sfseghandle.desc[d+'-seg'].get(None, None)
			# special exception if we are handling pitch, as the measurement needs to incorperate any transposition
		#	if d == 'MIDIPitch': dvalue += oeObj.transposition
		#	self.internaldata['selections_per_voice'][vc][start][d].append(dvalue) 

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
				durationInMs = 0
			if timeinMs not in self.instruments[eobj.selectedinstrument]['notes']:
				self.instruments[eobj.selectedinstrument]['notes'][timeinMs] = [[], slotData]
			self.instruments[eobj.selectedinstrument]['notes'][timeinMs][0].append([pitchInCents, durationInMs, amp127])
		
		bachstring = 'roll '
		# set up clefs
		clefs = ['clefs'] + [self.instruments[i]['params'].params['clef'] for i in self.instruments]
		bachstring += "[%s] "%' '.join(clefs)
		# set up voices
		voicenames = ['voicenames'] + [self.instruments[i]['cpstag'] for i in self.instruments]
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




