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

	def init_partial_analysis(self, sf_path, peakanaldir, frame_size, win_size, hop_size, mindb=-60, maxpeaks=20):
		checksum = audioguide.util.listToCheckSum([sf_path, frame_size, win_size, hop_size, mindb, maxpeaks, 'peaks'])[:12]
		filehead = '%s-%s'%(os.path.split(sf_path)[1], checksum)
		self.peakdatapath = os.path.join(peakanaldir, '%s-peaks.json'%(filehead))
		# test if this anaylsis file exists and load it, otherwise run peak analysis and save the file for the future..
		if self.peakdatapath not in self.loaded_partial_data and not os.path.exists(self.peakdatapath):
			# run peak analysis
			self.loaded_partial_data[self.peakdatapath] = self.__create_partial_analysis(sf_path, frame_size, win_size, hop_size)
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
		

	class Partial:
		def __init__(self, tgtlength, idx, frq, amp):
			self.frqs = np.zeros(tgtlength)
			self.amps = np.zeros(tgtlength)
			self.frqs[idx] = frq
			self.amps[idx] = amp

		def extend(self, frq, amp, idx):
			self.frqs[idx] = frq
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
			return {'lentime': self.lentime, 'startframe': self.startframe, 'stopframe': self.stopframe, 'frqs': list(self.frqs[self.startframe:self.stopframe]), 'amps': list(self.amps[self.startframe:self.stopframe])}


	def __create_partial_analysis(self, sf_path, frame_size, win_size, hop_size, mindb=-60, maxpeaks=20, verbose=False):
		print("\n\nCreating partial analysis for %s"%(sf_path))
		print("\t-> writting to the file %s"%(self.peakdatapath))
		self.frame_size = frame_size
		self.win_size = win_size
		self.hop_size = hop_size
		self.y, self.sampling_rate = librosa.load(sf_path, sr=None)
		self.fundamental = float(self.sampling_rate) / self.frame_size
		self.f2s = self.hop_size/self.sampling_rate
		fft_frames = librosa.stft(self.y, n_fft=int(self.frame_size), hop_length=int(self.hop_size), win_length=int(self.win_size))
		print("\t-> %i FFT frames"%(fft_frames.shape[1]))
		# get FFT peaks
		print("\t-> analyzing peak frequencies...")
		peak_frames = []
		for fidx, frame in enumerate(fft_frames.T):
			_current_peaks = []
			spectrum = abs(frame)
			# find all peaks in the spectrum
			for bin in range(2, len(spectrum) - 1):
				current_mag = spectrum[bin]
				sum_mags = np.sum(spectrum)
				prev_mag = spectrum[bin - 1]
				next_mag = spectrum[bin + 1]
				trio_mags = np.sum(spectrum[bin-1:bin+1])
				if (current_mag > prev_mag and current_mag > next_mag):
					_current_peaks.append([(trio_mags/sum_mags), bin * self.fundamental])
			# sort peaks, largest amplitude first, and up to a max
			# of num_peaks peaks
			_current_peaks.sort(reverse=True)
			if len(_current_peaks) > maxpeaks:
				_current_peaks = _current_peaks[0:maxpeaks]
			peak_frames.append(_current_peaks)
		#for frame in peak_frames:
		#	if verbose and len(frame) > 0: print("\t", np.max([p[0] for p in frame]), np.average([p[1] for p in frame]))
		
		all_partials = []
		min_amp_extend_partial = -70
		max_bin_change_per_frame = 1
		
		print("\t-> extracting partials...")
		for frameidx, peak_frames in enumerate(peak_frames):
			# peak frame moving forward, then peakframe moving back
			look_frame_frqs = np.array([par.frqs[frameidx-1] for par in all_partials])
			#look_frame_amps = np.array([par.amps[frameidx-1] for par in all_partials])
			for pamp, pfreq in peak_frames:
				# test for a continuation of the previous frame first
				passed_ratio_test = [(pfreq-all_partials[paridx].frqs[frameidx-1], paridx) for paridx, binchange in enumerate(np.abs(pfreq-look_frame_frqs)/self.fundamental) if binchange <= max_bin_change_per_frame]
				#print(passed_ratio_test, len(passed_ratio_test) > 0, pamp >= audioguide.util.dbToAmp(min_amp_start_partial))
				if len(passed_ratio_test) > 0:
					passed_ratio_test.sort() # sort by least difference in hz
					# Do I need to test to see if this partial has a current entry?
					if pamp >= audioguide.util.dbToAmp(min_amp_extend_partial): 
						all_partials[passed_ratio_test[0][1]].extend(pfreq, pamp, frameidx)
				elif pamp >= audioguide.util.dbToAmp(mindb):
					# no matches found, make a new partial if this peak is loud enough!
					#print("all_partials", seglen, frameidx, pfreq, pamp)
					all_partials.append(self.Partial(len(fft_frames), frameidx, pfreq, pamp))

		output_dict = {'f2s': self.f2s, 'partials': []}
		for par in all_partials:
			par.stage(self.f2s)
			if par.stopframe-par.startframe > 1:
				output_dict['partials'].append(par.dumpdict())
		
		partials_renderfile = '/Users/ben/Desktop/partials.wav'
		print("\t-> rendering partials to ", partials_renderfile)
		# render csound?
		csound_ftables = []
		csound_notes = []
		ft_cnt = 1
		for par in self.loaded_partial_data[self.peakdatapath]['partials']:
			# make frq ftable
			csound_ftables.append(['f%i'%ft_cnt, 0, len(par['frqs']), -2] + par['frqs'])
			csound_ftables.append(['f%i'%(ft_cnt+1), 0, len(par['frqs']), -2] + par['amps'])
			csound_notes.append(['i1', par['startframe']*self.f2s, par['lentime'], len(par['frqs']), ft_cnt, ft_cnt+1] )
			ft_cnt += 2
		csound.makePartialRendering('/tmp/partials.csd', partials_renderfile, csound_ftables, csound_notes)
		csound.render('/tmp/partials.csd', len(csound_notes), printerobj=None)
		
		return output_dict



