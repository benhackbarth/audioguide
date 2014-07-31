import sys
filename = sys.argv[1]
f = file(filename)
out = file(filename + ".tmp", "w")
for i, line in enumerate(f):
    
    stripped_line = line.lstrip()
    if not stripped_line.startswith("#"):
        colon = line.find(";")
        comment = line.find("#")
        if colon != -1 and (comment == -1 or comment > colon):
            line = line[:colon] + "  #-- " + line[colon:]
    out.write(line)
            



            
