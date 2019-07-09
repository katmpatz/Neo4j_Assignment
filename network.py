
import csv

f = open('soc-pokec-profiles.txt', "r", encoding="utf8" )
g = open("profiles.txt", "w")
sum=0
for line in f:
    if line.strip():
        str = ""
        for (i,l) in enumerate(line.split("\t")[:8]):
            if i == 0 or i==3:
                str= str + l + "\t"
            if i==7:
                str= str + l
        g.write(str + "\n")
    sum = sum + 1
    print(sum)
f.close()
g.close()
