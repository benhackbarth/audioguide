############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################
import os
import audioguide.util as util


try:
	import aaf2
except ImportError:
	util.missing_module('aaf2')



'''Creates an aaf output file for logic / pro tools.'''

class output:
	def __init__(self, aaf_filepath, aaf_sr=44100):
		self.f = aaf2.open(aaf_filepath, "w")
		self.aaf_sr = aaf_sr
		self.filepath_to_mob = {}
		self.cnt = 0

	def _add_track(self, seq, name):
		comp_mob = self.f.create.CompositionMob("track %i"%self.cnt)
		self.f.content.mobs.append(comp_mob)
		timeline_slot = comp_mob.create_timeline_slot("%i" % self.aaf_sr)
		timeline_slot.name = name
		timeline_slot.segment = seq	
		self.cnt += 1
		
	def addSoundfileResource(self, cpsfullpath, infodict):
		'''each target/corpus soundfile used in the concatenation must be passed to this function to register the filepath, sr, format, duration, etc'''
		sf_format = os.path.splitext(cpsfullpath)[1][1:].lower()
		if sf_format == 'aif': sf_format = 'aiff'
		meta = {'streams': [{'index': 0, 'codec_type': 'audio', 'sample_rate': '%i'%(infodict['sr']), 'channels': infodict['channels'], 'duration_ts': infodict['lengthsamples']}], 'format': {'filename': cpsfullpath, 'format_name': sf_format}}
		master_mob, source_mob, tape_mob = self.f.content.link_external_wav(meta)
		self.filepath_to_mob[cpsfullpath] = master_mob


	def makeTgtTrack(self, tgtobj):
		sequence = self.f.create.Sequence(media_kind="sound")
		sequence.components.append(self.filepath_to_mob[tgtobj.filename].create_source_clip(slot_id=1, start=int(tgtobj.startSec*self.aaf_sr), length=int((tgtobj.endSec-tgtobj.startSec)*self.aaf_sr))) # sound
		self._add_track(sequence, 'target')
	
	
	def makeCpsTracks(self, eventlist, vcToCorpusName):
		grand_old_dict = {}
		for e in eventlist:
			if e.voiceID not in grand_old_dict: grand_old_dict[e.voiceID] = {}
			if e.sfchnls not in grand_old_dict[e.voiceID]: grand_old_dict[e.voiceID][e.sfchnls] = []
			grand_old_dict[e.voiceID][e.sfchnls].append((int(e.timeInScore*self.aaf_sr), int((e.timeInScore+e.duration)*self.aaf_sr), int(e.sfSkip*self.aaf_sr), e.filename))
		# organize all selected notes into tracks with no overlapping sound segments and with unique channel counts
		all_tracks = []
		for voice in grand_old_dict:
			track_string = util.cpsPathToTrackName(vcToCorpusName[voice])
			for chn_cnout in grand_old_dict[voice]:
				tracks = [[]]
				for startidx, stopidx, skipidx, fullpath in grand_old_dict[voice][chn_cnout]:
					track_find_idx = 0
					while True:
						if len(tracks[track_find_idx]) == 0 or tracks[track_find_idx][-1][1] < startidx: break
						track_find_idx += 1
						if track_find_idx > len(tracks)-1: tracks.append([])
					tracks[track_find_idx].append((startidx, stopidx, skipidx, fullpath))
				all_tracks.append(("%s %ich"%(track_string, chn_cnout), tracks))

		for trackstring, tracks in all_tracks:
			for tidx, t in enumerate(tracks):
				# make a track
				sequence = self.f.create.Sequence(media_kind="sound")
				idx_cnt = 0
				for e in t:
					if e[0] > idx_cnt: # add silence
						sequence.components.append(self.f.create.Filler("sound", e[0]-idx_cnt)) # silence
					# add sound clip
					sequence.components.append(self.filepath_to_mob[e[3]].create_source_clip(slot_id=1, start=e[2], length=e[1]-e[0])) # sound
					idx_cnt = e[1]
				self._add_track(sequence, trackstring)


	def done(self):
		'''close the aaf file'''
		self.f.close()
	




