import sys, os, json
import numpy as np
import audioguide.util
import audioguide.fileoutput.csoundinterface as csound

try:
	import librosa
except ImportError:
	audioguide.util.missing_module('librosa')


def find_nonzero_runs(a):
    # Create an array that is 1 where a is nonzero, and pad each end with an extra 0.
    isnonzero = np.concatenate(([0], (np.asarray(a) != 0).view(np.int8), [0]))
    absdiff = np.abs(np.diff(isnonzero))
    # Runs start and end where absdiff is 1.
    ranges = np.where(absdiff == 1)[0].reshape(-1, 2)
    return ranges


class PartialData:
	def __init__(self, ):
		self.loaded_partial_data = {}
		self.init = False
		
	def init_partial_analysis(self, sf_path, peakanaldir, frame_size, win_size, hop_size, mindb=-50, maxpeaks=50, forceAnal=False):
		checksum = audioguide.util.listToCheckSum([sf_path, frame_size, win_size, hop_size, mindb, maxpeaks, 'peaks'])[:12]
		filehead = '%s-%s'%(os.path.split(sf_path)[1], checksum)
		self.peakdatapath = os.path.join(peakanaldir, '%s-peaks.json'%(filehead))
		# test if this anaylsis file exists and load it, otherwise run peak analysis and save the file for the future..
		if (self.peakdatapath not in self.loaded_partial_data and not os.path.exists(self.peakdatapath)) or forceAnal:
			# run peak analysis
			self.loaded_partial_data[self.peakdatapath] = self.__create_partial_analysis(sf_path, frame_size, win_size, hop_size, mindb, maxpeaks)
			# write it
			fh = open(self.peakdatapath, 'w')
			json.dump(self.loaded_partial_data[self.peakdatapath], fh)
		else:
			# load it
			fh = open(self.peakdatapath, 'r')
			self.loaded_partial_data[self.peakdatapath] = json.load(fh)
		# add selection arrays
		for par in self.loaded_partial_data[self.peakdatapath]['partials']:
			par['selections'] = np.zeros(len(par['frqs']))
		self.init = True
		#self.partial_search_candidates = {}		

	class Partial:
		def __init__(self, tgtlength, idx, estfrq, amp):
			self.frqs = np.zeros(tgtlength)
			self.amps = np.zeros(tgtlength)
			self.set_frame(idx, estfrq, amp)
			self.initidx = idx

		def set_frame(self, idx, estfrq, amp):
			self.frqs[idx] = estfrq
			self.amps[idx] = amp
	
		def stage(self, f2s):
			self.startframe = 0
			while self.amps[self.startframe] == 0: self.startframe += 1
			self.stopframe = len(self.amps)-1
			while self.amps[self.stopframe] == 0: self.stopframe -= 1
			self.starttime = self.startframe*f2s
			self.stopframe += 1
			self.lentime = (self.stopframe-self.startframe)*f2s
			self.stoptime = self.starttime+self.lentime
			
		def dumpdict(self):
			par = {'lentime': self.lentime, 'startframe': self.startframe, 'stopframe': self.stopframe, 'frqs': list(self.frqs[self.startframe:self.stopframe]), 'amps': list(self.amps[self.startframe:self.stopframe])}
			par['avg_frq'] = np.average(par['frqs'], weights=par['amps'])
			par['peak_amp'] = np.max(par['amps'])
			par['avg_midi'] = audioguide.util.frq2Midi(par['avg_frq'])
			par['peak_db'] = audioguide.util.ampToDb(par['peak_amp'])
			return par


	def __create_partial_analysis(self, sf_path, frame_size, win_size, hop_size, mindb, maxpeaks, verbose=False, ):
		print("\n\nCreating partial analysis for %s"%(sf_path))
		print("\t-> writting partial data to the file %s"%(self.peakdatapath))
		self.frame_size = frame_size
		self.win_size = win_size
		self.hop_size = hop_size

		min_db_extend_partial = -70
		min_amp_start_partial = audioguide.util.dbToAmp(mindb)
		min_amp_extend_partial = audioguide.util.dbToAmp(min_db_extend_partial)
		max_frq_change_per_frame = 20.


		self.y, self.sampling_rate = librosa.load(sf_path, sr=None)
		self.f2s = self.hop_size/self.sampling_rate
		fft_frames = librosa.stft(self.y, n_fft=int(self.frame_size), hop_length=int(self.hop_size), win_length=int(self.win_size))
		self.fftfreqs = librosa.fft_frequencies(sr=self.sampling_rate, n_fft=int(self.frame_size))
		# weight by frequency?
		#print(librosa.fft_frequencies())
		#log_S = librosa.perceptual_weighting(np.power(fft_frames,2), librosa.fft_frequencies())
		#print(log_S[0])
		fft_frames = fft_frames.T
		print("\t-> %i FFT frames"%(fft_frames.shape[0]))
		abs_fft_frames = np.abs(fft_frames)
		sum_abs_fft_frames = np.sum(abs_fft_frames, axis=1)
		max_fft_sum = np.max(sum_abs_fft_frames)
		# get FFT peaks
		print("\t-> analyzing peak frequencies...")
		peak_frames = []
		for fidx, frame in enumerate(abs_fft_frames):
			_current_peaks = []
