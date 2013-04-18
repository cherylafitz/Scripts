import os
import re

def doNothing():
    pass

def getFiles():
    return [file for file in os.listdir('.')]

def getPdfs():
    returnList = []
    for filename in os.listdir('.'):
        if filename.lower().endswith('.pdf'):
            returnList.append(filename)
    return returnList

def printFiles():
    for file in getFiles():
        print(file)

def countPDFs(list_of_files=getFiles()):
    count = 0
    for file in list_of_files:
        if file.lower().endswith('.pdf'):
            count += 1
    return count

# def tPrint(Dict=fileDict, list_of_files=getFiles()):
#     for file in list_of_files:
#         try:
#             if file.lower().endswith('.pdf'):
#                 print file
#                 print Dict[file]
#                 print '###'
#         except:
#             pass

# def renamer(Dict=fileDict, list_of_files=getFiles()):
#     for file in list_of_files:
#         try:
#             if file.lower().endswith('.pdf'):
#                 os.rename(file,Dict[file])
#                 print "renamed", file, "to", Dict[file]
#         except:
#             pass
        
def addPDF():
    list = getFiles()
    for file in list:
        if not file.lower().endswith('.py'):
            os.rename(file,file+'.pdf')            

def getNumbersOutOfFilename(filename):
    '''
    looks at a filename, extracts the numeric part of it
    '''
    #would be better to use regex here
    regex = re.compile('[\d]')
    returnList = regex.findall(filename)
    #print returnList
    return ''.join(returnList)

def findMatchingAdobeCode(sequenceNumber):
    '''
    pass number in as integer, returns matching Adobe code as string
    '''
    lowerBound = findLowerBound(sequenceNumber)
    upperBound = lowerBound + 49
    placeInBounds = sequenceNumber - lowerBound + 1
    if placeInBounds > 50:
        placeInBounds -= 50
    returnList = [str(lowerBound),str(upperBound), str(placeInBounds)]
    result = ''.join(returnList)
    #print result
    return result

def findLowerBound(number):
    if number % 50 == 0:
        return number - 49
    else:
        result = (int((float(number) / 50.0)) * 50) + 1
        return result

def makeAdobeCodeDict(limit=5000):
    returnDict = {}
    for i in range(limit):
        adobeCode = findMatchingAdobeCode(i)
        returnDict[adobeCode] = i
    return returnDict

def renameToSequenceOrder(pdfList=getPdfs(), adobeCodeDict=makeAdobeCodeDict()):
    highestSequence = 0
    nonstandard = []
    for filename in pdfList:
        try:
            adobeCode = getNumbersOutOfFilename(filename)
            # print adobeCode
            sequenceNumber = adobeCodeDict[adobeCode]
            # print sequenceNumber
            if sequenceNumber > highestSequence:
                highestSequence = sequenceNumber
            os.rename(filename, str(sequenceNumber) + '.pdf')
        except:
            nonstandard.append(filename)
    nonstandard.sort()
    sortProblemsFlag = False
    longestFilenameLength = len(nonstandard[0])
    for filename in nonstandard:
        if len(filename) != longestFilenameLength:
            sortProblemsFlag = True
            break
    if sortProblemsFlag == True:
        nonstandard = nonStandardSortFix(nonstandard)
    for filename in nonstandard:
        # print filename
        os.rename(filename, str(highestSequence + 1) + '.pdf')
        # print str(highestSequence + 1)
        highestSequence += 1

def nonStandardSortFix(list):
    # print list
    shortest = len(list[0])
    longest = len(list[0])
    for filename in list:
        if len(filename) > longest:
            longest = len(filename)
        if len(filename) < shortest:
            shortest = len(filename)
    # print shortest
    # print longest
    newList = []
    for filename in list:
        if len(filename) == shortest:
            part1 = filename[:-5]
            part2 = filename[-5:]
            newName = str(part1 + '0' + part2)
            try:
                os.rename(filename, newName)
            except:
                doNothing()
                # print("no rename")
            newList.append(newName)
        else:
            newList.append(filename)
    newList.sort()
    # print newList
    return newList

def go():
    renameToSequenceOrder(getPdfs(), makeAdobeCodeDict())

if __name__ == "__main__":
    go()
