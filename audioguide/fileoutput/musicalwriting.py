import os, sys
import numpy as np
import audioguide.util as util









class sequenceTracker:
	def __init__(self, paramdict, sequencesCanRotate=False, splitchar=' '):
		self.sequencesCanRotate = sequencesCanRotate
		self.splitchar = splitchar
		self.all_token_lists = paramdict['sequences']
		####
		self.tracker = []
		self.all_tokens = []
		self.starting_tokens = []
		self.middle_tokens = []
		self.ending_tokens = []
		self.non_starting_tokens = []
		for sl in self.all_token_lists:
			self.all_tokens.extend(sl)
			self.starting_tokens.append(sl[0])
			self.middle_tokens.extend(sl[1:-1])
			self.ending_tokens.append(sl[-1])
			self.non_starting_tokens.extend(sl[1:])
	####################		
	def register(self, sidx, filename):
		token = os.path.split(filename)[1].split(self.splitchar)[1]
		self.tracker.append(token)
	####################		
	def query(self, sidx):
		'''return a list of tests that all tokens must pass'''
		# not in a pattern or just ended a pattern
		if len(self.tracker) == 0 or self.tracker[-1] not in self.all_tokens or self.tracker[-1] in self.ending_tokens: 
			# if rotations are possible, anything is pickable here
			if self.sequencesCanRotate: return []
			# otherwise we can only pick for first element of any sequence
			return ["'%%s' not in %s"%str(self.non_starting_tokens)]
		# otherwise if we are in a pattern
		else:
			currentidx = self.all_tokens.index(self.tracker[-1])
			return ["'%%s' == '%s'"%str(self.all_tokens[currentidx+1])]







#########################
## things to implement ##
#########################
#  * enforced minimum of sounds per instrument per segment?
#  * change signal decomp to support MW - modolus of target segment times before concate?




