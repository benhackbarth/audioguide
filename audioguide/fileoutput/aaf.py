############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################
import os
import audioguide.util as util

'''Creates an aaf output file for logic / pro tools.'''

try:
	import aaf2
except ImportError:
	util.missing_module('pyaaf2')

class output:
	def __init__(self, aaf_filepath, aaf_sr=44100):
		self.path = aaf_filepath
		self.f = aaf2.open(self.path, "w")
		self.aaf_sr = aaf_sr
		self.filepath_to_mob = {}
		self.alltrackcnt = 0
		self.tracknames = []
		self.comp_mob = self.f.create.CompositionMob("Composition")
		self.f.content.mobs.append(self.comp_mob)
	###########################################
	def addSoundfileResource(self, cpsfullpath, infodict):
		'''each target/corpus soundfile used in the concatenation must be passed to this function to register the filepath, sr, format, duration, etc'''
		sf_format = os.path.splitext(cpsfullpath)[1][1:].lower()
		if sf_format == 'aif': sf_format = 'aiff'
		meta = {'streams': [{'index': 0, 'codec_type': 'audio', 'sample_rate': '%i'%(infodict['sr']), 'channels': infodict['channels'], 'duration_ts': infodict['lengthsamples']}], 'format': {'filename': cpsfullpath, 'format_name': sf_format}}
		master_mob, source_mob, tape_mob = self.f.content.link_external_wav(meta)
		self.filepath_to_mob[cpsfullpath] = master_mob
	###########################################
	def add_tracks(self, sorted_tracks):
		for trackname, trackeventdicts, tracksource in sorted_tracks:
			# make a track
			sequence = self.f.create.Sequence(media_kind="sound")
			idx_cnt = 0
			for d in sorted(trackeventdicts, key=lambda x: x['time']):
				timesr = int(d['time']*self.aaf_sr)
				stopsr = int(d['stop']*self.aaf_sr)
				durationsr = int(d['duration']*self.aaf_sr)
				skipsr = int(d['skip']*self.aaf_sr)
				if timesr > idx_cnt: # add silence
					sequence.components.append(self.f.create.Filler("sound", timesr-idx_cnt)) # silence
				# add sound clip
				sequence.components.append(self.filepath_to_mob[d['file']].create_source_clip(slot_id=1, start=skipsr, length=durationsr)) # sound
				idx_cnt = stopsr
			timeline_slot = self.comp_mob.create_timeline_slot("%i" % self.aaf_sr)
			timeline_slot['PhysicalTrackNumber'].value = self.alltrackcnt
			timeline_slot.name = trackname
			timeline_slot.segment = sequence
			self.alltrackcnt += 1
			self.tracknames.append(trackname)
	###########################################
	def done(self, autolaunchbool, verbose=True):
		'''close the aaf file'''
		self.f.close()
		tgt_track_count = len([tn for tn in self.tracknames if tn == 'target'])
		if verbose and tgt_track_count == 0:
			print("Wrote %i corpus tracks to %s"%(self.alltrackcnt, self.path))
		elif verbose:
			print("Wrote %i target tracks and %i corpus tracks to %s"%(tgt_track_count, self.alltrackcnt-tgt_track_count, self.path))
	
		if autolaunchbool:
			import subprocess
			command = ['open', self.path]
			try:
				p = subprocess.Popen(command)
			except OSError:
				print('commandline', 'Command line call failed: \n\n"%s"'%' '.join(command))


