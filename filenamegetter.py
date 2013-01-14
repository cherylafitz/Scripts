import shutil
import os

def getFiles():
    files = os.listdir("./")
    return files

def output(filename):
    output = open (filename, 'w')
    for file in files:
        output.write(file)
        output.write('\n')

def countFiles(files):
    i = 0
    for file in files:
        i += 1
    return i

def printFiles(files):
    for file in files:
        print file

files = getFiles()
print countFiles(files)

output('output.txt')
