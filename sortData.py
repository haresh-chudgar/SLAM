# -*- coding: utf-8 -*-
"""
Created on Mon Apr  4 17:51:43 2016

@author: haresh
"""

sensorFile = open('intel.script', 'r')
messages = []
times = {}
index = 0
str = sensorFile.readline()
while(str != ""):
    message = str.split()
    str = sensorFile.readline()
    timeInSec = float(message[1])
    timeInUSec = float(message[2].split(':')[0])
    time = timeInSec + timeInUSec / 1000000
    messages.append(str)
    times[index] = time
    index += 1
    
times = sorted(times.items(), key=lambda x:x[1])
datalogFile = open('robotLog.csv', 'w')
        
index = 0
for time in times:
    datalogFile.write(messages[time[0]])

datalogFile.close()