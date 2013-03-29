import recRenamer
import unittest

class RefcodeExtractionTests(unittest.TestCase):
    def testACKZ1714(self):
        self.failUnless(recRenamer.extractReferenceCode('NSLIY_ConfidentialTeacherRecommendation_ACKZ1714_Charles_Dugall.pdf') == 'ACKZ1714')
    def testZVUG4972(self):
        self.failUnless(recRenamer.extractReferenceCode('NSLIY_Parent_LegalGuardianStatement_ZVUG4972_Mickey_Mouse.pdf') == 'ZVUG4972')
    def testSBEJ7375(self):
        self.failUnless(recRenamer.extractReferenceCode('NSLIY_Parent_LegalGuardianStatement_SBEJ7375_Theron_Charlize') == 'SBEJ7375')
    def testCEMF4182(self):
        self.failUnless(recRenamer.extractReferenceCode('NSLIY_ConfidentialTeacherRecommendation_CEMF4182_Winter_OldMan') == 'CEMF4182')

class getFilesToRenameTest(unittest.TestCase):
    pass

class getNewNameTest(unittest.TestCase):
    def testZVYH6426(self):
        self.failUnless(recRenamer.getNewName('NSLIY_Parent_LegalGuardianStatement_ZVYH6426_Stewart_David') == 'FBJR8119-Parent-ZVYH6426')
    def testPAWB4267(self):
        self.failUnless(recRenamer.getNewName('NSLIY_Parent_LegalGuardianStatement_PAWB4267_Lai_Dominic') == 'AVAJ8333-Parent-PAWB4267')
    def testMSXJ5991(self):
        self.failUnless(recRenamer.getNewName('NSLIY_ConfidentialTeacherRecommendation_MSXJ5991_Gathje_Rochelle_') == 'SSKS5226-Teacher-MSXJ5991')





if __name__ == '__main__':
    unittest.main()




