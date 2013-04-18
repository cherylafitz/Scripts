from CLSAcceptDocumentRenamerData import registrantDataList, referenceCodeDict, documentTypeDict, usernamesToIgnore, docsToIgnore
import re
import os



class Registrant(object):

    def __init__(self,AISFormsAppReferenceCode,firstName,lastName,AISNumber):
        self.firstName = firstName
        self.lastName = lastName
        self.AISNumber = AISNumber
        self.AISFormsAppReferenceCode = AISFormsAppReferenceCode
        self.AISFormsusername = getUsername(AISFormsAppReferenceCode)
        self.documents = []

    def getFirstName(self):
        return self.firstName

    def getLastName(self):
        return self.lastName

    def getAISNumber(self):
        return self.AISNumber

    def getAISFormsAppReferenceCode(self):
        return self.AISFormsAppReferenceCode

    def getAISFormsusername(self):
        return self.AISFormsusername

    def getDocuments(self):
        return self.documents

    def addDocument(self, document):
        self.documents.append(document)


class Document(object):

    def __init__(self,filename):
        self.referenceCode = extractReferenceCode(filename)
        self.AISFormsusername = getUsername(self.referenceCode)
        self.documentType = findDocumentType(filename)
        self.fileFormat = findFileFormat(filename)
        self.originalFilename = filename
        self.newFilename = None

    def getReferenceCode(self):
        return self.referenceCode

    def getAISFormsusername(self):
        return self.AISFormsusername

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

    def createNewFilename(self, registrantDict):
        originalFilename = self.getOriginalFilename()
        registrant = registrantDict[self.getAISFormsusername()]
        lastName = registrant.getLastName()
        firstName = registrant.getFirstName()
        documentType = self.getDocumentType()
        AISNumber = registrant.getAISNumber()
        fileFormat = self.getFileFormat()
        joinList = [lastName,"_",firstName,"_",documentType,"_",AISNumber,".",fileFormat]
        return ''.join(joinList)

    def rename(self):
        if self.getNewFilename == None:
            raise Exception
        else:
            # print(str("renaming " + self.getOriginalFilename() + " to " + self.getNewFilename()))
            os.rename(self.getOriginalFilename(),self.getNewFilename())

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
        newReg = Registrant(reg[1],reg[0],reg[2],reg[3])
        outputDict[getUsername(reg[0])] = newReg
        lastMade = newReg
        i += 1
    print i
    print lastMade.getAISFormsAppReferenceCode()
    return outputDict

def getInterestingFiles():
    outputList = []
    for filename in getFiles():
        if findFileFormat(filename) not in [".py",".pyc"]:
            outputList.append(filename)
        else:
            print(str("skipping " + filename))
    return outputList

def makeDocumentList(filenames = getInterestingFiles()):
    outputList = []
    for filename in filenames:
        try:
            extractReferenceCode(filename)
            newDoc = Document(filename)
            outputList.append(newDoc)
        except:
            print(str("skipping " + filename))
    return outputList

def addDocumentsToRegistrants(documentList, registrantDict):
    for document in documentList:
        if document.getAISFormsusername() not in usernamesToIgnore:
            registrant = registrantDict[document.getAISFormsusername()]
            registrant.addDocument(document)

# Setup 

registrantDict = makeRegistrantDict()
documentList = makeDocumentList()
addDocumentsToRegistrants(documentList,registrantDict)
for document in documentList:
    if document.getAISFormsusername() not in usernamesToIgnore:
        document.setNewFilename(document.createNewFilename(registrantDict))


def go():
    for document in documentList:
        try:
            if document.getDocumentType() not in docsToIgnore:
                document.rename()
            else:
                print(str("ignoring " + document.getOriginalFilename()))
        except:
            print("exception for " + document.getOriginalFilename())


def tPrint (registrantDict = registrantDict):
    for key in registrantDict:
        registrant = registrantDict[key]
        AISFormsAppReferenceCode = registrant.getAISFormsAppReferenceCode()
        AISFormsusername = registrant.getAISFormsusername()
        AISNumber = registrant.getAISNumber()
        documents = registrant.getDocuments()
        firstName = registrant.getFirstName()
        lastName = registrant.getLastName()
        print("###")
        printString =' '.join([firstName,lastName,AISNumber,AISFormsusername])
        print(printString)
        for document in documents:
            print document.getOriginalFilename()
