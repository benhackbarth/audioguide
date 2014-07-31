from _pysdif import *
import atexit
import _pysdif


@atexit.register
def _cleanup():
    _pysdif._cleanup()
    
_pysdif._init()

from sdiftools import *