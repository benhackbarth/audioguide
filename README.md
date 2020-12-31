#AudioGuide

AudioGuide is a program for concatenative synthesis developed by Ben Hackbarth, Norbert Schnell, Philippe Esling, and Diemo Schwarz.  It is written in python, however, do not need to know python to use AudioGuide - the user supplies simple options files that are written in python's syntax to interact with the program.

AudioGuide differs from other programs for concatenative synthesis in several notable ways:

* AudioGuide is not realtime and therefore sounds can be layered much more densely compared to realtime concatenation.  Non-realtime analysis also permits more flexible and creative mapping between target and corpus descriptors as well as algorithmic accounting for overlapping corpus sounds in descriptor calculations.  More info about how to control the superimposition of sounds is [here](https://www.youtube.com/watch?v=V3MgfbaDi9I&t=288s).


* AudioGuide gives a large number of controls for fine tuning what sounds are included in the corpus, permitting the user to include and exclude segments according to descriptor values, filenames, restricting segment repetition, scaling amplitude, etc.  See all of the options [here](http://www.benhackbarth.com/audioGuide/docs_v1.35.html#TheCORPUSVariable).

* AudioGuide aims to give maximum creative control over how the sounds of the corpus are mapped onto the target.  Many different configurations for [normalizing corpus and target data](https://www.youtube.com/watch?v=UYElwMFF6Ug&t=17m46s) give the user a higher degree of control over the results and permit creative flexibility in defining similarity.

* Similarity between target and corpus sounds can be evaluated using time-varying descriptors, thus giving a better sense of the temporal morphology of sounds.  Watch [this](https://www.youtube.com/watch?v=UYElwMFF6Ug&t=217s).

* AudioGuide has a robust and flexible system for defining how corpus samples are matched to target segments. One may find the best match according to list of descriptors, but one may also define multiple search "passes", effectively creating a hierarchical search routine.  One may also create boolean tests within the search function to further nuance the search process.  See [here](https://www.youtube.com/watch?v=UYElwMFF6Ug&t=1535s).

* AudioGuide can create a variety of different output files:
    * a csound score that is automatically rendered at the end of the concatenative process
    * an .aaf file you can import into Logic/Pro Tools
    * a file you can load into bach.roll in Max/MSP
    * a json file you can use in Max/MSP (or somewhere else)

