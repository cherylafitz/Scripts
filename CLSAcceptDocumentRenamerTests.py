# -*- coding: utf-8 -*-
#     def setUp(self):
#         self.list1 = ['a170117371.pdf', 'a1701173710.pdf', 'a170117372.pdf', 'a170117373.pdf', 'a170117374.pdf', 'a170117375.pdf', 'a170117376.pdf', 'a170117377.pdf',]
#         self.list2 = ['a1701173701.pdf', 'a1701173702.pdf', 'a1701173703.pdf', 'a1701173704.pdf', 'a1701173705.pdf', 'a1701173706.pdf', 'a1701173707.pdf', 'a1701173710.pdf',]


import unittest
import CLSAcceptDocumentRenamer

class RegistrantTests(unittest.TestCase):
    def setUp(self):
        self.registrantList = [["ZYUW4987","Cherri","Cathi","2013-001-000-3994"]]
        self.registrantDict = CLSAcceptDocumentRenamer.makeRegistrantDict(self.registrantList)
        # print self.registrantDict
        self.testRegistrant = self.registrantDict['clcherri']
        # self.registrantDict = {}
        # for reg in self.registrantList:
        #     print "for block"
        #     newReg = CLSAcceptDocumentRenamer.Registrant(reg[0],reg[1],reg[2],reg[3])
        #     print newReg
        #     self.registrantDict[CLSAcceptDocumentRenamer.getUsername(reg[0])] = newReg
        #     print self.registrantDict
        # print self.testRegistrant

    def testGetFirstName(self):
        # print(self.testRegistrant.getFirstName())
        self.failUnless(self.testRegistrant.getFirstName() == "Cathi")

    def testGetLastName(self):
        # print(self.testRegistrant.getLastName())
        self.failUnless(self.testRegistrant.getLastName() == "Cherri")

    def testGetAISNumber(self):
        self.failUnless(self.testRegistrant.getAISNumber() == "2013-001-000-3994")

    def testGetAISFormsAppReferenceCode(self):
        self.failUnless(self.testRegistrant.getAISFormsAppReferenceCode() == "ZYUW4987")

    def testGetAISFormsUsername(self):
        self.failUnless(self.testRegistrant.getAISFormsUsername() == "clcherri")

    def testGetDocuments(self):
        self.failUnless(self.testRegistrant.getDocuments() == [])

    def testGetOrganization(self):
        self.failUnless(self.testRegistrant.getAISFormsUsername() == "clcherri")


class DocumentTests(unittest.TestCase):
    def setUp(self):
        self.testDoc = CLSAcceptDocumentRenamer.Document("DRHM4372_UploadRulesAndRegulationsAgreement.zip")

    def testGetReferenceCode(self):
        self.failUnless(self.testDoc.getReferenceCode() == "DRHM4372")

    def testGetAISFormsUsername(self):
        self.failUnless(self.testDoc.getAISFormsUsername() == "adhitimb")

    def testGetDocumentType(self):
        self.failUnless(self.testDoc.getDocumentType() == "RulesandRegulations")

    def testGetFileFormat(self):
        self.failUnless(self.testDoc.getFileFormat() == "zip")

    def testGetAISDocumentID(self):
        print(self.testDoc.getAISDocumentID())
        self.failUnless(self.testDoc.getAISDocumentID() == "RR")

class findDocumentTypeTests(unittest.TestCase):
    def testFindDocumentType(self):
        self.failUnless(CLSAcceptDocumentRenamer.findDocumentType("AFKM5555_UploadMedicalInsuranceEvidence.JPG") == "MedicalInsurance")

class findFileFormatTests(unittest.TestCase):
    def testFindFileFormat(self):
        self.failUnless(CLSAcceptDocumentRenamer.findFileFormat("AFKM5555_UploadMedicalInsuranceEvidence.JPG") == "JPG")

class extractReferenceCodeTests(unittest.TestCase):
    def testExtractReferenceCode(self):
        self.failUnless(CLSAcceptDocumentRenamer.extractReferenceCode("AFKM5555_UploadMedicalInsuranceEvidence.JPG") == "AFKM5555")

class organizationTests(unittest.TestCase):
    def setUp(self):
        # registrantDict = CLSAcceptDocumentRenamer.makeRegistrantDict()
        # print(CLSAcceptDocumentRenamer.registrantDict)
        self.OSUSample = CLSAcceptDocumentRenamer.registrantDict["jkj0112"]
        self.OUSample = CLSAcceptDocumentRenamer.registrantDict["HuntAC"]
        self.ACIESample = CLSAcceptDocumentRenamer.registrantDict["n115k294"]
    def testOrganizationAfterSettingOSU(self):
        print(self.OSUSample.getOrganization())
        self.failUnless(self.OSUSample.getOrganization() == "Ohio State")
    def testOrganizationAfterSettingOU(self):        
        print(self.OUSample.getOrganization())
        self.failUnless(self.OUSample.getOrganization() == "Ohio University")
    def testOrganizationAfterSettingAC(self):        
        print(self.ACIESample.getOrganization())
        self.failUnless(self.ACIESample.getOrganization() == "American Councils")

def go():
    unittest.main()


if __name__ == '__main__':
    go()