class notetracker:
	'''tracks info about notes that have been picked. provides data for testing the viability of future selections.'''
	instrument_num_notes = 0
	noninstrument_num_notes = 0
	instrdata = {}
	########################################
	def __init__(self, hopsize, tgtsegs):
		self.hopsize = hopsize
		self.tgtsegs = tgtsegs
	########################################
	def addinstrument(self, instr, tgtlength, instrparams, cpsids, cpsparams):
		#self.instrToIdx[instr] = len(self.instrdata)
		self.instrdata[instr] = {'instr': {}, 'tech': {}, 'cps': {}, 'cpsids': cpsids}
		# set up instrument trackers
		self.instrdata[instr]['selected_notes'] = {}
		self.instrdata[instr]['overlaps'] = np.zeros(tgtlength, dtype=int)
		# test for sequence stuff
		if 'sequences' in instrparams:
			self.instrdata[instr]['sequencetrack'] = sequenceTracker(instrparams['sequences'])
		# set up technique trackers
		for d in cpsparams:
			if 'technique' not in d or d['technique'] in self.instrdata[instr]['tech']: continue
			self.instrdata[instr]['tech'][d['technique']] = np.zeros(tgtlength, dtype=int)	
		# set up cps voice trackers
		for vc in cpsids:
			self.instrdata[instr]['cps'][vc] = np.zeros(tgtlength, dtype=int)
	########################################
	def addnote(self, instr, cpsid, time, duration, midi, db, technique, tgtsegidx, eobj):
		if time not in self.instrdata[instr]['selected_notes']: self.instrdata[instr]['selected_notes'][time] = []
		self.instrdata[instr]['selected_notes'][time].append([duration, midi, db, cpsid])
		self.instrdata[instr]['overlaps'][time:time+duration] += 1
		self.instrdata[instr]['cps'][cpsid][time:time+duration] += 1
		if 'sequencetrack' in self.instrdata[instr]:
			self.instrdata[instr]['sequencetrack'].register(tgtsegidx, eobj.filename)
		if technique != None:
			self.instrdata[instr]['tech'][technique][time:time+duration] += 1
		self.instrument_num_notes += 1		
	########################################
	def _neighbor_notetimes(self, instr, time, cpsscope=None):
		'''returns None or notetime for previous and next notes'''
		prev = None
		next = None
		for notetime in self.instrdata[instr]['selected_notes'].keys():
			if cpsscope != None and self.instrdata[instr]['selected_notes'][notetime][0][3] not in cpsscope: continue
			if notetime < time and (prev == None or notetime > prev): prev = notetime
			elif notetime > time and (next == None or notetime < next): next = notetime
		return prev, next
	######################################
	## publically callable test methods ##
	######################################
	def test_overlap_threshold(self, instr, time, insobj):
		tests = [self.instrdata[instr]['cps'][vc][time] >= insobj[instr]['cps'][vc]['polyphony_max_voices'] for vc in self.instrdata[instr]['cps']]
		return True in tests
	########################################
	def test_other_voice_is_active(self, instrumentsobj, instr, time, exclude_vc):
		othervoices = [vcid for vcid in self.instrdata[instr]['cps'] if self.instrdata[instr]['cps'][vcid][time] > 0  and vcid != exclude_vc and not instrumentsobj[instr]['cps'][vcid]['canPlayWhileDoingSomethingElse']]
		return len(othervoices) > 0
	########################################
	def test_minspeed(self, instr, time, vc, instrumentsobj, cpsscope=None):
		prev, next = self._neighbor_notetimes(instr, time, cpsscope=cpsscope)
		# test this time for polyphony
		if time in self.instrdata[instr]['selected_notes']:
			minspeed_in_frames = instrumentsobj.instruments[instr]['cps'][vc]['polyphony_minspeed_frames']
		else:
			minspeed_in_frames = instrumentsobj.instruments[instr]['cps'][vc]['minspeed_frames']
		return (prev == None or time-prev >= minspeed_in_frames) and (next == None or next-time >= minspeed_in_frames)
	########################################
	def get_invalid_techniques(self, instrumentsobj, time):
		instrumentInvalidTechniques = {}
		for i in instrumentsobj.instruments:
			# test to see what techniques are invalid according to "technique_time_constraints"
			instrumentInvalidTechniques[i] = []
			for (testtech, direction, constrainingtech), frameseek in instrumentsobj.instruments[i]['technique_time_constraints'].items():
				if frameseek < 0: testf = (max(0, time+frameseek), time)
				else: testf = (time, time+frameseek)
				if constrainingtech not in self.instrdata[i]['tech']:
					print("ERROR, %s doesn't have a technique called %s"%(i, constrainingtech))
					sys.exit()
				if np.max(self.instrdata[i]['tech'][constrainingtech][testf[0]:testf[1]]) > 0:
					instrumentInvalidTechniques[i].append(testtech)
		return instrumentInvalidTechniques
	########################################
	def get_chord_minmax(self, instr, time, vc):
		if time not in self.instrdata[instr]['selected_notes']: return None
		pitches = [p for d, p, db, vcidx in self.instrdata[instr]['selected_notes'][time] if vcidx == vc]
		dbs = [db for d, p, db, vcidx in self.instrdata[instr]['selected_notes'][time] if vcidx == vc]
		if len(pitches) == 0: return None
		d = {'pitches': pitches, 'pitchmin': min(pitches), 'pitchmax': max(pitches), 'dbmin': min(dbs), 'dbmax': max(dbs)}
		d['pitchrange'] = d['pitchmax']-d['pitchmin']
		d['dbrange'] = d['dbmax']-d['dbmin']
		return d
	########################################
	def get_interval_restrictions(self, instrumentsobj, instr, vc, time):
		tests = []
		results = []
		if len(instrumentsobj[instr]['cps'][vc]['interval_limit_breakpoints_frames']) > 0:
			prev, next = self._neighbor_notetimes(instr, time)	
			last_breakpoint_frames = instrumentsobj[instr]['cps'][vc]['interval_limit_breakpoints_frames'][-1][0] # since this list was sorted
			if prev != None:
				# ensure that prev is the last note's END time
				t = max(0, time - prev + max([n[0] for n in self.instrdata[instr]['selected_notes'][prev]]) )
				minp = min([n[1] for n in self.instrdata[instr]['selected_notes'][prev]])
				maxp = max([n[1] for n in self.instrdata[instr]['selected_notes'][prev]])
				tests.append([t, minp, maxp])
			if next != None:
				minp = min([n[1] for n in self.instrdata[instr]['selected_notes'][next]])
				maxp = max([n[1] for n in self.instrdata[instr]['selected_notes'][next]])
				tests.append([next-time, minp, maxp])
			for tdiff, minp, maxp in tests:
				if tdiff > last_breakpoint_frames:
					# skip it since this time difference is greater than the last breakpoint time -- any interval is possible
					continue
				for idx, (time, int) in enumerate(instrumentsobj[instr]['cps'][vc]['interval_limit_breakpoints_frames'][:-1]):
					nextrestriction = instrumentsobj[instr]['cps'][vc]['interval_limit_breakpoints_frames'][idx+1]
					if tdiff >= time and tdiff < nextrestriction[0]: break
				timeinterpolate = (tdiff-time)/(nextrestriction[0]-time)
				intervalextrapolate = (timeinterpolate*(nextrestriction[1]-int))+int
				results.append([maxp-intervalextrapolate, minp+intervalextrapolate])
		
		# interval_limit_range_per_sec
		if instrumentsobj[instr]['cps'][vc]['interval_limit_range_per_sec'] != None and len(self.instrdata[instr]['selected_notes']) > 0:
			prevnote, nextnote = self._neighbor_notetimes(instr, time)
			min_max_possibilities = [[], []]
			if prevnote != None:
				d = self.get_chord_minmax(instr, prevnote, vc)
				seconddiff = (time-prevnote)*self.hopsize
				pitchdiff = seconddiff * instrumentsobj[instr]['cps'][vc]['interval_limit_range_per_sec']
				min_max_possibilities[0].append(d['pitchmin']-pitchdiff)
				min_max_possibilities[1].append(d['pitchmin']+pitchdiff)
			if nextnote != None:
				d = self.get_chord_minmax(instr, nextnote, vc)
				seconddiff = (nextnote-time)*self.hopsize
				pitchdiff = seconddiff * instrumentsobj[instr]['cps'][vc]['interval_limit_range_per_sec']
				min_max_possibilities[0].append(d['pitchmin']-pitchdiff)
				min_max_possibilities[1].append(d['pitchmin']+pitchdiff)

			results.append([max(min_max_possibilities[0]), min(min_max_possibilities[1])])
			#sys.exit()
			
	#	if instrumentsobj[instr]['cps'][vc]['interval_limit_range_per_sec'] != None:
