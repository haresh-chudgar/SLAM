# -*- coding: utf-8 -*-

import math
import csv

sensorFile = open('robotLog.csv', 'r')

cumulativeOdometryX = 0
cumulativeOdometryY = 0
cumulativeOdometryTheta = 0

prevOdometryX = 0
prevOdometryY = 0
prevOdometryTheta = 0

str = sensorFile.readline()
scanIndex = 0
isMovement = True
lineIndex = 1

while(str != ""):
    message = str.split()
    str = sensorFile.readline()
    
    if(message[0] == "POS"):
        changeX = float(message[3]) - prevOdometryX
        changeY = float(message[4]) - prevOdometryY
        angleChange = float(message[5]) - prevOdometryTheta
        if(changeX == 0 and changeY == 0 and angleChange == 0):
            print("POS ", scanIndex, lineIndex)
            lineIndex += 1
            continue
        
        isMovement = True        

        rcX = (changeX*math.cos(cumulativeOdometryTheta) - changeY * math.sin(cumulativeOdometryTheta))
        rcY = (changeX*math.sin(cumulativeOdometryTheta) + changeY * math.cos(cumulativeOdometryTheta))
        #pathWriter.writerow([rPosX, rPosY, rPosX + rcX, rPosY + rcY])

        cumulativeOdometryTheta += angleChange
        prevOdometryX = float(message[3])
        prevOdometryY = float(message[4])
        prevOdometryTheta = float(message[5])
        cumulativeOdometryX += rcX
        cumulativeOdometryY += rcY 
        lineIndex += 1
        
    elif(message[0] == "LASER-RANGE"):
        if(lineIndex != 1 and isMovement == False):
            print("Range continue ", scanIndex, lineIndex)
            lineIndex += 1
            continue
        
        isMovement = False
        print("Range inside ", scanIndex, lineIndex)
        lineIndex += 1
        pointCloudFile = open('pointclouds/pointCloud_{0}.csv'.format(scanIndex), 'w')
        pointCloudWriter = csv.writer(pointCloudFile, delimiter=',',quotechar='|', quoting=csv.QUOTE_MINIMAL)
        pointCloudWriter.writerow([cumulativeOdometryX, cumulativeOdometryY, cumulativeOdometryTheta, lineIndex])
        
        pointCloud = []
        scanIndex += 1
        msgIndex = 6
        theta = math.radians(-90)
        for iteration in range(180):
            rangeMeasured = float(message[msgIndex])
            posX = rangeMeasured * math.cos(theta)
            posY = rangeMeasured * math.sin(theta)

            wPosX = cumulativeOdometryX + rangeMeasured * math.cos(theta + cumulativeOdometryTheta)
            wPosY = cumulativeOdometryY + rangeMeasured * math.sin(theta + cumulativeOdometryTheta)
            pointCloudWriter.writerow([posX, posY, wPosX, wPosY])
            theta += math.radians(1)
            msgIndex += 1
        pointCloudFile.close()
        
        cumulativeOdometryX = 0
        cumulativeOdometryY = 0
        cumulativeOdometryTheta = 0
        
        if(scanIndex == 60):
            break

sensorFile.close()
#pathFile.close()