from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
#import numpy
import os

#def cython_setup0():
#    setup(
#        name = "pysdif",
#        ext_modules=[ 
#            Extension("_pysdif",  ["_pysdif.pyx"],
#            include_dirs = [numpy.get_include(), '/usr/local/include'])],
#        cmdclass = {'build_ext': build_ext}
#    )
def cython_setup():
    if not os.path.exists("_pysdif.c"):
        os.system("cython -a _pysdif.pyx")
    else:
        import glob
        print glob.glob("*")
if __name__ == "__main__":
    cython_setup()
    
    
    
    
