# -*- coding: cp1252 -*-
import os
list_of_files = [file for file in os.listdir('.')]

fileDict = {}

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

def t():
    tPrint(testDict,list_of_files)

def d():
    addPDF(list_of_files)

def tPrint(Dict=fileDict, list_of_files=getFiles()):
    for file in list_of_files:
        if file.lower().endswith('.pdf'):
            print file
            print Dict[file]
            print '###'

def renamer(Dict=fileDict, list_of_files=getFiles()):
    for file in list_of_files:
        if file.lower().endswith('.pdf'):
            os.rename(file,Dict[file])
            print "renamed", file, "to", Dict[file]
    #addPDF()
        

def addPDF():
    list = getFiles()
    for file in list:
        if not file.lower().endswith('.py'):
            os.rename(file,file+'.pdf')            