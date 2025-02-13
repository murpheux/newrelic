import os
import subprocess
#========================================
#Define variables
speedlist = speedrun = ""
latency = download = upload = ""
batch = response = ""
#========================================
#Function Junction
def fixnum(x):
x = x.replace('"', '')
x = float(x)
return x 
#========================================
speedrun = os.popen("speedtest --accept-license -f csv").read()
speedlist = speedrun.split(",")
latency = fixnum(speedlist[3])
download = fixnum(speedlist[6]) / 125000
upload = fixnum(speedlist[7]) / 125000
print(latency, " ", download, " ", upload)