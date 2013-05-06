import csv

def createRefCodeDict():
    lol = list(csv.reader(open('refcodelist.txt', 'rb'), delimiter='\t'))
    outputDict = dict()
    for line in lol:
        key = line[0]
        value = line[1]
        outputDict[key] = value
    return outputDict