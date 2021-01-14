import csv
import os

dirName = os.path.dirname(__file__)
with open(dirName +'jsonOutput.txt', 'r') as file:
    df = file.read()
x = df.split('&')

titlePos = x[0].find('idapp=') + 6
title = x[0][titlePos:-1]

with open(dirName +'jsonOutput.csv', 'w', newline='') as file:
    writer = csv.writer(file, delimiter=',')
    writer.writerow([title])
    #print("Title: ",title)
    for strin in x:
        if strin.find('=F') != -1:
            strin = strin.replace('=F','')
            writer.writerow([strin,'Failed'])
            #print(strin + ',Failed')
        elif strin.find('=P') != -1:
            strin = strin.replace('=P','')
            writer.writerow([strin,'Passed'])
            #print(strin + ',Passed')
        else:
            writer.writerow([strin,'Undefined'])
            #print(strin + ',Undefined')
            pass
file.close()