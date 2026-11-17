################################################################
## Note that this is experimental, untested, and undocumented ##
################################################################

TARGET = tsf('cage.aiff', partials={
'frame_size': 4096,
'win_size': 4096,
'hop_size': 1024,
'partial_min_duration': 0.05,
'partial_limit_midi': (20, 110),
'partial_limit_db': (-60, 0),
'partial_max_overlaps': 20,
'partial_resynthsis_file': '/Users/ben/Desktop/p.wav', # None or filepath
})


CORPUS = [
csf('/Users/ben/Documents/sfdb/pno/long/', wholeFile=True),
]



SEARCH = [
spass('target_partial_filter', pitchtolerance=4, dbtolerance=12), 
spass('closest', d('mfccs-seg')),
]



SUPERIMPOSE = si(maxSegment=12, calcMethod=None) 