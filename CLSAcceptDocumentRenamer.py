# -*- coding: utf-8 -*-
from CLSAcceptDocumentRenamerData import registrantDataList, documentTypeDict, usernamesToIgnore, docsToIgnore, organizationDict, toMove, AISIDDict
import re
import os
import csv
import filenamer

# import codecs
# latinEncoder = codecs.getencoder("latin-1")

# Add organization property to Registrant class, to deal with separating documents (should default to "unknown" because it is changeable)
# Unicode support for filenames
# sort output documents according to organization

registrantDict = {}
documentList = []
try:
    # os.mkdir("Ignored")
    os.mkdir("Ohio State")
    os.mkdir("Ohio University")
    os.mkdir("American Councils")
    os.mkdir("Unknown")
    # os.mkdir("Moved")
except:
    print "make no dirs"


class Registrant(object):

    def __init__(self,AISFormsAppReferenceCode,firstName,lastName,AISNumber):
        self.firstName = firstName
        self.lastName = lastName
        self.AISNumber = AISNumber
        self.AISFormsAppReferenceCode = AISFormsAppReferenceCode
        self.AISFormsUsername = getUsername(AISFormsAppReferenceCode)
        self.documents = []
        self.organization = self.setOrganization()

    def getFirstName(self):
        return self.firstName

    def getOrganization(self):
        return self.organization

    def getLastName(self):
        return self.lastName

    def getAISNumber(self):
        return self.AISNumber

    def setOrganization(self):
        if self.AISFormsUsername in organizationDict:
            self.organization = getOrganization(self.AISFormsUsername)
        else:
            self.organization = "Unknown"

    def getAISFormsAppReferenceCode(self):
        return self.AISFormsAppReferenceCode

    def getAISFormsUsername(self):
        return self.AISFormsUsername

    def getDocuments(self):
        return self.documents

    def addDocument(self, document):
        self.documents.append(document)


class Document(object):

    def __init__(self,filename):
        self.referenceCode = extractReferenceCode(filename)
        self.AISFormsUsername = getUsername(self.referenceCode)
        self.documentType = findDocumentType(filename)
        self.fileFormat = findFileFormat(filename)
        self.originalFilename = filename
        self.AISDocumentID = self.findAISDocumentID(filename)
        self.newFilename = None

    def getReferenceCode(self):
        return self.referenceCode

    def getAISDocumentID(self):
        return self.AISDocumentID

    def getAISFormsUsername(self):
        return self.AISFormsUsername

    def getDocumentType(self):
        return self.documentType

    def getFileFormat(self):
        return self.fileFormat

    def getOriginalFilename(self):
        return self.originalFilename

    def getNewFilename(self):
        return self.newFilename

    def setNewFilename(self, newFilename):
        self.newFilename = newFilename

    def findAISDocumentID(self, filename):
        outputList = []
        for key in AISIDDict:
            if key in filename:
                outputList.append(AISIDDict[key])
        if len(outputList) > 1:
            raise Exception
        elif len(outputList) == 1:
            return outputList[0]
        else:
            return None

    def createNewFilenameForStaff(self, registrantDict):
        originalFilename = self.getOriginalFilename()
        registrant = registrantDict[self.getAISFormsUsername()]
        lastName = registrant.getLastName()
        firstName = registrant.getFirstName()
        documentType = self.getDocumentType()
        AISNumber = registrant.getAISNumber()
        fileFormat = self.getFileFormat()
        organization = registrant.getOrganization()
        joinList = [organization,"/",lastName,"_",firstName,"_",documentType,"_",AISNumber,".",fileFormat]
        joinedString = ''.join(joinList)
        return unicode(joinedString,"utf-8")
        # return unicode(joinedString,"latin-1")

    def renameForStaff(self):
        if self.getNewFilename() == None:
            try:
                print(self.createNewFilenameForStaff(registrantDict))
            except KeyError:
                print("KeyError for " + self.getAISFormsUsername())
        else:
            try:
                # print(str("renaming " + self.getOriginalFilename() + " to " + self.getNewFilename()))
                os.rename(self.getOriginalFilename(), self.getNewFilename())
            except UnicodeEncodeError:
                print(str("UnicodeError for " + self.getOriginalFilename()))
            except TypeError:
                print(str("TypeError for " + self.getOriginalFilename()))
            except WindowsError:
                print(str("WindowsError for " + self.getOriginalFilename()))

    def createNewFilenameForAIS(self, registrantDict):
        originalFilename = self.getOriginalFilename()
        registrant = registrantDict[self.getAISFormsUsername()]
        lastName = registrant.getLastName()
        firstName = registrant.getFirstName()
        documentType = self.getDocumentType()
        AISNumber = registrant.getAISNumber()
        fileFormat = self.getFileFormat()
        organization = registrant.getOrganization()
        AISDocumentID = self.getAISDocumentID()
        joinList = [AISNumber,"_",AISDocumentID,".",fileFormat]
        joinedString = ''.join(joinList)
        return unicode(joinedString,"utf-8")
        # return unicode(joinedString,"latin-1")

    def renameForAIS(self):
        if self.getNewFilename() == None:
            try:
                print(self.createNewFilenameForAIS(registrantDict))
            except KeyError:
                print("KeyError for " + self.getAISFormsUsername())
        else:
            try:
                # print(str("renaming " + self.getOriginalFilename() + " to " + self.getNewFilename()))
                os.rename(self.getOriginalFilename(), self.getNewFilename())
            except UnicodeEncodeError:
                print(str("UnicodeError for " + self.getOriginalFilename()))
            except TypeError:
                print(str("TypeError for " + self.getOriginalFilename()))
            except WindowsError:
                print(str("WindowsError for " + self.getOriginalFilename()))


