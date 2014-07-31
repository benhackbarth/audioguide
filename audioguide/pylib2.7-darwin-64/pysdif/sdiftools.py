"""
This utilities are not real part of pysdif and
do not add any capability to the library
They are mainly shortcuts and routines to deal 
with day-to-day work with sdifs. As such they are
likely to change and no real effort is made to maintain
any sort of backwards compatibility here.
"""

from pysdif import *
import os

def as_sdiffile(s):
    if isinstance(s, SdifFile):
        s.seek(0)
        return s
    return SdifFile(s)

def convert_1TRC_to_RBEP(sdiffile, metadata=None):
    """
    create a RBEP clone from this 1TRC file.
    to perform the opposite operation,
    
    loris.SdifFile("rbep.sdif").write_1TRC("1trc.sdif")
    NB: this will not preserve the metadata
    
    """
    import numpy
    sdiffile = as_sdiffile(sdiffile)
    filename = sdiffile.name
    outfile = os.path.splitext(filename)[0] + "-RBEP.sdif"
    o = SdifFile(outfile, 'w', 'RBEP')
    if metadata is not None:
        _update_NVTs(sdiffile, outfile, metadata)
    def data_convert_1TRC_RBEP(d):
        # normally, 1TRC matrices have index, freq, amp, phase
        # but Spear, for example, add columns to the 1TRC definition to store time offset
        # According to the IRCAM people, this is actually the right thing to do, instead
        # of defining a new frame and matrix type, extend the existing one with bandwidth and offset
        # But Loris and the Loris UGens in Supercollider expect to read RBEP frames, so
        # the discussion is only theoretical: those SDIF files exist out there and we want to
        # be able to read them.
        num_rows = len(d)
        if num_rows > 0:
            empty_rows = numpy.zeros((num_rows, 2), dtype=d.dtype)
            out = numpy.hstack((d[:,:4], empty_rows))
            if not out.flags.contiguous:
                out = out.copy()
            return out
        return d # an empty array
    for frame0 in sdiffile:
        if frame0.signature == '1TRC':
            frame1 = o.new_frame("RBEP", frame0.time)
            data = frame0.get_matrix_data()
            new_data = data_convert_1TRC_RBEP(data)
            frame1.add_matrix("RBEP", new_data)
            frame1.write()
    o.close()

def add_type_definitions(sdiffile, frame_types=None, matrix_types=None, metadata=None, inplace=False):
    """
    if no frame-types or matrix-types are specified, it rewrites the header of the sdiffile
    with the current types made explicit.
    
    for example, if you have a partial-tracking sdif file written by loris, you will
    see that this is a RBEP file, but loris routines do not care to write the type
    definition of the RBEP file and matrices to the sdif file. These types are not
    standard and other sdif tools often have difficulties reading these files
    
    in this case calling
    
    add_type_definitions("my-rbep-loris-file.sdif", inplace=True)
    
    will add the type definitions to the file
    """
    infile = as_sdiffile(sdiffile)
    if infile.signature in SDIF_NEWTYPES:
        if frame_types is None and matrix_types is None:
            outfile = SdifFile(os.path.splitext(infile.name)[0] + '-R.sdif', 'w', infile.signature)
            outfile.clone_frames(infile)
    else:
        outfile = SdifFile(os.path.splitext(infile.name)[0] + '-R.sdif', 'w')
        if frame_types is not None:
            if not isinstance(frame_types, (tuple, list)):
                frames_types = [frame_types]
            for frametype in frame_types:
                outfile.add_frame_type(frametype)
        if matrix_types is not None:
            if not isinstance(matrix_types, (tuple, list)):
                matrix_types = [matrix_types]
            for matrixtype in matrix_types:
                outfile.add_matrix_type(matrixtype)
    if metadata is not None:
        _update_NVTs(infile, outfile, metadata)
    else:
        outfile.clone_NVTs(infile)
    outfile.clone_frames(infile)
    infilename = infile.name
    outfilename = outfile.name
    outfile.close()
    infile.close()
    if inplace:
        os.remove(infilename)
        os.rename(outfilename, infilename)
        outfilename = infilename
    return outfilename
    
def repair_RBEP(sdiffile, metadata=None):
    """
    add the type definitions to a RBEP file as written by, for example, loris
    in the same step you can update the metadata of the sdif file
    """
    assert SdifFile(sdiffile).signature == "RBEP"
    return add_type_definitions(sdiffile, metadata=metadata, inplace=True)

        
def write_metadata(sdif_filename, metadata={}, inplace=True):
    """
    produce a copy of the sdif file with the metadata given. if there was any metadata
    already defined in the source file, it will be overwritten.
    
    """
    suffix = "-M"
    insdif = SdifFile(sdif_filename)
    if not inplace:
        outsdif = SdifFile(os.path.splitext(sdif_filename)[0] + suffix + ".sdif", 'w')
    else:
        import tempfile
        outsdif = SdifFile(tempfile.mktemp(), 'w')
    outsdif.add_NVT(metadata)
    # and now, clone everything
    outsdif.clone_type_definitions(insdif)
    outsdif.clone_frames(insdif)
    infile = insdif.name
    outfile = outsdif.name
    outsdif.close()
    insdif.close()
    if inplace:
        os.remove(infile)
        os.rename(outfile, infile)
        
