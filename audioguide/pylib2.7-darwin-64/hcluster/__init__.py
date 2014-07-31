import hierarchy as _h
import distance as _d
from hierarchy import *
from distance import *
from inspect import getmembers
from types import FunctionType
from pydoc import getdoc
from hierarchy import __doc__ as _hs
from distance import __doc__ as _ds

__doc__ = _hs + """

""" +_ds

__doc__ += """

Detailed Documentation
----------------------
"""

for (n, f) in getmembers(_h) + getmembers(_d):
    if type(f) is types.FunctionType and not n.startswith('_'):
        __doc__ += "===== %s\n %s \n\n" % (n, getdoc(f))


__doc__ += """
\n\n============= ClusterNode Class

Brief Summary:

%s

""" % getdoc(_h.ClusterNode)

for (n, f) in getmembers(_h.ClusterNode):
    if type(f) is types.MethodType and not n.startswith('_'):
        __doc__ += "Method %s:\n %s \n\n" % (n, getdoc(f))