#			min_max_within_a_second = [[], []]
#			timerange = (0.5/self.hopsize)
#			for notetime in self.instrdata[instr]['selected_notes'].keys():
#				#if cpsscope != None and self.instrdata[instr]['selected_notes'][notetime][0][3] not in cpsscope: continue
#				if notetime >= time-timerange and notetime <= time+timerange:
#					d = self.get_chord_minmax(instr, notetime, vc)
#					min_max_within_a_second[0].append(d['pitchmin'])
#					min_max_within_a_second[1].append(d['pitchmax'])
#			if len(min_max_within_a_second[0]) > 0:
#				minp = min(min_max_within_a_second[0])
#				maxp = max(min_max_within_a_second[1])
#				extra_room = instrumentsobj[instr]['cps'][vc]['interval_limit_range_per_sec']-(maxp-minp)
#				results.append([minp-extra_room, maxp+extra_room])
#		print("\n\n", instr, vc, time, results, self.instrdata[instr]['selected_notes'], "\n\n")
		return results		






################################################################################
class instruments:
	def __init__(self, scoreFromUserOptions, usercorpus, tgtsegs, tgtlength, cpsseglist, hopsizesec, p):
		self.active = scoreFromUserOptions != None and len(scoreFromUserOptions.instrumentobjs) != 0
		if not self.active: return
		#
		# test configuration
		#    make sure that instruments listed have a corresponding tag in the corpus; otherwise die
		allCorpusInstrTags = []
		for c in usercorpus:
			if type(c.instrTag) == type(""): allCorpusInstrTags.append(c.instrTag)
			else: allCorpusInstrTags.extend(c.instrTag)
		unusedInstruments = []
		for si in scoreFromUserOptions.instrumentobjs:
			if si.name not in allCorpusInstrTags:
				unusedInstruments.append(si.name)
		if len(unusedInstruments) > 0:
			util.error("INSTRUMENT", "Several instruments defined in score() are not tagged to any of your csfs(). These include %s. To link instruments to csf() resources, set the csf keyword 'instrTag' to the name of the desired instrument."%', '.join(unusedInstruments), exitcode=1)
		#
		self.setup_internalshit(scoreFromUserOptions, usercorpus, tgtsegs, tgtlength, cpsseglist, hopsizesec, p)
	########################################
	def setup_internalshit(self, scoreFromUserOptions, usercorpus, tgtsegs, tgtlength, cpsseglist, hopsizesec, p):
		self.tgtlength = tgtlength
		self.tracker = notetracker(hopsizesec, tgtsegs)
		self.hopsizesec = hopsizesec
		self.instruments = {}
		self.instrument_names = []
		self.instrumentNameToIdx = {}
		for iidx, ins in enumerate(scoreFromUserOptions.instrumentobjs):
			if ins.name not in self.instrument_names: self.instrument_names.append(ins.name)
			k = '%i-%s'%(iidx, ins.name)
			self.instrumentNameToIdx[k] = iidx
			self.instruments[k] = {}
			self.instruments[k]['notes'] = {}
			self.instruments[k]['params'] = ins
			self.instruments[k]['displayname'] = ins.name
			self.instruments[k]['cpsTags'] = ins.params['cpsTags']
			self.instruments[k]['selected_pitches'] = {}
			# this variable holds all valid voices for this instrument
			self.instruments[k]['cps'] = {}
			cpsids = [c.voiceID for c in usercorpus if c.instrTag in self.instruments[k]['cpsTags']]
			cpsparams = [c.instrParams for c in usercorpus if c.instrTag in self.instruments[k]['cpsTags']]
			self.tracker.addinstrument(k, tgtlength, ins.params, cpsids, cpsparams)
			for c in usercorpus:
				if not c.instrTag in self.instruments[k]['cpsTags']: continue
				self.instruments[k]['cps'][c.voiceID] = ins.params.copy()
				# update with instrument params if not user-supplied at corpus level
				# add values if not supplied
				voiceparam_defaults = {'technique': None, 'notehead': None, 'annotation': None, 'articulation': None, 'canPlayWhileDoingSomethingElse': False}
				voiceparam_defaults.update(c.instrParams)
				self.instruments[k]['cps'][c.voiceID].update(voiceparam_defaults)
				# other internal shit
				self.instruments[k]['cps'][c.voiceID]['interval_limit_breakpoints_frames'] = []
				for time, value in self.instruments[k]['cps'][c.voiceID]['interval_limit_breakpoints']:
					self.instruments[k]['cps'][c.voiceID]['interval_limit_breakpoints_frames'].append((self._s2f(time), value))
				self.instruments[k]['cps'][c.voiceID]['interval_limit_breakpoints_frames'].sort()
				if self.instruments[k]['cps'][c.voiceID]['polyphony_minspeed'] == None:
					self.instruments[k]['cps'][c.voiceID]['polyphony_minspeed'] = self.instruments[k]['cps'][c.voiceID]['minspeed']
			# temporal restrictions in hop-sized frames
			for voiceID in self.instruments[k]['cps']:
				self.instruments[k]['cps'][voiceID]['minspeed_frames'] = self._s2f(self.instruments[k]['cps'][voiceID]['minspeed'])
				self.instruments[k]['cps'][voiceID]['polyphony_minspeed_frames'] = self._s2f(self.instruments[k]['cps'][voiceID]['polyphony_minspeed'])
			self.instruments[k]['technique_time_constraints'] = {}
			for idx, (constrainingtech, querytech, timesec) in enumerate(ins.params['technique_switch_delay_map']):
				self.instruments[k]['technique_time_constraints'][(querytech, '<-', constrainingtech)] = -self._s2f(timesec)
				# add cross associations
				self.instruments[k]['technique_time_constraints'][(constrainingtech, '->', querytech)] = self._s2f(timesec)
			# do dynamics
			# make pitch/dynamics matrix
			for voiceID in self.instruments[k]['cps']:
				thiscps = [c for c in cpsseglist if c.voiceID == voiceID]
				# do equally spaced dynamics
				thiscps_powersort = sorted(thiscps, key=lambda x: x.desc.get('power-seg'))
				self.instruments[k]['cps'][voiceID]['cobj_to_dyn'] = {}
				if len(self.instruments[k]['cps'][voiceID]['dynamics']) == 1 or len(thiscps_powersort) <= 1:
					self.instruments[k]['cps'][voiceID]['cobj_to_dyn'] = {c: self.instruments[k]['cps'][voiceID]['dynamics'][0] for c in thiscps}
				else:
					for idx, c in enumerate(thiscps_powersort):
						dynidx = int((idx/float(len(thiscps_powersort)-1))*(len(self.instruments[k]['cps'][voiceID]['dynamics'])-0.01))
						self.instruments[k]['cps'][voiceID]['cobj_to_dyn'][c] = self.instruments[k]['cps'][voiceID]['dynamics'][dynidx]
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
	def evaluate_voices(self, targettimeinframes, validVoicesList):
		if not self.active: return		
		instrumentInvalidTechniques = self.tracker.get_invalid_techniques(self, targettimeinframes)
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
				if self.tracker.test_other_voice_is_active(self.instruments, i, targettimeinframes, vc):
					continue
				###########################################################################
				## see if overlaps are at a max for any other techniques for this instru ##
				###########################################################################
				if self.tracker.test_overlap_threshold(i, targettimeinframes, self.instruments): 	
					continue
				#####################################
				## TECHNIQUE temporal restrictions ##
				#####################################
				if self.instruments[i]['cps'][vc]['technique'] in instrumentInvalidTechniques[i]:
					continue
				###################################
				## MINSPEED temporal restriction ##
				###################################
				if not self.tracker.test_minspeed(i, targettimeinframes, vc, self):
					continue
				# otherwise add it
				self.valid_instruments_per_voice[vc].append(i)
	########################################
	def setup_corpus_tests(self, tidx, tsegidx):
		if not self.active: return True
		'''creates a list of boolean tests for corpus segment pitch and dB that must be passed for a sample to be considered for selection'''
		self.instrument_tests = {}
		# loop through all instruments
		for i in self.instruments:	
			# loop through each voice available to each instrument
			for v in self.instruments[i]['cps']:
				self.instrument_tests[i, v] = {'pitch': [], 'pitch2': [], 'db2': [], 'seqdata': []}

				# sequence testing
				if 'sequencetrack' in self.tracker.instrdata[i]:
					self.instrument_tests[i, v]['seqdata'].extend(self.tracker.instrdata[i]['sequencetrack'].query(tsegidx))


				# set up the test dict
				minmaxdict = self.tracker.get_chord_minmax(i, tidx, v)
				if minmaxdict == None: 
					# no other notes found here
					continue
				# max range
				if self.instruments[i]['cps'][v]['polyphony_max_range'] != None:
					extra_room_in_range = self.instruments[i]['cps'][v]['polyphony_max_range']-minmaxdict['pitchrange']
					self.instrument_tests[i, v]['pitch2'].append('%%f >= %f and %%f <= %f'%(minmaxdict['pitchmin']-extra_room_in_range, minmaxdict['pitchmax']+extra_room_in_range))
				# min range
				if self.instruments[i]['cps'][v]['polyphony_min_range'] != None:
					extra_room_in_minrange = self.instruments[i]['cps'][v]['polyphony_min_range']-minmaxdict['pitchrange']
					self.instrument_tests[i, v]['pitch2'].append('%%f <= %f or %%f >= %f'%(minmaxdict['pitchmin']-extra_room_in_minrange, minmaxdict['pitchmax']+extra_room_in_minrange))
				# unison tests
				if not self.instruments[i]['cps'][v]['polyphony_permit_unison']:
					for p in minmaxdict['pitches']:
						self.instrument_tests[i, v]['pitch'].append('%%f != %f'%(p))
				# max db
				if self.instruments[i]['cps'][v]['polyphony_max_db_difference'] != None:
					extra_room_in_minrange = self.instruments[i]['cps'][v]['polyphony_max_db_difference']-minmaxdict['dbrange']
					self.instrument_tests[i, v]['db2'].append('%%f >= %f and %%f <= %f'%(minmaxdict['dbmin']-extra_room_in_minrange, minmaxdict['dbmax']+extra_room_in_minrange))
				

			# interval restriction in time
			for minp, maxp in self.tracker.get_interval_restrictions(self.instruments, i, v, tidx):
				for v in self.instruments[i]['cps']:
					if self.instruments[i]['cps'][v]['pitched']:
						self.instrument_tests[i, v]['pitch2'].append('%%f >= %f and %%f <= %f'%(minp, maxp))
	########################################
	def test_corpus_segment(self, tidx, cobj):
		'''this test happens on the corpus at a segment-by-segment basis'''
		if not self.active: return True
		if len(self.valid_instruments_per_voice[cobj.voiceID]) == 0: return False
		cobj.instrument_candidates = []

		PITCH = cobj.desc.get('MIDIPitch-seg')
		if cobj.transMethod != None and cobj.transMethod.startswith("semitone"):
			# exception for midipitch to incorporate transposition
			PITCH += float(cobj.transMethod.split()[1])
		DB = util.ampToDb(cobj.desc.get('power-seg')) + cobj.envDb
		
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
			# extradata text testing
			tests.extend([teststring%(os.path.split(cobj.filename)[1].split()[1]) for teststring in self.instrument_tests[i, cobj.voiceID]['seqdata']])
			##
