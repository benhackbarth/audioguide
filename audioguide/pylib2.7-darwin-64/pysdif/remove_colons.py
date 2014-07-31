import sys
filename = sys.argv[1]
f = file(filename)
out = file(filename + ".tmp", "w")
for i, line in enumerate(f):
    
    stripped_line = line.strip()
    if not stripped_line.startswith("#"):
        if stripped_line.endswith(";"):
            line = line.rstrip()[:-1] + "\n"
    out.write(line)


            
