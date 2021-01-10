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
		self.path = aaf_filepath
		self.f = aaf2.open(self.path, "w")
		self.aaf_sr = aaf_sr
		self.filepath_to_mob = {}
		self.trackcnt = {'tgt': 0, 'cps': 0}
		self.alltrackcnt = 0
		self.comp_mob = self.f.create.CompositionMob("Composition")
		self.f.content.mobs.append(self.comp_mob)


	def _add_track(self, seq, name, type='cps'):
		timeline_slot = self.comp_mob.create_timeline_slot("%i" % self.aaf_sr)
		timeline_slot['PhysicalTrackNumber'].value = self.alltrackcnt
		timeline_slot.name = name
		timeline_slot.segment = seq	
		self.trackcnt[type] += 1
		self.alltrackcnt += 1
		
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
		self._add_track(sequence, 'target', type='tgt')
	
	
	def makeCpsTracks(self, sorted_cps_tracks):
		for trackname, trackeventdicts, tracksource in sorted_cps_tracks:
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
			self._add_track(sequence, trackname)


	def done(self, autolaunchbool, verbose=True):
		'''close the aaf file'''
		self.f.close()
		if verbose and self.trackcnt['tgt'] == 0:
			print("Wrote %i corpus tracks to the AAF output"%(self.trackcnt['cps']))
		elif verbose:
			print("Wrote target track and %i corpus tracks to the AAF output"%(self.trackcnt['cps']))
	
		if autolaunchbool:
			import subprocess
			command = ['open', self.path]
			try:
				p = subprocess.Popen(command)
			except OSError:
				print('commandline', 'Command line call failed: \n\n"%s"'%' '.join(command))


