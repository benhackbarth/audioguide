####################################################################
## see explanation in https://www.youtube.com/watch?v=pSf3GJEGzcU ##
####################################################################


TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)


SEARCH_PATHS = ['/Users/ben/Documents/sfdb/'] # you'll need to use your own samples 8)
CORPUS = [
# bowed violin sounds
csf('violin/staccato/', instrTag='violin', instrParams={'technique': 'arco', 'articulation': 'accent'}, scaleDb='filenamedyn'),
csf('violin/sul-ponticello/', instrTag='violin', instrParams={'technique': 'arco', 'annotation': 'SP', 'articulation': 'accent'}, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('violin/sul-tasto/', instrTag='violin', instrParams={'technique': 'arco', 'annotation': 'ST', 'articulation': 'accent'}, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('violin/artificial-harmonic/', instrTag='violin', instrParams={'polyphony_max_voices': 1, 'technique': 'arco', 'annotation': 'harm'}, scaleDb='filenamedyn', clipDurationToTarget=True),
# pizz
csf('violin/pizz/', instrTag='violin', instrParams={'temporal_mode': 'artic', 'minspeed': 1/6., 'technique': 'pizz','annotation': 'pizz'}, scaleDb='filenamedyn'),


# bowed viola sounds
csf('viola/non-vibrato/', instrTag='viola', instrParams={'technique': 'arco', }, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('viola/sul-ponticello/', instrTag='viola', instrParams={'technique': 'arco', 'annotation': 'SP', }, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('viola/sul-tasto/', instrTag='viola', instrParams={'technique': 'arco', 'annotation': 'ST', }, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('viola/artificial-harmonic/', instrTag='viola', instrParams={'polyphony_max_voices': 1, 'technique': 'arco', 'annotation': 'harm'}, scaleDb='filenamedyn', clipDurationToTarget=True),



#bowed cello sounds
csf('cello/staccato/', instrTag='cello', instrParams={'technique': 'arco', }, scaleDb='filenamedyn'),
csf('cello/sul-ponticello/', instrTag='cello', instrParams={'technique': 'arco', 'annotation': 'SP', }, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('cello/sul-tasto/', instrTag='cello', instrParams={'technique': 'arco', 'annotation': 'ST', }, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('cello/artificial-harmonic/', instrTag='cello', instrParams={'polyphony_max_voices': 1, 'technique': 'arco', 'annotation': 'harm'}, scaleDb='filenamedyn', clipDurationToTarget=True),
# pizz
csf('cello/pizz/', instrTag='cello', instrParams={'temporal_mode': 'artic', 'minspeed': 1/6., 'technique': 'pizz','annotation': 'pizz'}, scaleDb='filenamedyn'),


# piano
csf('pno/long/', instrTag='piano', instrParams={'temporal_mode': 'sus', 'technique': 'ord'}, scaleDb=-10, transMethod='random -1 1', transQuantize=1, clipDurationToTarget=True),
csf('pno/short/', instrTag='piano', instrParams={'temporal_mode': 'artic', 'technique': 'ord'}, scaleDb=-10, transMethod='random -1 1', transQuantize=1),
]


CORPUS_GLOBAL_ATTRIBUTES = {
'wholeFile': True,
}



INSTRUMENTS = score(
instr('violin', polyphony_max_voices=2, polyphony_limit_range={'MIDIPitch': (3, 12), 'power': (0.0, 0.05)}, technique_switch_delay_map=[('pizz', 'arco', 0.6), ('arco', 'pizz', 0.4)]), # can go from X to Y if with a pause of Z sec
instr('violin', polyphony_max_voices=2, polyphony_limit_range={'MIDIPitch': (3, 12), 'power': (0.0, 0.05)}, technique_switch_delay_map=[('pizz', 'arco', 0.6), ('arco', 'pizz', 0.4)]),
instr('viola', clef='A', polyphony_max_voices=2, polyphony_limit_range={'MIDIPitch': (3, 12), 'power': (0.0, 0.05)}, technique_switch_delay_map=[('pizz', 'arco', 0.6), ('arco', 'pizz', 0.4)]),
instr('cello', clef='F', polyphony_max_voices=2, polyphony_limit_range={'MIDIPitch': (3, 12), 'power': (0.0, 0.05)}, technique_switch_delay_map=[('pizz', 'arco', 0.6), ('arco', 'pizz', 0.4)]),

instr('piano', clef='FG', temporal_mode='artic', polyphony_max_voices=8, polyphony_limit_range={'MIDIPitch': (4, 18), 'power': (0.0, 0.05)}, technique_switch_delay_map=[('ord', 'muted', 1), ('muted', 'ord', 0.75)]),

)


SEARCH = [
spass('closest_percent', d('power-seg', norm=1), percent=10),
spass('closest', d('mfccs-seg')),
]

SUPERIMPOSE = si() # don't need to worry about overlaps as much since, when the instruments get filled up, selection will automatically stop. however the number of total notes selected per segment can be restricted with maxSegment=n

CSOUND_CHANNEL_RENDER_METHOD = 'oneChannelPerInstrument' # writes each instrument to its own channel in the output sound file.

