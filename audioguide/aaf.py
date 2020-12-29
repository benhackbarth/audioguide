import subprocess
import json


try:
	import aaf2
except ImportError:
	print(ImportError, "aaf2 package is not installed.")


def probe(path, show_packets=False):
    cmd = ['ffprobe', '-of','json','-show_format','-show_streams', path]
    if show_packets:
        cmd.extend(['-show_packets',])
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout,stderr = p.communicate()
    if p.returncode != 0:
        raise subprocess.CalledProcessError(p.returncode, subprocess.list2cmdline(cmd), stderr)
    return json.loads(stdout.decode('utf8'))




class output:
	def __init__(self, aaf_file, aaf_sr=44100):
		self.filepath_to_mob = {}
		self.f = aaf2.open(aaf_file, "w")
		self.aaf_sr = aaf_sr

	def addSoundfileResource(self, cpsfullpath): #, filesr, filechns, 
		meta = probe(cpsfullpath)
		print(meta)
		#a steamlined version of the probe output I've made below, only think I need the following
		#meta = {'streams': [{
#		'index': 0, 
#		'codec_type': 'audio', 
#		'sample_rate': '48000', 
#		'channels': 2, 
#		'duration_ts': 354307, # dur * sr int
#		}], 
#		'format': {
#		'filename': '/Users/ben/composition/perctrio/sf/compressed-air.wav', 
#		'format_name': 'wav', 
#		}}
		master_mob, source_mob, tape_mob = self.f.content.link_external_wav(meta)
		self.filepath_to_mob[cpsfullpath] = master_mob

	def makeTracks(self, eventlist):
		simpledata = [(int(e.timeInScore*self.aaf_sr), int((e.timeInScore+e.duration)*self.aaf_sr), int(e.sfSkip*self.aaf_sr), e.filename, e.sfchnls) for e in eventlist]
		trans_by_chns = {}
		
		# organize all selected notes into tracks with no overlapping sound segments
		for startidx, stopidx, skipidx, fullpath, chns in simpledata:
			if chns not in trans_by_chns: trans_by_chns[chns] = [[]]
			track_find_idx = 0
			while True:
				if len(trans_by_chns[chns][track_find_idx]) == 0 or trans_by_chns[chns][track_find_idx][-1][1] < startidx: break
				track_find_idx += 1
				if track_find_idx > len(trans_by_chns[chns])-1: trans_by_chns[chns].append([])
			trans_by_chns[chns][track_find_idx].append((startidx, stopidx, skipidx, fullpath))

		for chncount, tracks in trans_by_chns.items():
			for t in tracks:
				# make a track
				sequence = self.f.create.Sequence(media_kind="sound")
				idx_cnt = 0
				for e in t:
					if e[0] > idx_cnt: # add silence
						sequence.components.append(self.f.create.Filler("sound", e[0]-idx_cnt)) # silence
					# add sound clip
					sequence.components.append(self.filepath_to_mob[e[3]].create_source_clip(slot_id=1, start=e[2], length=e[1]-e[0])) # sound
					idx_cnt = e[1]


				comp_mob = self.f.create.CompositionMob("the_composition")
				self.f.content.mobs.append(comp_mob)

				timeline_slot = comp_mob.create_timeline_slot("%i" % self.aaf_sr)
				timeline_slot.name = "track_one"
				timeline_slot.segment = sequence

	def done(self):
		self.f.close()
		
		
#
#if False:
#	AAF_RATE = 100
#
#	with aaf2.open(aaf_file, "w") as f:
#		meta = probe(wav_file)
#		# a steamlined version of the probe output I've made below, only think I need the following
#		#	meta = {'streams': [{
#		#	'index': 0, 
#		#	'codec_type': 'audio', 
#		#	'sample_rate': '48000', 
#		#	'channels': 2, 
#		#	'duration_ts': 354307, # dur * sr int
#		#	}], 
#		#	'format': {
#		#	'filename': '/Users/ben/composition/perctrio/sf/compressed-air.wav', 
#		#	'format_name': 'wav', 
#		#	}}
#		print(meta)
#
#
#		master_mob, source_mob, tape_mob = f.content.link_external_wav(meta)
#
#		# make a track
#		sequence = f.create.Sequence(media_kind="sound")
#		sequence.components.append(master_mob.create_source_clip(slot_id=1, start=0*AAF_RATE, length=1*AAF_RATE)) # sound
#		sequence.components.append(f.create.Filler("sound", 1*AAF_RATE)) # silence
#		sequence.components.append(master_mob.create_source_clip(slot_id=1, start=10*AAF_RATE, length=1*AAF_RATE)) # sound
#
#
#		comp_mob = f.create.CompositionMob("the_composition")
#		f.content.mobs.append(comp_mob)
#
#		video_rate = "%i" % AAF_RATE
#		timeline_slot = comp_mob.create_timeline_slot(video_rate)
#		timeline_slot.name = "track_one"
#		timeline_slot.segment = sequence
#
