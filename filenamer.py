# -*- coding: cp1252 -*-
import os
list_of_files = [file for file in os.listdir('.')]

fileDict = {}
toMove = []

def getFiles():
    return [file for file in os.listdir('.')]
    
def printFiles():
    for file in getFiles():
        print file

def countPDFs(list_of_files=getFiles()):
    count = 0
    for file in list_of_files:
        if file.lower().endswith('.pdf'):
            count += 1
    return count

def tPrint(Dict=fileDict, list_of_files=getFiles()):
    for file in list_of_files:
        try:
            if file.lower().endswith('.pdf'):
                print file
                print Dict[file]
                print '###'
        except:
            pass

def renamer(Dict=fileDict, list_of_files=getFiles()):
    for file in list_of_files:
        try:
            if file.lower().endswith('.pdf'):
                os.rename(file,Dict[file])
                print "renamed", file, "to", Dict[file]
        except:
            pass
    #addPDF()
        
def getMovable(list = toMove):
    result = []
    for filename in getFiles():
        for s in list:
            if s in filename:
                result.append(filename)
    return result

def moveEm(list = getMovable()):
    try:
        os.mkdir("moved")
    except:
        pass
    for file in list:
        os.rename(file, str("moved/" + file))

def addPDF():
    list = getFiles()
    for file in list:
        if not file.lower().endswith('.py'):
            os.rename(file,file+'.pdf')            
