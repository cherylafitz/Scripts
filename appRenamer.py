import re
import os

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
        if '.pdf' in filename:
            returnList.append(filename)
    return returnList

def getNewName(filename):
    refCode = extractReferenceCode(filename)
    identifier = "App"
    return str(refCode + "-" + identifier + '.pdf')


def renameApps():
    for filename in getFilesToRename():
        os.rename(filename, getNewName(filename))


