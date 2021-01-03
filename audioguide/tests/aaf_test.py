import os, aaf2


f = aaf2.open('/Users/ben/Desktop/test.aaf', "w")
aaf_sr = 44100

my_sf_meta = {'streams': [{'index': 0, 'codec_type': 'audio', 'sample_rate': '44100', 'channels': 1, 'duration_ts': 502892}], 'format': {'filename': '/Users/ben/Documents/audioguide/examples/cage.aiff', 'format_name': 'aiff'}}

master_mob, source_mob, tape_mob = f.content.link_external_wav(my_sf_meta)

comp_mob = f.create.CompositionMob("composition")
f.content.mobs.append(comp_mob)

for i in range(10):
	sequence = f.create.Sequence(media_kind="sound")
	sequence.components.append(f.create.Filler("sound", int(aaf_sr*0.5))) # silence
	sequence.components.append(master_mob.create_source_clip(slot_id=1, start=0, length=int(aaf_sr*0.5))) # sound

	timeline_slot = comp_mob.create_timeline_slot("%i" % aaf_sr)
	timeline_slot.name = "track %i"%i
	timeline_slot['PhysicalTrackNumber'].value = i
	timeline_slot.segment = sequence
f.close()
	