#	def par_dict_get_midi_db(self, pardict, startframe, stopframe, tgtpeakamp):
#		s = startframe - pardict['startframe']
#		e = stopframe - pardict['startframe']
#		#print(s, e, startframe, stopframe, pardict['amps'])
#		pardict['avg_midi'] = audioguide.util.frq2Midi(np.average(pardict['frqs'][s:e], weights=pardict['amps'][s:e]))
#		pardict['peak_db'] = audioguide.util.ampToDb(np.max(pardict['amps'][s:e])*tgtpeakamp)
#		
#			
	def get_partials(self, sf_path, starttime, stoptime, tgtpeakamp, maxpartials=8, maxpeaks=20, mindur=0.1, mindb=-60, minpitch=20, maxpitch=110, max_selections_per_partial=1, quantizemidi=1):
		tgtstartframe = int(starttime/self.loaded_partial_data[self.peakdatapath]['f2s'])
		tgtstopframe = int(stoptime/self.loaded_partial_data[self.peakdatapath]['f2s'])
		
		#print("\n\nCOUNTER 1 SELECTIONS %i"%sum([1 for par in self.loaded_partial_data[self.peakdatapath]['partials'] if par['selections'] == 1]))
		valid_logic = {'too short': 0, 'too many selections': 0, 'maxpartials limit': 0, 'too soft': 0, 'too low': 0, 'too high': 0}
		valid_partials_in_time = []
		valid_partials = []
		for par in self.loaded_partial_data[self.peakdatapath]['partials']:
			if tgtstartframe > par['stopframe'] or tgtstopframe <= par['startframe']:
				continue
			start_frame_look = max(tgtstartframe, par['startframe'])
			stop_frame_look = min(tgtstopframe, par['stopframe'])
			if start_frame_look >= stop_frame_look: continue
			par['sel_slice'] = slice(start_frame_look-par['startframe'], stop_frame_look-par['startframe'])
			s = start_frame_look - par['startframe']
			e = stop_frame_look - par['startframe']
			#print(s, e, startframe, stopframe, pardict['amps'])
			par['avg_midi'] = audioguide.util.frq2Midi(np.average(par['frqs'][s:e], weights=par['amps'][s:e]))
			par['peak_db'] = audioguide.util.ampToDb(np.max(par['amps'][s:e])*tgtpeakamp)
		
			

			# this one is valid in terms of time
			valid_partials_in_time.append(par)

		print("\n\n", starttime, stoptime, len(valid_partials_in_time), [par['avg_midi'] for par in valid_partials_in_time  ])

		for par in valid_partials_in_time:
			if par['lentime'] < mindur:
				valid_logic['too short'] += 1
				continue


			if max(par['selections'][par['sel_slice']]) > max_selections_per_partial:
				valid_logic['too many selections'] += 1
				continue

			#self.par_dict_get_midi_db(par, start_frame_look, stop_frame_look, tgtpeakamp)
			#print(starttime, stoptime, par.starttime, par.stoptime, par.avg_midi, par.peak_db)
			if par['peak_db'] < mindb:
				valid_logic['too soft'] += 1
				continue
			if par['avg_midi'] < minpitch:
				valid_logic['too low'] += 1
				continue
			if par['avg_midi'] > maxpitch:
				valid_logic['too high'] += 1
				continue
			# manipulate data now
			par['avg_midi'] = audioguide.util.quantize(par['avg_midi'], quantizemidi)
			valid_partials.append(par)
		# sort partials by loudness
		valid_partials.sort(key=lambda x: x['peak_db'], reverse=True)
		if len(valid_partials) > maxpartials:
			valid_logic['maxpartials limit'] = len(valid_partials)-maxpartials
			valid_partials = valid_partials[:maxpartials]
		
		if len(valid_partials) > 0:
			print("\n\nPARTIALS - ", "%i/%i"%(len(valid_partials), len(valid_partials_in_time)))
			for v, k in  valid_logic.items():
				print('\t%.1f%% - %s'%((100*float(k))/len(valid_partials_in_time), v) )
			print("\n\n")
		
		return valid_partials



