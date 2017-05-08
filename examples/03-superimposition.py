TARGET = tsf('cage.aiff', thresh=-26, offsetRise=1.5)

CORPUS = [
csf('lachenmann.aiff'),
csf('heat sink.aiff'),
]

SEARCH = [
spass('ratio_limit', d('effDur-seg', norm=1), minratio=0.9, maxratio=1.1),
spass('closest', d('mfccs'))
]


################################################################################
## When AudioGuide begins a concatenation, the target soundfile is broken     ##
## into several sound segments and then the software steps through them one   ##
## by one, selecting corpus sounds to match them.  si() controls how many     ##
## corpus sounds AudioGuide is permitted to select for each target sound      ##
## segment.  si() uses keyword arguments to do this.  They are as follows:    ##
################################################################################

#### minSegment, maxSegment - tell Ag how many corpus segments to pick for each target segment.  by default the minimum is 1; there is no maximum and Ag will stop picking corpus segments according to a subtractive amplitude model.

#### minOnset, maxOnset - tell Ag how many corpus segments to pick for each analysis frame of each target segment.  frame speed is taken from DESCRIPTOR_HOP_SIZE_SEC, by default 0.01024 seconds.  by default there is no minimum or maximum and Ag will pick / not pick corpus segments according to a subtractive amplitude model.

#### minOverlap, maxOverlap - tell Ag how many corpus segments must be playing during each target frame.  unlike minSegment/maxSegment/minOnset/maxOnset, overlap takes corpus sounds' duration into account.  by default there is no minimum or maximum.



################################################################################
## The following examples demonstrate different ways of defining corpus       ##
## superimposition.  Uncomment one and then run AudioGuide to hear the        ##
## result.  Remember that you may only have one si() object.                  ##
################################################################################

SUPERIMPOSE = si(maxSegment=1) # ag is restricted to picking 1 corpus sound per target segment.

#SUPERIMPOSE = si(maxSegment=4) # ag will pick between 1-4 corpus sounds for each target segment depending on the amplitude of the target and corpus segments.

#SUPERIMPOSE = si(minSegment=4, maxSegment=8) # ag will pick betwwen 4-8 corpus sounds for each target segment depending on the amplitude of the target and corpus segments.  the concatenative algrithms will be forced to pick a 4th sound every segment (due to minSegment) even if one isn't "needed" according to the subtractive amplitude model.

#SUPERIMPOSE = si(maxOnset=1) # ag is restricted to picking one corpus sound for each frame of a target segment.  this limits the number of sounds that may be selected at any single moment to 1.

#SUPERIMPOSE = si(minOnset=2, maxOnset=4) # ag must pick between 2-4 corpus sounds for each frame of each target segment.  every frame must include two new corpus sounds up to a maximum of four.  this will result in a lot of segments!

#SUPERIMPOSE = si(minOnset=4, maxSegment=4) # ag will pick 4 sounds in the first frame, then nothing for the rest of each target segments' duration.  like a temporally aligned "chord" of four elements.  due to the internal superimposition logic, minSegment/maxSegment always overrides minOnset/maxOnset.

#SUPERIMPOSE = si(maxOverlap=4) # ag is restricted to picking corpus sounds such that a maximum of 4 may be overlapping at any given target frame.

