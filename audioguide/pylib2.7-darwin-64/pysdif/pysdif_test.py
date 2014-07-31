import pysdif

for obj in dir(pysdif):
    if obj.startswith("test"):
        getattr(pysdif, obj)("pru.sdif")
