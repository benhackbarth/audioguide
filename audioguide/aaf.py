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
	
	
	def makeCpsTracks(self, eventlist, vcToCorpusName, aaf_track_method):
		grand_old_dict = {}
		for e in eventlist:
			if aaf_track_method == 'cpsidx': 
				sortkey = (e.voiceID, e.sfchnls)
				trackname = "%s %ich"%(util.cpsPathToTrackName(vcToCorpusName[e.voiceID]), e.sfchnls)
			elif aaf_track_method == 'minimum':
				sortkey = (e.sfchnls)
				trackname = "cps %ich"%(e.sfchnls)
			if not sortkey in grand_old_dict: grand_old_dict[sortkey] = [trackname, []]
			grand_old_dict[sortkey][1].append((e.powerSeg, int(e.timeInScore*self.aaf_sr), int((e.timeInScore+e.duration)*self.aaf_sr), int(e.sfSkip*self.aaf_sr), e.filename))

		ordering = list(grand_old_dict.keys())
		ordering.sort()

		for sortkey in ordering:
			track_assign = {}
			grand_old_dict[sortkey][1].sort(reverse=True) # loudest sounds first
			for power, startidx, stopidx, skipidx, fullpath in grand_old_dict[sortkey][1]:
				tidx = 0
				while True:
					if tidx not in track_assign: track_assign[tidx] = []
					if True in [startidx <= stop and start <= stopidx for start, stop, skip, fpath in track_assign[tidx]]: tidx += 1
					else: break
				track_assign[tidx].append((startidx, stopidx, skipidx, fullpath))

			track_assign = [(k, v) for k, v in track_assign.items()]
			track_assign.sort()
			for tidx, t in track_assign:
				# make a track
				sequence = self.f.create.Sequence(media_kind="sound")
				idx_cnt = 0
				for e in sorted(t, key=lambda x: x[0]):
					if e[0] > idx_cnt: # add silence
						sequence.components.append(self.f.create.Filler("sound", e[0]-idx_cnt)) # silence
					# add sound clip
					sequence.components.append(self.filepath_to_mob[e[3]].create_source_clip(slot_id=1, start=e[2], length=e[1]-e[0])) # sound
					idx_cnt = e[1]
				self._add_track(sequence, grand_old_dict[sortkey][0])



	def done(self, verbose=True):
		'''close the aaf file'''
		self.f.close()
		if verbose and self.trackcnt['tgt'] == 0:
			print("Wrote %i corpus tracks to the AAF output"%(self.trackcnt['cps']))
		elif verbose:
			print("Wrote target track and %i corpus tracks to the AAF output"%(self.trackcnt['cps']))
	