#			_amps = []
#			_freqs = []
#			_est_freqs = []
			# find all peaks in the spectrum
			for bin in range(2, len(frame) - 1):
				if (frame[bin] > frame[bin - 1] and frame[bin] > frame[bin + 1] ):
					amp = (frame[bin]/max_fft_sum)
					if amp < min_amp_extend_partial: continue
					# estimate freqs from phase difference
					est_freq = self.fftfreqs[bin] + ((np.angle(frame[bin])-np.angle(frame[bin - 1])) / self.f2s)
#					_amps.append(amp)
#					_freqs.append(bin_freq)
#					_est_freqs.append(est_freq)
					_current_peaks.append([amp, est_freq])
			
			# sort peaks, largest amplitude first, and up to a max
			# of num_peaks peaks
#			peak_array = np.array([np.array(_amps), np.array(_freqs)]).T
#			print(peak_array[0], peak_array.shape)
#			if len(_current_peaks) > 1: sys.exit()


			_current_peaks.sort(reverse=True)
			#print("frame %i - %i peaks"%(fidx, len(_current_peaks)), mindb)
			if len(_current_peaks) > maxpeaks:
				_current_peaks = _current_peaks[0:maxpeaks]

			peak_frames.append(_current_peaks)
		#for frame in peak_frames:
		#	if verbose and len(frame) > 0: print("\t", np.max([p[0] for p in frame]), np.average([p[1] for p in frame]))
		
		all_partials = []
		
		print("\t-> extracting partials forwards...")
		for frameidx, peak_frame in enumerate(peak_frames):
			par_cnt = 0
			# peak frame moving forward, then peakframe moving back
			look_frame_frqs = np.array([par.frqs[frameidx-1] for par in all_partials])
			#look_frame_amps = np.array([par.amps[frameidx-1] for par in all_partials])
			for pamp, pestfreq in peak_frame:
				# test for a continuation of the previous frame first
				passed_ratio_test = [(pestfreq-all_partials[paridx].frqs[frameidx-1], paridx) for paridx, frqchange in enumerate(np.abs(pestfreq-look_frame_frqs)) if frqchange <= max_frq_change_per_frame]
				#print(passed_ratio_test, len(passed_ratio_test) > 0, pamp >= audioguide.util.dbToAmp(min_amp_start_partial))
				if len(passed_ratio_test) > 0:
					passed_ratio_test.sort() # sort by least difference in hz
					# Do I need to test to see if this partial has a current entry?
					if pamp >= min_amp_extend_partial: 
						all_partials[passed_ratio_test[0][1]].set_frame(frameidx, pestfreq, pamp)
				elif pamp >= min_amp_start_partial:
					# no matches found, make a new partial if this peak is loud enough!
					#print("all_partials", seglen, frameidx, pestfreq, pamp)
					all_partials.append(self.Partial(len(fft_frames), frameidx, pestfreq, pamp))
					par_cnt += 1
			#print("\t\tframe %i - added %i partials"%(frameidx, par_cnt))
		# now see if any selected partials can be extended back in time
		print("\t-> linking partials backwards...")
		for par in all_partials:
			#print("partial", par.initidx)
			while par.initidx > 0:
				prev_frame_freq_diffs = np.abs(par.frqs[par.initidx]-np.array([pestfreq for pamp, pestfreq in peak_frames[par.initidx-1]]))
				if len(prev_frame_freq_diffs) == 0: break
				mindiff = np.min(prev_frame_freq_diffs)
				if mindiff > max_frq_change_per_frame: break
				argmindiff = np.argmin(prev_frame_freq_diffs)
				par.set_frame(par.initidx-1, peak_frames[par.initidx-1][argmindiff][1], peak_frames[par.initidx-1][argmindiff][0])
				par.initidx -= 1

		
		output_dict = {'f2s': self.f2s, 'partials': []}
		for par in all_partials:
			par.stage(self.f2s)
			if par.stopframe-par.startframe > 1:
				output_dict['partials'].append(par.dumpdict())
		
		return output_dict



	def filter_partials(self, min_partial_duration, partial_limit_db, partial_limit_midi, partial_max_overlaps, partial_min_confidence):
		print("\t-> filtering partials:")
		print("\t\t-> between %i and %i dB"%(partial_limit_db))
		print("\t\t-> between %.1f and %.1f dB"%(partial_limit_midi))
		print("\t\t-> %i maximum overlapping partials"%(partial_max_overlaps))
		maxstopframe = max([p['stopframe'] for p in self.loaded_partial_data[self.peakdatapath]['partials']])
		overlaps = np.zeros(maxstopframe, dtype=int)
		valid_partials = []
		# sort partials by amplitude
		self.loaded_partial_data[self.peakdatapath]['partials'] = sorted(self.loaded_partial_data[self.peakdatapath]['partials'], key=lambda k: k['peak_db'], reverse=True) 
		
		
		for par in self.loaded_partial_data[self.peakdatapath]['partials']:
		
			par['overlap_cnt'] = np.max(overlaps[par['startframe']:par['stopframe']])
			# tests
			if par['lentime'] < min_partial_duration: continue
			if par['peak_db'] < partial_limit_db[0]: continue
			if par['peak_db'] > partial_limit_db[1]: continue
			if par['avg_midi'] < partial_limit_midi[0]: continue
			if par['avg_midi'] > partial_limit_midi[1]: continue

			import nu
			dbs_under_minamp = np.array(nu.ampToDb(par['amps'])/partial_limit_db[0], dtype=int)
			f2s = self.loaded_partial_data[self.peakdatapath]['f2s']
			confidence = 100*(1-(float(np.sum(dbs_under_minamp))/len(dbs_under_minamp)))
			if confidence < partial_min_confidence: continue

			if par['overlap_cnt'] > partial_max_overlaps: continue
			# add it
			valid_partials.append(par)
			overlaps[par['startframe']:par['stopframe']] += 1
		return valid_partials


	def rendercsoundpartials(self, partials, renderfilepath, type='continuous'):
		print("\t-> rendering partial sines to", renderfilepath)
		csound_ftables = []
		csound_notes = []
		f2s = self.loaded_partial_data[self.peakdatapath]['f2s']
		if type == 'continuous':
			ft_cnt = 1
			fh = open(renderfilepath+'.txt', 'w')
			for par in partials:
				# make frq ftable
				csound_ftables.append(['f%i'%ft_cnt, 0, len(par['frqs']), -2] + par['frqs'])
				csound_ftables.append(['f%i'%(ft_cnt+1), 0, len(par['frqs']), -2] + par['amps'])
				csound_notes.append(['i1', par['startframe']*f2s, par['lentime'], len(par['frqs']), ft_cnt, ft_cnt+1] )
				ft_cnt += 2
				fh.write("%f\t%f\t%.2f %i\n"%(par['startframe']*f2s, par['startframe']*f2s+par['lentime'], np.average(par['frqs']), audioguide.util.ampToDb(np.max(par['amps']))))
			fh.close()
		elif type == 'target_candidates':
			for stoptime, (starttime, listoshit) in self.partial_search_candidates.items():
				for amp, frq in listoshit:
					csound_notes.append(['i2', starttime, stoptime-starttime, amp, frq] )
		csound.makePartialRendering('/tmp/partials.csd', renderfilepath, csound_ftables, csound_notes)
		csound.render('/tmp/partials.csd', len(csound_notes), printerobj=None)

		
