R=255
G=0
B=0

C=255-R
M=255-G
Y=255-B

min_top=C
if M < min_top:
    min_top = M

min_btm = min_top
if Y < min_btm:
    min_btm = Y

C=C-min_btm
M=M-min_btm
Y=Y-min_btm
K=min_btm

print("CMYK({},{},{},{})".format(C,Y,M,K))