def update_metadata(sdiffile, metadata, inplace=True):
    """
    update the metadata of the given sdiffile. any name already present in 
    the original file with be updated with the new value, new names will
    be added. other name-value pairs will be left untouched.
    
    this is the same as the 'update' method in python:
    
    a = {...}
    a.update({...})
    
    NB: only the first NVT is taken into consideration, if present,
    other NVTs are passed untouched.
    
    """
    suffix = "-M"
    insdif = as_sdiffile(sdiffile)
    if not inplace:
        outsdif = SdifFile(os.path.splitext(sdif_filename)[0] + suffix + ".sdif", 'w')
    else:
        import tempfile
        outsdif = SdifFile(tempfile.mktemp(), 'w')
    _update_NVTs(insdif, outsdif, metadata)
    outsdif.clone_type_definitions(insdif)
    outsdif.clone_frames(insdif)
    infile = insdif.name
    outfile = outsdif.name
    outsdif.close()
    insdif.close()
    if inplace:
        os.remove(infile)
        os.rename(outfile, infile)
        
def get_metadata(sdiffile):
    """
    returns a python dict with the metadata defined in sdiffile
    """
    metadata = as_sdiffile(sdiffile).get_NVTs()
    if len(metadata) == 1:
        return metadata[0]
    return metadata
    
def get_signature(sdiffile):
    return as_sdiffile(sdiffile).signature
    
def _update_NVTs(insdif, outsdif, metadata):
    nvts = insdif.get_NVTs()
    nvts[0].update(metadata)
    for nvt in nvts: 
        outsdif.add_NVT(nvt)
        
def time_range(sdiffile):
    sdiffile = as_sdiffile(sdiffile)
    sdiffile.next()
    t0 = sdiffile.time
    for frame in sdiffile: pass
    t1 = sdiffile.time
    return t0, t1
    
def read_f0(sdiffile):
    sdiffile = SdifFile(sdiffile)
    assert sdiffile.signature == "1FQ0"
    times = []
    freqs = []
    for frame in sdiffile:
        times.append(frame.time)
        freqs.append(frame.get_matrix_data()[0, 0]) # only one row and one column per frame
    return times, freqs

def chordseq_to_1TRC(sdiffile, outfile=None):
    sdiffile = as_sdiffile(sdiffile)
    if outfile is None:
        outfile = os.path.splitext(sdiffile.name)[0] + '-1TRC.sdif'
    s = SdifFile(outfile, 'w', '1TRC')
    for frame in sdiffile:
        for matrix in frame:
            if matrix.signature == '1BEG':
                t0 = frame.time
            elif matrix.signature == '1END':
                t1 = frame.time
                s.new_frame_one_matrix('1TRC', t0, '1TRC', data)
                s.new_frame_one_matrix('1TRC', t1, '1TRC', data)
            elif matrix.signature == '1TRC':
                data = matrix.get_data().copy()
    s.close()

def check_matrix_exists(sdiffile, frame_sig, matrix_sig):
    sdiffile = SdifFile(sdiffile)
    for frame in sdiffile:
        if frame.signature == frame_sig:
            for matrix in frame:
                if matrix.signature == matrix_sig:
                    return True
    return False        

class Marker:
    def __init__(self, marker_type, begin, end, values):
        self.marker_type = marker_type
        self.begin = begin
        self.end = end
        self.values = values
    def __repr__(self):
        return "%s <%f, %f> | values: %f %f" % (self.marker_type, self.begin, self.end, self.values[0], self.values[1])
    def __iter__(self):
        return iter(self.begin, self.end)
    def __getitem__(self, i):
        return (self.begin, self.end)[i]    

class TransientMarker(Marker):
    def __init__(self, begin, end, values):
        Marker.__init__(self, 'transient', begin, end, values)
        
class SpectralDiffMarker(Marker):
    def __init__(self, time, values):
        Marker.__init__(self, 'spectral', time, time, values)

def read_transient_markers(sdiffile):
    if not check_matrix_exists(sdiffile, '1MRK', 'XTRD'):
        raise ValueError("no transient values found in this file")
    markers = []
    for frame in SdifFile(sdiffile):
        if frame.signature == '1MRK':
            for matrix in frame:
                if matrix.signature == '1BEG':
                    t0 = frame.time
                    index0 = matrix.get_data()[0]
                elif matrix.signature == 'XTRD':
                    values = matrix.get_data()[0].copy()
                elif matrix.signature == '1END':
                    index1 = matrix.get_data()[0, 0]
                    assert index1 == index0
                    markers.append(TransientMarker(t0, frame.time, values))
    return markers
    
def read_markers(sdiffile):
    if not (check_matrix_exists(sdiffile, '1MRK', 'XTRD') or check_matrix_exists(sdiffile, '1MRK', 'XASD')):
        raise ValueError("no markers found in this file")
    markers = []
    for frame in SdifFile(sdiffile):
        if frame.signature == '1MRK':
            for matrix in frame:
                if matrix.signature == '1BEG':
                    t0 = frame.time
                    index0 = matrix.get_data()[0]
                elif matrix.signature == 'XTRD':
                    values = matrix.get_data()[0].copy()
                elif matrix.signature == '1END':
                    index1 = matrix.get_data()[0, 0]
                    assert index1 == index0
                    markers.append(TransientMarker(t0, frame.time, values))
                elif matrix.signature == 'XASD':
                    markers.append( SpectralDiffMarker(frame.time, matrix.get_data()[0].copy()) )
    return markers
                    
"""
def read_markers(sdiffile):
    markers = []
    for frame in as_sdiffile(sdiffile):
"""