#	def get_partials(self, sf_path, starttime, stoptime, tgtpeakamp, maxpartials=8, maxpeaks=20, mindur=0.1, mindb=-60, minpitch=20, maxpitch=110, max_selections_per_partial=1, quantizemidi=1):
#		tgtstartframe = int(starttime/self.loaded_partial_data[self.peakdatapath]['f2s'])
#		tgtstopframe = int(stoptime/self.loaded_partial_data[self.peakdatapath]['f2s'])
#		
#		#print("\n\nCOUNTER 1 SELECTIONS %i"%sum([1 for par in self.loaded_partial_data[self.peakdatapath]['partials'] if par['selections'] == 1]))
#		valid_logic = {'too short': 0, 'too many selections': 0, 'maxpartials limit': 0, 'too soft': 0, 'too low': 0, 'too high': 0}
#		valid_partials_in_time = []
#		valid_partials = []
#		for par in self.loaded_partial_data[self.peakdatapath]['partials']:
#			if tgtstartframe > par['stopframe'] or tgtstopframe <= par['startframe']:
#				continue
#			start_frame_look = max(tgtstartframe, par['startframe'])
#			stop_frame_look = min(tgtstopframe, par['stopframe'])
#			if start_frame_look >= stop_frame_look: continue
#			par['sel_slice'] = slice(start_frame_look-par['startframe'], stop_frame_look-par['startframe'])
#			s = start_frame_look - par['startframe']
#			e = stop_frame_look - par['startframe']
#			#print(s, e, startframe, stopframe, pardict['amps'])
#			par['avg_frq'] = np.average(par['frqs'][s:e], weights=par['amps'][s:e])
#			par['peak_amp'] = np.max(par['amps'][s:e])
#			par['avg_midi'] = audioguide.util.frq2Midi(par['avg_frq'])
#			par['peak_db'] = audioguide.util.ampToDb(par['peak_amp'])#*tgtpeakamp
#		
#			
#
#			# this one is valid in terms of time
#			valid_partials_in_time.append(par)
#
#		#print("\n\n", starttime, stoptime, len(valid_partials_in_time), [par['avg_midi'] for par in valid_partials_in_time  ])
#
#		for par in valid_partials_in_time:
#			if par['lentime'] < mindur:
#				valid_logic['too short'] += 1
#				continue
#
#
#			if max(par['selections'][par['sel_slice']]) > max_selections_per_partial:
#				valid_logic['too many selections'] += 1
#				continue
#
#			#self.par_dict_get_midi_db(par, start_frame_look, stop_frame_look, tgtpeakamp)
#			#print(starttime, stoptime, par.starttime, par.stoptime, par.avg_midi, par.peak_db)
#			if par['peak_db'] < mindb:
#				valid_logic['too soft'] += 1
#				continue
#			if par['avg_midi'] < minpitch:
#				valid_logic['too low'] += 1
#				continue
#			if par['avg_midi'] > maxpitch:
#				valid_logic['too high'] += 1
#				continue
#			# manipulate data now
#			par['avg_midi'] = audioguide.util.quantize(par['avg_midi'], quantizemidi)
#			valid_partials.append(par)
#		# sort partials by loudness
#		valid_partials.sort(key=lambda x: x['peak_db'], reverse=True)
#		
#		
#		if len(valid_partials) > maxpartials:
#			valid_logic['maxpartials limit'] = len(valid_partials)-maxpartials
#			valid_partials = valid_partials[:maxpartials]
#
#		if stoptime not in self.partial_search_candidates:
#			self.partial_search_candidates[stoptime] = [starttime, [[p['peak_amp'], p['avg_frq']] for p in valid_partials]]
#		
##		if len(valid_partials) > 0:
##			print("\n\nPARTIALS - ", "%i/%i"%(len(valid_partials), len(valid_partials_in_time)))
##			for v, k in  valid_logic.items():
##				print('\t%.1f%% - %s'%((100*float(k))/len(valid_partials_in_time), v) )
##			print("\n\n")
#		self.rendercsoundpartials('/Users/ben/Desktop/tgt_cand.wav', mindb=mindb, type='target_candidates')		
#
#		return valid_partials
#
#
#
#def target_find_partials(sf_path, frame_size, win_size, hop_size, starttime, stoptime, tgtpeakamp, seeksec=0, maxpartials=8, mindur=0.1, mindb=-40, max_selections_per_partial=1, quantizemidi=0, minpitch=20, maxpitch=110):
#	global pd
#	if not pd.init:
#		pd.init_partial_analysis(sf_path, os.path.join(os.path.split(__file__)[0], 'data'), frame_size, win_size, hop_size, mindb=-40, maxpeaks=20)
#	pd.valid_partials = pd.get_partials(sf_path, starttime+seeksec, stoptime-seeksec, tgtpeakamp, maxpartials=maxpartials, mindur=mindur, mindb=mindb, minpitch=minpitch, maxpitch=maxpitch, max_selections_per_partial=max_selections_per_partial, quantizemidi=quantizemidi)
#	return len(pd.valid_partials)
#	
#
#
#def searchCorpus(corpusObjs, pitchtolerance=3, dbtolerance=18, forceloudestpartial=True):
#	'''shitty code alert'''
#	global pd
#	partial_candidates = {}
#	lowest_pidx = 100000000
#	for c in corpusObjs:
#		partial_candidates[c] = []
#		c.db = audioguide.util.ampToDb(c.desc.get('power-seg')) + c.envDb
#		for pidx, p in enumerate(pd.valid_partials):
#			pitchdiff = p['avg_midi'] - c.desc.get('MIDIPitch-seg')
#			dbdiff = p['peak_db'] - c.db
#			if np.abs(pitchdiff) > pitchtolerance: continue
#			if np.abs(dbdiff) > dbtolerance: continue
#			if pidx < lowest_pidx: lowest_pidx = pidx
#			partial_candidates[c].append([np.abs(pitchdiff), np.abs(dbdiff), pitchdiff, dbdiff, pidx, True])
#
#	if lowest_pidx == 100000000: return []
#
#	if forceloudestpartial:
#		for c in partial_candidates:
#			for listy in partial_candidates[c]:
#				if listy[4] != lowest_pidx: listy[5] = False # disable
#	
#	newList = []
#	for c in partial_candidates:
#		possibilities = [listy for listy in partial_candidates[c] if listy[5]]
#		possibilities = sorted(possibilities, key = lambda x: (x[0], x[1]))  # sort by min pitch difference, then ampdiff
#		if len(possibilities) == 0: continue
#		win_abspitchdiff, win_abs_dbdiff, win_pitchdiff, win_dbdiff, winpidx, booly = possibilities[0]
#		c.partial_data = {'pobj': pd.valid_partials[winpidx], 'pitchdiff': win_pitchdiff, 'dbdiff': win_dbdiff}
#		newList.append(c)
#
#	return newList
#



pd = PartialData()
