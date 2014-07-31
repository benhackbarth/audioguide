import sys, os
sys.path.append('/Users/ben/Documents/audioGuide/0-new')
#sys.path.append('/Users/ben/Documents/audioGuide/audioguide')
sys.path.append('/Users/ben/Documents/audioGuide/0-new/pylib2.7-darwin-64')
import sdiflinkage
import sfSegment, concatenativeClasses

'''this script yields descriptor data from a soundfile.'''

# first configure sdif analizer/reader
#   the only required argument is the path to the ircamdescriptor library
import sys, os, bin_config
# we need to intialize the config object to know where the path of the sdif library is.
config = bin_config.get(1.10, os.path.dirname(__file__))
# we need to initialize the ops object to know the ircam descriptor sample rate, window size, etc...
ops = concatenativeClasses.parseOptions(defaults='/Users/ben/Documents/audioGuide/0-new/defaults.py')
SdifInterface = ops.createSdifInterface(config['bin_path']['ircamd'], pm2_bin=config['bin_path']['pm2'], supervp_bin=config['bin_path']['supervp'])



# here is the info about the sound chunk we are asking for...
soundfilename = '/Users/ben/Documents/audioGuide/examples/cage.aiff'
startSecond = 1.25
endSecond = 1.4

# Initialize the SfSegment object, which automatically obtains requested descriptors.
# Note that, the first time you ask for a particular file, the ircamdescriptor library is run.
# On subsiquent calls, since the sdif analysis is saved, it works much faster!
# You need to call this function with a pointer to the sdiflinkage.SdifInterface class
# so that the sdif analizer knows about window size, hop size, etc.
descriptors_to_load = ['power', 'noisiness', 'centroid', 'slope']
sfs = sfSegment.SfSegment(soundfilename, startSecond, endSecond, descriptors_to_load, SdifInterface)

print sfs
print '\n'
# descriptors are held in a dict in the object at sfs.desc.
# the key of dict elements is the descriptor name (a string)
# the value of each dict element is a numpy array with descriptor values
# lets look at them...
for key, val in sfs.desc.items():
	print(key, val)