#			if len([teststring%(cobj.segfileData.split()[0]) for teststring in self.instrument_tests[i, cobj.voiceID]['seqdata']]) > 0:
#				mytests = [teststring%(cobj.segfileData.split()[0]) for teststring in self.instrument_tests[i, cobj.voiceID]['seqdata']][0]
#				print("\t", mytests, eval(mytests))
			##
			for t in tests:
				if not eval(t):
					add_this_instr = False
					break
			if add_this_instr: cobj.instrument_candidates.append(i)
		if len(cobj.instrument_candidates) == 0: return False
		else: return True
	########################################
	def increment(self, start, dur, eobj):
		if not self.active: return
		if eobj.sfseghandle.instrTag not in self.instrument_names:
			eobj.selectedinstrument = None
			self.tracker.noninstrument_num_notes += 1
			return
		# if we're passing this point, we're picking the instrument
		vc = eobj.sfseghandle.voiceID
		eobj.selectedinstrument = eobj.sfseghandle.instrument_candidates[0]
		eobj.selectedInstrumentIdx = self.instrumentNameToIdx[eobj.selectedinstrument]
		thisinstr = self.instruments[eobj.selectedinstrument]
		# increment shit
		if thisinstr['cps'][vc]['temporal_mode'] == 'artic': dur = 1
		self.tracker.addnote(eobj.selectedinstrument, eobj.sfseghandle.voiceID, start, dur, eobj.midi, eobj.rmsSeg+eobj.envDb, thisinstr['cps'][vc]['technique'], eobj.tgtsegnumb, eobj)
	########################################
	def write(self, outputfile, targetSegs, corpusNameList, outputEvents, bachSlotsDict, velocityMapping, tgtStaffType, cpsStaffType, addTarget=True):
		bs = audioguide_bach_segments(bachSlotsDict, velocityMapping)		
		#########################
		## parse target sounds ##
		#########################
		if addTarget: # using target?
			bs.add_voice('target', 'target', clef=tgtStaffType)
			for tobj in targetSegs:	
				skip = tobj.segmentStartSec
				if hasattr(tobj, 'decomposeSfSkip'): # hack for signal decomposition
					skip = tobj.decomposeSfSkip
				bs.add_note('target', tobj.segmentStartSec, tobj.segmentDurationSec, tobj.desc.get('MIDIPitch-seg'), tobj.filename, skip, tobj.soundfileChns, util.ampToDb(tobj.power), tobj.envDb, tobj.envAttackSec, tobj.envDecaySec, tobj.desc, 0, tobj.numberSelectedUnits)
		###############################
		## add any instrument voices ##
		###############################
		repr_voices = []
		if self.active: # using instruments?
			for v_id, ddict in self.instruments.items():
				bs.add_voice(v_id, self.instruments[v_id]['displayname'], clef=self.instruments[v_id]['params'].params['clef'])
				repr_voices.extend(list(self.instruments[v_id]['cps'].keys()))
		##########################################
		## add any non-instrument corpus voices ##
		##########################################
		non_instrument_corpus_idxs = [eobj.voiceID for eobj in outputEvents if eobj.voiceID not in repr_voices]
		non_instrument_corpus_idxs = list(set(non_instrument_corpus_idxs))
		if len(non_instrument_corpus_idxs) > 0: # if there are any, add _all_ voices even if they don't have notes. gotta be consistent.
			for voiceid in non_instrument_corpus_idxs:
				bs.add_voice("cps%i"%voiceid, util.cpsPathToTrackName(corpusNameList[voiceid]), clef=cpsStaffType)
		########################################################
		## loop through all select corpus items and add notes ##
		########################################################
		for eobj in outputEvents:
			LINKED_TO_INSTRUMENT = self.active and eobj.selectedinstrument != None
			if not LINKED_TO_INSTRUMENT:
				bs.add_note('cps%i'%eobj.voiceID, eobj.timeInScore, eobj.duration, eobj.midi, eobj.filename, eobj.sfSkip, eobj.sfchnls, eobj.rmsSeg, eobj.envDb, eobj.envAttackSec, eobj.envDecaySec, eobj.sfseghandle.desc, eobj.transposition, eobj.simSelects)
			else:
				thiscps = self.instruments[eobj.selectedinstrument]['cps'][eobj.voiceID]
				bs.add_note(eobj.selectedinstrument, eobj.timeInScore, eobj.duration, eobj.midi, eobj.filename, eobj.sfSkip, eobj.sfchnls, eobj.rmsSeg, eobj.envDb, eobj.envAttackSec, eobj.envDecaySec, eobj.sfseghandle.desc, eobj.transposition, eobj.simSelects, instr_dynamic=self.instruments[eobj.selectedinstrument]['cps'][eobj.voiceID]['cobj_to_dyn'][eobj.sfseghandle],
				instr_technique=thiscps['technique'], instr_temporal_mode=thiscps['temporal_mode'], instr_articulation=thiscps['articulation'], instr_notehead=thiscps['notehead'], instr_annotation=thiscps['annotation'], 
				)
		################################
		## make a big ol' bach string ##
		################################
		bachstring = 'roll '
		# set up clefs
		bachstring += "[clefs %s] "%' '.join([vd['clef'] for vd in bs.voices_ordered])
		# set up voices
		bachstring += "[voicenames %s] "%' '.join([vd['displayname'] for vd in bs.voices_ordered])
		# init slots
		initslots = []
		for slotname, slotdict in bs.slots.items():
			if slotdict['range'] == False:
				# no range needed
				slotdict['range'] = ''
			elif type(slotdict['range']) == type([]):
				# range is fixed
				slotdict['range'] = '[range %f %f]'%tuple(slotdict['range'])
			elif slotdict['range'] == 'auto':
				# range needs to be calculated
				minny, maxxy = min(bs.slots_minmax_lists[slotdict['idx']]), max(bs.slots_minmax_lists[slotdict['idx']])
				slotdict['range'] = '[range %f %f] '%(minny, maxxy)
			
			if slotname in ['instr_dynamic', 'instr_articulation', 'instr_notehead', 'instr_annotation']: continue
			slotname = slotname.replace('cps_', '')
			slotname = slotname.replace('instr_', '')
			initslots.append('[%i [type %s] [name %s] %s]'%(slotdict['idx'], slotdict['type'], slotname, slotdict['range']) )
		bachstring += '[slotinfo %s]'%' '.join(initslots)

		# write notes
		for voice in bs.voice_to_notes:
			bachstring += '[ ' # instrument start
			for time, (notelist, slotDictOnce) in bs.voice_to_notes[voice].items():
				bachstring += ' [%i.'%time # note start
				for didx, d in enumerate(notelist):
					# only write once slots for first note
					always = ' '.join(d[3])
					if didx == 0:
						once = ' '.join(slotDictOnce)
						slotstring = '[slots %s %s ]'%(once, always)
					else: # already wrote slots on a prev not in this chord
						slotstring = '[slots %s ]'%(always)
					bachstring += ' [%i %i %i %s] '%(d[0], d[1], d[2], slotstring)
				bachstring += '] ' # note end
			bachstring += '] ' # instrument end
		fh = open(outputfile, 'w')
		fh.write(bachstring)
		fh.close()
	########################################





