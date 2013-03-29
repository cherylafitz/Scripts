import re
import os
from recRenamerData import recDict
from recRenamerData import identifierStringDict

def getFiles():
    return [file for file in os.listdir('.')]

def extractReferenceCode(filename):
    '''
    takes filename as string
    returns reference code as string in format AAAA1111
    '''
    regex = re.compile('[A-Z]{4}[\d]{4}')
    result = regex.findall(filename)
    if len(result) != 1:
        raise Exception
    if len(result[0]) != 8:
        raise Exception
    return result[0]

def getFilesToRename():
    returnList = []
    for filename in getFiles():
        for key in identifierStringDict:
            if key in filename:
                returnList.append(filename)
    return returnList

def getNewName(filename):
    recRefCode = extractReferenceCode(filename)
    appRefCoode = recDict[recRefCode]
    identifier = ""
    matches = 0
    for key in identifierStringDict:
        if key in filename:
            identifier = identifierStringDict[key]
            matches += 1
    if matches == 0:
        raise Exception
    if matches > 1:
        raise Exception
    return str(appRefCoode + "-" + identifier + "-" + recRefCode + '.pdf')


def renameRecs():
    for filename in getFilesToRename():
        os.rename(filename, getNewName(filename))


