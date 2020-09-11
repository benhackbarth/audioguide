TARGET = tsf('/Users/ben/Desktop/video/target.wav', thresh=-20, offsetRise=1.25)


SEARCH_PATHS = ['/Users/ben/Documents/sfdb/']

CORPUS = [
# bowed violin sounds
csf('violin/staccato/', instrTag='violin', instrParams={'technique': 'arco', 'articulation': 'staccato', 'temporal_mode': 'artic'}, scaleDb='filenamedyn'),
csf('violin/sul-ponticello/', instrTag='violin', instrParams={'technique': 'arco', 'annotation': 'SP'}, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('violin/sul-tasto/', instrTag='violin', instrParams={'technique': 'arco', 'annotation': 'ST'}, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('violin/artificial-harmonic/', instrTag='violin', instrParams={'polyphony_max_voices': 1, 'technique': 'arco', 'annotation': 'harmonic'}, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('violin/pizz/', instrTag='violin', instrParams={'temporal_mode': 'artic', 'minspeed': 0.12, 'technique': 'pizz','annotation': 'pizz'}, scaleDb='filenamedyn'),


#bowed viola sounds
csf('viola/non-vibrato/', instrTag='viola', instrParams={'technique': 'arco', }, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('viola/sul-ponticello/', instrTag='viola', instrParams={'technique': 'arco', 'annotation': 'SP', }, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('viola/sul-tasto/', instrTag='viola', instrParams={'technique': 'arco', 'annotation': 'ST', }, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('viola/artificial-harmonic/', instrTag='viola', instrParams={'polyphony_max_voices': 1, 'technique': 'arco', 'annotation': 'harmonic'}, scaleDb='filenamedyn', clipDurationToTarget=True),


#bowed cello sounds
csf('cello/staccato/', instrTag='cello', instrParams={'technique': 'arco', 'temporal_mode': 'artic', 'articulation': 'accent'}, scaleDb='filenamedyn'),
csf('cello/sul-ponticello/', instrTag='cello', instrParams={'technique': 'arco', 'annotation': 'SP'}, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('cello/sul-tasto/', instrTag='cello', instrParams={'technique': 'arco', 'annotation': 'ST'}, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('cello/artificial-harmonic/', instrTag='cello', instrParams={'polyphony_max_voices': 1, 'technique': 'arco', 'annotation': 'harmonic'}, scaleDb='filenamedyn', clipDurationToTarget=True),
csf('cello/pizz/', instrTag='cello', instrParams={'temporal_mode': 'artic', 'minspeed': 0.12, 'technique': 'pizz','annotation': 'pizz'}, scaleDb='filenamedyn'),


# piano
csf('pno/long/', instrTag='piano', instrParams={'temporal_mode': 'sus', 'technique': 'ord'}, scaleDb=-10, transMethod='random -1 1', transQuantize=1, clipDurationToTarget=True),
]


CORPUS_GLOBAL_ATTRIBUTES = {
'wholeFile': True,
}


INSTRUMENTS = score(
instr('violin', polyphony_max_voices=2, polyphony_min_range=3, polyphony_max_range=8, technique_switch_delay_map=[('pizz', 'arco', 0.4), ('arco', 'pizz', 0.6)]), # To Go from X to Y delay of Z sec
instr('violin', minspeed=0.08, polyphony_minspeed=0.4, polyphony_max_voices=2, polyphony_min_range=3, polyphony_max_range=8, technique_switch_delay_map=[('pizz', 'arco', 0.4), ('arco', 'pizz', 0.6)]), # To Go from X to Y delay of Z sec
instr('viola', clef='A', minspeed=0.08, polyphony_minspeed=0.4, polyphony_max_voices=2, polyphony_min_range=3, polyphony_max_range=8,),
instr('cello', clef='F', minspeed=0.08, polyphony_minspeed=0.4, polyphony_max_voices=2, polyphony_min_range=3, polyphony_max_range=8, technique_switch_delay_map=[('pizz', 'arco', 0.4), ('arco', 'pizz', 0.6)]),

instr('piano', clef='FG', temporal_mode='artic', polyphony_max_voices=8, polyphony_min_range=6, polyphony_max_range=18),

)


SEARCH = [
spass('closest_percent', d('power-seg', norm=1), percent=10),
spass('closest', d('mfccs-seg', norm=1)),
]



#CSOUND_CHANNEL_RENDER_METHOD = 'oneChannelPerInstrument' # writes each instrument to its own channel in the output sound file.


SUPERIMPOSE = si() # don't need to worry about overlaps, as, when the instruments get filled up, selection will automatically stop. however the number of total notes selected per segment can be restricted with maxSegment=n


