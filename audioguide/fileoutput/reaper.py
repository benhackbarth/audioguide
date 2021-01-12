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
	###########################################
	def add_tracks(self, tracks):
		self.tracks.extend(tracks)
	###########################################
	def write(self, autolaunchbool, verbose=True, rpp_header='REAPER_PROJECT 0.1 "6.11/x64" 1591355987'):
		'''write and close the rpp file
		according to https://github.com/ReaTeam/Doc/blob/master/State%20Chunk%20Definitions'''
		f = open(self.path, "w")
		all_tracks_str = ''
		for trackname, trackitems, trackorigin in self.tracks:
			track_str = ''
			for d in trackitems:
				track_str += '''     <ITEM\n      POSITION  %f\n      NAME %s\n      LENGTH %f\n      SOFFS %f\n      VOLPAN %f 0.0 %f -1.0 \n      FADEIN 1 %f 0.0\n      FADEOUT 1 %f 0.0\n      PLAYRATE 1.000 1 %f -1\n      <SOURCE WAVE\n        FILE "%s"\n      >\n     >\n'''%(d['time'], d['name'], d['duration'], d['skip'], d['ampscale'], d['ampscale'], d['fadein'], d['fadeout'], d['transposition'], d['file'])
			all_tracks_str += '''  <TRACK\n   NAME "%s"\n%s  >\n'''%(trackname, track_str)
		f.write('''<%s\n%s>'''%(rpp_header, all_tracks_str))
		f.close()
		# print
		tgt_track_count = len([t for t in self.tracks if t[0].find('target') != -1])
		if verbose and tgt_track_count == 0:
			print("Wrote %i corpus tracks to %s"%(len(self.tracks), self.path))
		elif verbose:
			print("Wrote %i target tracks and %i corpus tracks to %s"%(tgt_track_count, len(self.tracks)-tgt_track_count, self.path))
		# autolaunch?
		if autolaunchbool:
			import subprocess
			command = ['open', self.path]
			try:
				p = subprocess.Popen(command)
			except OSError:
				print('Auto launch command line call failed: \n\n"%s"'%' '.join(command))