def moveEm():
    listToMove = filenamer.getMovable(toMove)
    filenamer.moveEm(listToMove)

def doNothing():
    pass

def getOrganization(username):
    return organizationDict[username]

def findDocumentType(filename):
    stringSplit = filename.split('.')
    if len(stringSplit) != 2:
        raise Exception
    usefulString = stringSplit[0]
    resultList = []
    for key in documentTypeDict:
        if key in usefulString:
            resultList.append(documentTypeDict[key])
    if len(resultList) != 1:
        raise Exception
    else:
        return resultList[0]

def findFileFormat(filename):
    stringSplit = filename.split('.')
    return stringSplit[-1]
    return None

def extractReferenceCode(filename):
    '''
    takes filename as string
    returns reference code as string in format AAAA1111
    '''
    regex = re.compile('[A-Z]{4}[\d]{4}')
    result = regex.findall(filename)
    # print result
    # print len(result)
    if len(result) != 1:
        raise Exception
    if len(result[0]) != 8:
        raise Exception
    return result[0]

def getUsername(referenceCode):
    return referenceCodeDict[referenceCode]

def getFiles():
    return [file for file in os.listdir('.')]

def makeRegistrantDict(registrantDataList = registrantDataList):
    outputDict = {}
    i = 0
    lastMade = None
    for reg in registrantDataList:
        # Watch out here - should be 0, 1, 2, 3, but I flipped it because I pulled it out of AIS in this format 2013-04-17
        AISFormsAppReferenceCode = reg[0]
        firstName = reg[2]
        lastName = reg[1]
        AISNumber = reg[3]
        newReg = Registrant(AISFormsAppReferenceCode,firstName,lastName,AISNumber)
        outputDict[getUsername(AISFormsAppReferenceCode)] = newReg
        lastMade = newReg
        i += 1
    # print i
    # print lastMade.getAISFormsAppReferenceCode()
    return outputDict

def getInterestingFiles():
    outputList = []
    for filename in getFiles():
        if findFileFormat(filename) not in [".py",".pyc", ".txt", ""]:
            outputList.append(filename)
        else:
            print(str("Ignored " + filename))
            # os.rename(filename, str("Ignored/"+filename))
    return outputList

def makeDocumentList(filenames = getInterestingFiles()):
    outputList = []
    for filename in filenames:
        refCodeErrorFlag = False
        try:
            extractReferenceCode(filename)
            newDoc = Document(filename)
            outputList.append(newDoc)
        except:
            refCodeErrorFlag = True
            # print("Probable ReferenceCode Error for " + filename)
        if refCodeErrorFlag == True:
            try:
                print(str("refCodeError for " + filename))
                # os.rename(filename, str("Ignored/"+filename))
            except WindowsError:
                print("WindowsError renaming " + filename)
         
            # break
        # except:
    return outputList

def addDocumentsToRegistrants(documentList, registrantDict):
    for document in documentList:
        if document.getAISFormsUsername() not in usernamesToIgnore:
            registrant = registrantDict[document.getAISFormsUsername()]
            registrant.addDocument(document)

def setOrganizations(registrantDict):
    for key in registrantDict:
        registrant = registrantDict[key]
        registrant.setOrganization()

def createRefCodeDict():
    lol = list(csv.reader(open('refcodelist.txt', 'rb'), delimiter='\t'))
    outputDict = dict()
    for line in lol:
        key = line[0]
        value = line[1]
        outputDict[key] = value
    return outputDict

def setup():
    # moveEm()
    global referenceCodeDict
    referenceCodeDict = createRefCodeDict()
    global registrantDict
    registrantDict = makeRegistrantDict()
    global documentList
    documentList = makeDocumentList()
    addDocumentsToRegistrants(documentList,registrantDict)
    setOrganizations(registrantDict)
    for document in documentList:
        if document.getAISFormsUsername() not in usernamesToIgnore:
            try:
                # document.setNewFilename(document.createNewFilenameForStaff(registrantDict))
                document.setNewFilename(document.createNewFilenameForAIS(registrantDict))
            except TypeError:
                print ("TypeError for " + document.getOriginalFilename())

def go():
    # print("edit")
    setup()
    for document in documentList:
        if document.getDocumentType() not in docsToIgnore:
            try:
                # document.rename()
                document.renameForAIS()
                # document.renameForStaff()
            except:
                print("329 exception for " + document.getOriginalFilename())
        else:
            original = document.getOriginalFilename()
            print(str("moving " + original))
            # os.rename(original, str("Ignored/"+original))


def tPrint (registrantDict):
    for key in registrantDict:
        registrant = registrantDict[key]
        AISFormsAppReferenceCode = registrant.getAISFormsAppReferenceCode()
        AISFormsUsername = registrant.getAISFormsUsername()
        AISNumber = registrant.getAISNumber()
        documents = registrant.getDocuments()
        firstName = registrant.getFirstName()
        lastName = registrant.getLastName()
        print("###")
        printString =' '.join([firstName,lastName,AISNumber,AISFormsUsername])
        print(printString)
        for document in documents:
            print document.getOriginalFilename()

###

