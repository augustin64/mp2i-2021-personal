#!/usr/bin/python3
from math import sqrt

with open("dames.out", "r") as f:
    data = f.read()

data2 = data.split('\n')[1].split(' ')

taille = int(sqrt(len(data2)-1))
text = ""
for i in range(taille):
    for j in range(taille):
        if int( data2[i*taille+j] ) < 0:
            text += "--"
        else:
            text += "||"
    text += "\n"
    
print(text)