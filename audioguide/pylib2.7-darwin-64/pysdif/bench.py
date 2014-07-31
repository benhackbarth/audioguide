from _pysdif import *

def bench_read_sdif1(filename):
    sdif_file = SdifFile(filename)
    while sdif_file.read_frame_header():
        for n in xrange(sdif_file.matrices_in_frame):
            sdif_file.get_matrix_data()
    sdif_file.close()
            
def bench_read_sdif2(filename):
    # this is the slowest version
    sdif_file = SdifFile(filename)
    for frame in sdif_file:
        for matrix in frame:
            matrix.get_data()
    sdif_file.close()

def bench_read_sdif3(filename):
    # fastest, 4 is almost the same, 2 is twice as slow..., 
    # it should be different for frames which have
    # many matrices but that is really the exception.
    sdif_file = SdifFile(filename)
    for frame in sdif_file:
        for n in xrange(len(frame)):
            sdif_file.get_next_matrix().get_data()
    sdif_file.close()

def bench_read_sdif4(filename):
    sdif_file = SdifFile(filename)
    for frame in sdif_file:
        for n in xrange(len(frame)):
            frame.next().get_data()
    sdif_file.close()

def bench_read_sdif5(filename):
    # this is the fastest for common case where a frame has only one matrix
    # and you do not need to check the signature of each matrix 
    # (since the matrix-header and the data are read in one function-call)
    sdif_file = SdifFile(filename)
    for frame in sdif_file:
        frame.get_matrix_data() # assume that there is only one matrix per frame
    sdif_file.close()

