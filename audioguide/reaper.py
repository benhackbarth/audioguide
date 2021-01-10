############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################
import os
import audioguide.util as util


'''Creates a rpp output file for reaper.'''

class output:
	def __init__(self, rpp_filepath):
		self.path = rpp_filepath
		self.tracks = []


	def makeTgtTrack(self, tgtobj):
		self.tracks.append(['target', [{"file": tgtobj.filename, 'name': tgtobj.whole.printName, 'time': 0, "skip": tgtobj.startSec, "duration": tgtobj.endSec-tgtobj.startSec, "ampscale": util.dbToAmp(tgtobj.envDb), "fadein": tgtobj.whole.envAttackSec, 'fadeout': tgtobj.whole.envDecaySec, 'transposition': 0}], 'tgt'])
	
	def makeCpsTracks(self, eventlist, vcToCorpusName, rpp_track_method):
		grand_old_dict = {}
		for e in eventlist:
			if rpp_track_method == 'cpsidx': 
				sortkey = (e.voiceID, e.sfchnls)
				trackname = "%s %ich"%(util.cpsPathToTrackName(vcToCorpusName[e.voiceID]), e.sfchnls)
			elif rpp_track_method == 'minimum':
				sortkey = (e.sfchnls)
				trackname = "cps %ich"%(e.sfchnls)
			if not sortkey in grand_old_dict: grand_old_dict[sortkey] = [trackname, []]
			grand_old_dict[sortkey][1].append({'file': e.filename, 'name': e.printName, 'time': e.timeInScore, 'stop': e.timeInScore+e.duration, "skip": e.sfSkip, "duration": e.duration, "amp": e.powerSeg, "ampscale": util.dbToAmp(e.envDb), "fadein": e.envAttackSec, 'fadeout': e.envDecaySec, 'transposition': e.transposition})
		ordering = list(grand_old_dict.keys())
		ordering.sort()

		for sortkey in ordering:
			track_assign = {}
			sorteddicts = sorted(grand_old_dict[sortkey][1], key=lambda k: k['amp'], reverse=True) # loudest sounds first

			for segmentdict in sorteddicts:
				tidx = 0
				while True:
					if tidx not in track_assign: track_assign[tidx] = []
					if True in [segmentdict['time'] <= dicty['stop'] and dicty['time'] <= segmentdict['stop'] for dicty in track_assign[tidx]]: tidx += 1
					else: break
				track_assign[tidx].append(segmentdict)
			track_assign = [(k, v) for k, v in track_assign.items()]
			track_assign.sort()
			for tidx, t in track_assign: self.tracks.append([grand_old_dict[sortkey][0], t, 'cps'])

	def write(self, autolaunchbool, verbose=True, rpp_header='REAPER_PROJECT 0.1 "6.11/x64" 1591355987'):
		'''write and close the rpp file
		according to https://github.com/ReaTeam/Doc/blob/master/State%20Chunk%20Definitions'''
		f = open(self.path, "w")
		all_tracks_str = ''
		for trackname, trackitems, trackorigin in self.tracks:
			track_str = ''
			for d in trackitems:
				track_str += '''     <ITEM 
      POSITION  %f
      NAME %s
      LENGTH %f
      COLOR 22278759
      SOFFS %f
      VOLPAN %f 0.0 %f -1.0 
      FADEIN 1 %f 0.0
      FADEOUT 1 %f 0.0
      PLAYRATE 1.000 1 %f -1
      <SOURCE WAVE
        FILE "%s"
      >
     >
'''%(d['time'], d['name'], d['duration'], d['skip'], d['ampscale'], d['ampscale'], d['fadein'], d['fadeout'], d['transposition'], d['file'])
			all_tracks_str += '''  <TRACK 
   NAME "%s"
%s  >
'''%(trackname, track_str)
		f.write('''<%s
%s>'''%(rpp_header, all_tracks_str))
		f.close()

		if verbose and 'tgt' not in [t[2] for t in self.tracks]:
			print("Wrote %i corpus tracks to the RPP reaper output"%(len(self.tracks)))
		elif verbose:
			print("Wrote target track and %i corpus tracks to the RPP reaper output"%(len(self.tracks)-1))
	
		if autolaunchbool:
			import subprocess
			command = ['open', self.path]
			try:
				p = subprocess.Popen(command)
			except OSError:
				print('commandline', 'Command line call failed: \n\n"%s"'%' '.join(command))