def target_find_partials(sf_path, frame_size, win_size, hop_size, starttime, stoptime, tgtpeakamp, seeksec=0, maxpartials=8, mindur=0.1, mindb=-40, max_selections_per_partial=1, quantizemidi=0, minpitch=20, maxpitch=110):
	global pd
	pd.init_partial_analysis(sf_path, os.path.join(os.path.split(__file__)[0], 'data'), frame_size, win_size, hop_size, mindb=-60, maxpeaks=20)
	pd.valid_partials = pd.get_partials(sf_path, starttime+seeksec, stoptime-seeksec, tgtpeakamp, maxpartials=maxpartials, mindur=mindur, mindb=mindb, minpitch=minpitch, maxpitch=maxpitch, max_selections_per_partial=max_selections_per_partial, quantizemidi=quantizemidi)
	return len(pd.valid_partials)
	


def searchCorpus(corpusObjs, pitchtolerance=3, dbtolerance=18, forceloudestpartial=True):
	'''shitty code alert'''
	global pd
	partial_candidates = {}
	lowest_pidx = 100000000
	for c in corpusObjs:
		partial_candidates[c] = []
		c.db = audioguide.util.ampToDb(c.desc.get('power-seg')) + c.envDb
		for pidx, p in enumerate(pd.valid_partials):
			pitchdiff = p['avg_midi'] - c.desc.get('MIDIPitch-seg')
			dbdiff = p['peak_db'] - c.db
			if np.abs(pitchdiff) > pitchtolerance: continue
			if np.abs(dbdiff) > dbtolerance: continue
			if pidx < lowest_pidx: lowest_pidx = pidx
			partial_candidates[c].append([np.abs(pitchdiff), np.abs(dbdiff), pitchdiff, dbdiff, pidx, True])

	if lowest_pidx == 100000000: return []

	if forceloudestpartial:
		for c in partial_candidates:
			for listy in partial_candidates[c]:
				if listy[4] != lowest_pidx: listy[5] = False # disable
	
	newList = []
	for c in partial_candidates:
		possibilities = [listy for listy in partial_candidates[c] if listy[5]]
		possibilities = sorted(possibilities, key = lambda x: (x[0], x[1]))  # sort by min pitch difference, then ampdiff
		if len(possibilities) == 0: continue
		win_abspitchdiff, win_abs_dbdiff, win_pitchdiff, win_dbdiff, winpidx, booly = possibilities[0]
		c.partial_data = {'pobj': pd.valid_partials[winpidx], 'pitchdiff': win_pitchdiff, 'dbdiff': win_dbdiff}
		newList.append(c)

	return newList




pd = PartialData()
