# See the 'Creating Notated Scores' section of the documentation


#discuss
#
#wholeFileMinStart
#clipDurationToTarget
#scaleDb='filenamedyn'



TARGET = tsf('cage.aiff', thresh=-36, offsetRise=1.5)

BACH_INCLUDE_TARGET = False


SEARCH_PATHS = ['/Users/ben/Documents/sfdb/']

CORPUS = [
# bowed violin sounds
csf('violin/staccato/', instrTag='violin', instrParams={'technique': 'arco', 'articulation': 'staccato', 'temporal_mode': 'artic'}, scaleDb='filenamedyn', wholeFile=True),
csf('violin/sul-ponticello/', instrTag='violin', instrParams={'technique': 'arco', 'annotation': 'SP'}, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFileMinStart=0.1, wholeFile=True),
csf('violin/sul-tasto/', instrTag='violin', instrParams={'technique': 'arco', 'annotation': 'ST'}, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFileMinStart=0.1, wholeFile=True),
csf('violin/artificial-harmonic/', instrTag='violin', instrParams={'polyphony_max_voices': 1, 'technique': 'arco', 'annotation': 'harmonic'}, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFile=True),
csf('violin/pizz/', instrTag='violin', instrParams={'temporal_mode': 'artic', 'minspeed': 0.12, 'technique': 'pizz','annotation': 'pizz', 'articulation': 'staccato'}, scaleDb='filenamedyn', wholeFile=True),


#bowed viola sounds
csf('viola/non-vibrato/', instrTag='viola', instrParams={'technique': 'arco', }, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFileMinStart=0.1, wholeFile=True),
csf('viola/sul-ponticello/', instrTag='viola', instrParams={'technique': 'arco', 'annotation': 'SP', }, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFileMinStart=0.1, wholeFile=True),
csf('viola/sul-tasto/', instrTag='viola', instrParams={'technique': 'arco', 'annotation': 'ST', }, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFileMinStart=0.1, wholeFile=True),
csf('viola/artificial-harmonic/', instrTag='viola', instrParams={'polyphony_max_voices': 1, 'technique': 'arco', 'annotation': 'harmonic'}, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFileMinStart=0.1, wholeFile=True),


#bowed cello sounds
csf('cello/staccato/', instrTag='cello', instrParams={'technique': 'arco', 'temporal_mode': 'artic', 'articulation': 'accent'}, scaleDb='filenamedyn', wholeFile=True),
csf('cello/sul-ponticello/', instrTag='cello', instrParams={'technique': 'arco', 'annotation': 'SP'}, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFileMinStart=0.1, wholeFile=True),
csf('cello/sul-tasto/', instrTag='cello', instrParams={'technique': 'arco', 'annotation': 'ST'}, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFileMinStart=0.1, wholeFile=True),
csf('cello/artificial-harmonic/', instrTag='cello', instrParams={'polyphony_max_voices': 1, 'technique': 'arco', 'annotation': 'harmonic'}, scaleDb='filenamedyn', clipDurationToTarget=True, wholeFileMinStart=0.1, wholeFile=True),
csf('cello/pizz/', instrTag='cello', instrParams={'temporal_mode': 'artic', 'minspeed': 0.12, 'technique': 'pizz','annotation': 'pizz', 'articulation': 'staccato'}, scaleDb='filenamedyn', wholeFile=True),


]


CORPUS_GLOBAL_ATTRIBUTES = {
'pitchfilter': {'pitches': [60, 69], "tolerance": 3},
}


INSTRUMENTS = score(
instr('violin', polyphony_max_voices=2, polyphony_min_range=3, polyphony_max_range=8, technique_switch_delay_map=[('pizz', 'arco', 1), ('arco', 'pizz', 0.6)]), # To Go from X to Y delay of Z sec
instr('violin', minspeed=0.08, polyphony_minspeed=0.4, polyphony_max_voices=2, polyphony_min_range=3, polyphony_max_range=8, technique_switch_delay_map=[('pizz', 'arco', 1), ('arco', 'pizz', 0.6)]), # To Go from X to Y delay of Z sec
instr('viola', clef='Alto', minspeed=0.08, polyphony_minspeed=0.4, polyphony_max_voices=2, polyphony_min_range=3, polyphony_max_range=8,),
instr('cello', clef='F', minspeed=0.08, polyphony_minspeed=0.4, polyphony_max_voices=2, polyphony_min_range=3, polyphony_max_range=8, technique_switch_delay_map=[('pizz', 'arco', 1), ('arco', 'pizz', 0.6)]),
)


SEARCH = [
spass('closest_percent', d('power-seg', norm=1), percent=30),
spass('closest', d('mfccs-seg', norm=1)),
]



#CSOUND_CHANNEL_RENDER_METHOD = 'oneChannelPerInstrument' # writes each instrument to its own channel in the output sound file.


SUPERIMPOSE = si() # don't need to worry about overlaps, as, when the instruments get filled up, selection will automatically stop. however the number of total notes selected per segment can be restricted with maxSegment=n


BACH_SLOTS_MAPPING = {1: 'fullpath', 2: 'sfskiptime', 3: 'sfchannels', 4: 'env', 5: ['mfcc1-seg', 'mfcc2-seg', 'mfcc3-seg', 'mfcc4-seg', 'mfcc5-seg', 'mfcc6-seg', 'mfcc7-seg', 'mfcc8-seg', 'mfcc9-seg', 'mfcc10-seg', 'mfcc11-seg', 'mfcc12-seg'], 10: 'cps_transposition', 11: 'cps_selectnumber', 12: 'cps_filehead', 20: 'cps_dynamic', 22: 'instr_articulation', 23: 'instr_notehead', 24: 'instr_annotation', 25: 'instr_technique', 26: 'instr_temporal_mode'}
