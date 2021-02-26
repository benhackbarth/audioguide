################################################################
## Note that this is experimental, untested, and undocumented ##
################################################################

################################################################################
## NOTE You must install librosa and scipy for the following example to work. ##
## Depending on which version of Python you're using, either run:             ##
## python2 -m pip install --user librosa scipy                                ##
## or                                                                         ##
## python3 -m pip install --user librosa scipy                                ##
##                                                                            ##
## ALSO NOTE: as of 20/1/2020 (Biden day), some users have had problems       ##
## installing librosa on osx. Many are having a problem with pip & llvmlite   ##
## and have needed to downgrade to python3.6 until it the issue is resolved.  ##
## Check out this thread for the deets:                                       ##
## https://github.com/librosa/librosa/issues/1270                             ##
################################################################################


TARGET = tsf('cage.aiff', partials={
'frame_size': 4096,
'win_size': 4096,
'hop_size': 1024,
'partial_min_duration': 0.05,
'partial_limit_midi': (20, 110),
'partial_limit_db': (-60, 0),
'partial_max_overlaps': 20,
'partial_resynthsis_file': '/Users/ben/Desktop/partials/p.wav', # None or filepath
})


CORPUS = [
csf('/Users/ben/Documents/sfdb/pno/long/', wholeFile=True),
]



SEARCH = [
spass('target_partial_filter', pitchtolerance=4, dbtolerance=12), 
spass('closest', d('mfccs-seg')),
]



SUPERIMPOSE = si(maxSegment=4, calcMethod=None) 