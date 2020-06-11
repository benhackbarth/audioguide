#AudioGuide

AudioGuide is a program for concatenative synthesis developed by Ben Hackbarth, Norbert Schnell, Philippe Esling, and Diemo Schwarz.  It is written in python, however, do not need to know python to use AudioGuide - the user supplies simple options files that are written in python's syntax to interact with the program.

AudioGuide should run out-of-the box on any recent OS X with python2 or python3.  The python module numpy is required, but comes preinstalled on most newer versions of python.  If you want to have AudioGuide automatically render concatenations, you need csound6 installed as well.

AudioGuide differs from other programs for concatenative synthesis in several notable ways:

* AudioGuide is not realtime and therefore sounds can be layered much more densely compared to realtime concatenation.  Non-realtime analysis also permits more flexible and creative mapping between target and corpus descriptors as well as algorithmic accounting for overlapping corpus sounds in descriptor calculations.  More info about how to control the superimposition of sounds is [here](http://www.benhackbarth.com/audioGuide/docs_v1.35.html#TheSUPERIMPOSEvariabls).

* AudioGuide gives a large number of controls for fine tuning what sounds are included in the corpus, permitting the user to include and exclude segments according to descriptor values, filenames, restricting segment repetition, scaling amplitude, etc.  See all of the options [here](http://www.benhackbarth.com/audioGuide/docs_v1.35.html#TheCORPUSVariable).

* AudioGuide aims to give maximum creative control over how the sounds of the corpus are mapped onto the target.  Many different configurations for [normalizing corpus and target data](http://www.benhackbarth.com/audioGuide/docs_v1.35.html#Normalization) give the user a higher degree of control over the results and permit creative flexibility in defining similarity.

* Similarity between target and corpus sounds can be evaluated using time-varying descriptors, thus giving a better sense of the temporal morphology of sounds.  A full list of available descriptors is [here](http://www.benhackbarth.com/audioGuide/docs_v1.35.html#Appendix1Descriptors).

* AudioGuide has a robust and flexible system for defining how corpus samples are matched to target segments.  One may find the best match according to a single descriptor, but one may also define multiple search "passes", effectively creating a hierarchical search routine.  One may also create boolean tests within the search function to further nuance the search process.  See [here](http://www.benhackbarth.com/audioGuide/docs_v1.35.html#SEARCHvariable).

* By default AudioGuide creates a csound score that is automatically rendered at the end of the concatenative process.  However the program is also capable of creating a json output, which can be played in Max (patch provided in the distro), textfile output as well as midi output.





