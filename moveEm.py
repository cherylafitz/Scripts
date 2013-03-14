import os

try:
	os.mkdir("moved")
else:
	pass

def getFiles():
    return [file for file in os.listdir('.')]

toMove = []

def getMovable(list = toMove):
    result = []
    for filename in getFiles():
        for s in list:
            if s in filename:
                result.append(filename)
    return result

def moveEm(list = getMovable()):
	for file in list:
		os.rename(file, str("moved/" + file))