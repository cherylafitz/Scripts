#     def setUp(self):
#         self.list1 = ['a170117371.pdf', 'a1701173710.pdf', 'a170117372.pdf', 'a170117373.pdf', 'a170117374.pdf', 'a170117375.pdf', 'a170117376.pdf', 'a170117377.pdf',]
#         self.list2 = ['a1701173701.pdf', 'a1701173702.pdf', 'a1701173703.pdf', 'a1701173704.pdf', 'a1701173705.pdf', 'a1701173706.pdf', 'a1701173707.pdf', 'a1701173710.pdf',]


import unittest
import CLSAcceptDocumentRenamer

class RegistrantTests(unittest.TestCase):
    def setUp(self):
        self.registrantList = [["ZYUW4987","Cathi","Cherri","2013-001-000-3994"],["ZWCB5511","Hanna","Jonathan","2013-001-000-4015"],["ZXMD1445","Kaushal","Garima","2013-001-000-4059"],["ZWQH7668","Mitchell","John","2013-001-000-4098"],["ZVSY6414","Bloom","Andrew","2013-001-000-4318"],["ZXDA1488","Rivas","Gladys","2013-001-000-4400"],["ZYWG3121","Schuster","Justin","2013-001-000-4554"],["ZWTY9191","POCHTER","Andrew","2013-001-000-4648"],["ZYPK5716","Brundage","Clarissa","2013-001-000-4654"]]
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
        self.failUnless(self.testRegistrant.getFirstName() == "Cathi")

    def testGetLastName(self):
        self.failUnless(self.testRegistrant.getLastName() == "Cherri")

    def testGetAISNumber(self):
        self.failUnless(self.testRegistrant.getAISNumber() == "2013-001-000-3994")

    def testGetAISFormsAppReferenceCode(self):
        self.failUnless(self.testRegistrant.getAISFormsAppReferenceCode() == "ZYUW4987")

    def testGetAISFormsusername(self):
        self.failUnless(self.testRegistrant.getAISFormsusername() == "clcherri")

    def testGetDocuments(self):
        self.failUnless(self.testRegistrant.getDocuments() == [])


class DocumentTests(unittest.TestCase):
    def setUp(self):
        self.testDoc = CLSAcceptDocumentRenamer.Document("DRHM4372_UploadRulesAndRegulationsAgreement.zip")


    def testGetReferenceCode(self):
        self.failUnless(self.testDoc.getReferenceCode() == "DRHM4372")

    def testGetAISFormsusername(self):
        self.failUnless(self.testDoc.getAISFormsusername() == "adhitimb")

    def testGetDocumentType(self):
        self.failUnless(self.testDoc.getDocumentType() == "RulesandRegulations")

    def testGetFileFormat(self):
        self.failUnless(self.testDoc.getFileFormat() == "zip")




class findDocumentTypeTests(unittest.TestCase):
    def testFindDocumentType(self):
        self.failUnless(CLSAcceptDocumentRenamer.findDocumentType("AFKM5555_UploadMedicalInsuranceEvidence.JPG") == "MedicalInsurance")

class findFileFormatTests(unittest.TestCase):
    def testFindFileFormat(self):
        self.failUnless(CLSAcceptDocumentRenamer.findFileFormat("AFKM5555_UploadMedicalInsuranceEvidence.JPG") == "JPG")

class extractReferenceCodeTests(unittest.TestCase):
    def testExtractReferenceCode(self):
        self.failUnless(CLSAcceptDocumentRenamer.extractReferenceCode("AFKM5555_UploadMedicalInsuranceEvidence.JPG") == "AFKM5555")





if __name__ == '__main__':
    unittest.main()