########################################
########################################
class audioguide_bach_segments:
	def __init__(self, bachSlotsDict, velocityMapping):
		self.voices_ordered = []
		self.voice_to_notes = {}

		self.velocityMapping_db = np.array(velocityMapping[::2])
		self.velocityMapping_vel = np.array(velocityMapping[1::2])

		self.slots = {}
		for slotidx, slotkey in bachSlotsDict.items():
			if   slotkey == 'fullpath': self.slots[slotkey] = {'idx': slotidx, 'range': False, 'type': 'text', 'once': False}
			elif slotkey == 'sfskiptime': self.slots[slotkey] = {'idx': slotidx, 'range': 'auto', 'type': 'float', 'once': False}
			elif slotkey == 'sfchannels': self.slots[slotkey] = {'idx': slotidx, 'range': [0, 100], 'type': 'int', 'once': False}
			elif slotkey == 'env': self.slots[slotkey] = {'idx': slotidx, 'range': [0, 1], 'type': 'function', 'once': False}
			elif slotkey == 'transposition': self.slots[slotkey] = {'idx': slotidx, 'range': 'auto', 'type': 'float', 'once': False}
			elif slotkey == 'selectionnumber': self.slots[slotkey] = {'idx': slotidx, 'range': 'auto', 'type': 'int', 'once': False}
			elif slotkey == 'instr_dynamic': self.slots[slotkey] = {'idx': slotidx, 'range': False, 'type': 'text', 'once': True}
			elif slotkey == 'instr_technique': self.slots[slotkey] = {'idx': slotidx, 'range': False, 'type': 'text', 'once': True}
			elif slotkey == 'instr_temporal_mode': self.slots[slotkey] = {'idx': slotidx, 'range': False, 'type': 'text', 'once': True}
			elif slotkey == 'instr_articulation': self.slots[slotkey] = {'idx': slotidx, 'range': False, 'type': 'text', 'once': True}
			elif slotkey == 'instr_notehead': self.slots[slotkey] = {'idx': slotidx, 'range': False, 'type': 'text', 'once': False}
			elif slotkey == 'instr_annotation': self.slots[slotkey] = {'idx': slotidx, 'range': False, 'type': 'text', 'once': False}
			else:
				# descriptors
				if type(slotkey) == type("") and slotkey.find('seg') != -1:
					# segmented
					self.slots[slotkey] = {'idx': slotidx, 'range': 'auto', 'type': 'float', 'once': False, 'descriptor': slotkey}
				elif type(slotkey) == type("") and slotkey.find('seg') == -1:
					# time-varying
					self.slots[slotkey] = {'idx': slotidx, 'range': 'auto', 'type': 'floatlist', 'once': False, 'descriptor': slotkey}
				else:
					# list of segmented descriptors
					self.slots["%idescriptors"%len(slotkey)] = {'idx': slotidx, 'range': 'auto', 'type': 'floatlist', 'once': False, 'descriptor': slotkey}
		self.slots_minmax_lists = {v['idx']: [] for k, v in self.slots.items() if v['range'] == 'auto'}
	########################################
	def add_voice(self, voicename, displayname, clef='G'):
		# voicename is unique, displayname shows up in the score
		self.voices_ordered.append({'id': voicename, 'displayname': displayname, 'clef': clef})
		self.voice_to_notes[voicename] = {}
	########################################
	def add_note(self, voicename, time, duration, midipitch, fullpath, sfskiptime, sfchannels, peakdb, scaledb, attack, decay, descobj, transposition, selectionnumber, instr_dynamic=None, instr_articulation=None, instr_notehead=None, instr_annotation=None, instr_technique=None, instr_temporal_mode=None):
		assert voicename in self.voice_to_notes
		# basic shit
		time_ms = time * 1000
		cents = midipitch * 100
		duration_ms = duration * 1000
		
		velocity = int(round(np.interp(peakdb+scaledb, self.velocityMapping_db, self.velocityMapping_vel, left=self.velocityMapping_vel[0], right=self.velocityMapping_vel[-1]), 0))
		
		slot_data = [], [] # everychord, everynote
		for slotkey, datad in self.slots.items():
			datum = None
			if slotkey == 'fullpath':
				datum = '"%s"'%fullpath
			elif slotkey == 'sfskiptime':
				datum = sfskiptime*1000
			elif slotkey == 'sfchannels':
				datum =  int(sfchannels)
			elif slotkey == 'env':
				scaleamp = util.dbToAmp(scaledb)
				attack_percent = attack/duration
				decay_percent = (duration-decay)/duration
				datum = '[0 0 0] [%.6f %f 0] [%.6f %f 0] [1 0 0]'%(attack_percent, scaleamp, decay_percent, scaleamp)
			elif slotkey == 'transposition':
				datum = transposition
			elif slotkey == 'selectionnumber':
				datum = int(selectionnumber)
			elif slotkey == 'instr_dynamic' and instr_dynamic != None:
				datum = instr_dynamic
			elif slotkey == 'instr_technique' and instr_technique != None:
				datum = '"%s"'%instr_technique
			elif slotkey == 'instr_temporal_mode' and instr_temporal_mode != None:
				datum = instr_temporal_mode
			elif slotkey == 'instr_articulation' and instr_articulation != None:
				datum = instr_articulation
			elif slotkey == 'instr_notehead' and instr_notehead != None:
				datum = instr_notehead
			elif slotkey == 'instr_annotation' and instr_annotation != None:
				datum = '"%s"'%instr_annotation
			elif 'descriptor' in datad and type(datad['descriptor']) == type("") and datad['descriptor'].find('seg') == -1:
				# time-varying descriptor data
				datum = list(descobj.get(datad['descriptor']))
			elif 'descriptor' in datad and type(datad['descriptor']) == type([]):
				# list of averaged descriptors
				datum = [descobj.get(d) for d in datad['descriptor']]
			elif 'descriptor' in datad and type(datad['descriptor']) == type([]) and datad['descriptor'].find('seg') != -1:
				# single averaged descriptor
				datum = descobj.get(datad['descriptor'])

			if datum == None: continue # skip things that are not set
			
			if type(datum) == type([]):
				stringdatum = ' '.join(["%.8f"%d for d in datum])
				if self.slots[slotkey]['range'] == 'auto': self.slots_minmax_lists[datad['idx']].extend(datum)
			else:
				stringdatum = str(datum)
				if self.slots[slotkey]['range'] == 'auto': self.slots_minmax_lists[datad['idx']].append(datum)
			
			if self.slots[slotkey]['once']:
				slot_data[0].append('[%i %s]'%(datad['idx'], stringdatum))
			else:
				slot_data[1].append('[%i %s]'%(datad['idx'], stringdatum))
		if time_ms not in self.voice_to_notes[voicename]: self.voice_to_notes[voicename][time_ms] = [[], slot_data[0]]
		self.voice_to_notes[voicename][time_ms][0].append([cents, duration_ms, velocity, slot_data[1]])
