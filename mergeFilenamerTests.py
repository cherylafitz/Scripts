import unittest
import mergeFilenamer

class NumberExtractionTests(unittest.TestCase):
    def testSimple(self):
        self.failUnless(mergeFilenamer.getNumbersOutOfFilename('1234') == '1234')
    def testLettersFirst(self):
        self.failUnless(mergeFilenamer.getNumbersOutOfFilename('abc1234') == '1234')
    def testLettersLast(self):
        self.failUnless(mergeFilenamer.getNumbersOutOfFilename('1234acb') == '1234')
    def testLettersMid(self):
        self.failUnless(mergeFilenamer.getNumbersOutOfFilename('1afd234') == '1234')
    def testLettersInterspersed(self):
        self.failUnless(mergeFilenamer.getNumbersOutOfFilename('1a2d3f4') == '1234')
    def testPunctuationInterspersed(self):
        self.failUnless(mergeFilenamer.getNumbersOutOfFilename('s123..4/') == '1234')

class FindAdobeCodeTests(unittest.TestCase):
    def test201(self):
        self.failUnless(mergeFilenamer.findMatchingAdobeCode(201) == '2012501')
    def test142(self):
        self.failUnless(mergeFilenamer.findMatchingAdobeCode(143) == '10115043')
    def test343(self):
        self.failUnless(mergeFilenamer.findMatchingAdobeCode(343) == '30135043')
    def test584(self):
        self.failUnless(mergeFilenamer.findMatchingAdobeCode(585) == '55160035')
    def test687(self):
        self.failUnless(mergeFilenamer.findMatchingAdobeCode(687) == '65170037')
    def test872(self):
        self.failUnless(mergeFilenamer.findMatchingAdobeCode(872) == '85190022')
    def test50(self):
        self.failUnless(mergeFilenamer.findMatchingAdobeCode(50) == '15050')
    def test100(self):        
        self.failUnless(mergeFilenamer.findMatchingAdobeCode(100) == '5110050')


class FindLowerBoundTests(unittest.TestCase):
    def test1(self):
        self.failUnless(mergeFilenamer.findLowerBound(1) ==   1)
    def test5(self):
        self.failUnless(mergeFilenamer.findLowerBound(5) ==   1)
    def test9(self):
        self.failUnless(mergeFilenamer.findLowerBound(9) ==   1)
    def test13(self):
        self.failUnless(mergeFilenamer.findLowerBound(13) ==  1)
    def test17(self):
        self.failUnless(mergeFilenamer.findLowerBound(17) ==  1)
    def test21(self):
        self.failUnless(mergeFilenamer.findLowerBound(21) ==  1)
    def test25(self):
        self.failUnless(mergeFilenamer.findLowerBound(25) ==  1)
    def test29(self):
        self.failUnless(mergeFilenamer.findLowerBound(29) ==  1)
    def test33(self):
        self.failUnless(mergeFilenamer.findLowerBound(33) ==  1)
    def test37(self):
        self.failUnless(mergeFilenamer.findLowerBound(37) ==  1)
    def test41(self):
        self.failUnless(mergeFilenamer.findLowerBound(41) ==  1)
    def test45(self):
        self.failUnless(mergeFilenamer.findLowerBound(45) ==  1)
    def test49(self):
        self.failUnless(mergeFilenamer.findLowerBound(49) ==  1)
    def test50(self):
        self.failUnless(mergeFilenamer.findLowerBound(50) ==  1)
    def test53(self):
        self.failUnless(mergeFilenamer.findLowerBound(53) ==  51)
    def test57(self):
        self.failUnless(mergeFilenamer.findLowerBound(57) ==  51)
    def test61(self):
        self.failUnless(mergeFilenamer.findLowerBound(61) ==  51)
    def test65(self):
        self.failUnless(mergeFilenamer.findLowerBound(65) ==  51)
    def test69(self):
        self.failUnless(mergeFilenamer.findLowerBound(69) ==  51)
    def test73(self):
        self.failUnless(mergeFilenamer.findLowerBound(73) ==  51)
    def test77(self):
        self.failUnless(mergeFilenamer.findLowerBound(77) ==  51)
    def test81(self):
        self.failUnless(mergeFilenamer.findLowerBound(81) ==  51)
    def test85(self):
        self.failUnless(mergeFilenamer.findLowerBound(85) ==  51)
    def test89(self):
        self.failUnless(mergeFilenamer.findLowerBound(89) ==  51)
    def test93(self):
        self.failUnless(mergeFilenamer.findLowerBound(93) ==  51)
    def test97(self):
        self.failUnless(mergeFilenamer.findLowerBound(97) ==  51)
    def test101(self):
        self.failUnless(mergeFilenamer.findLowerBound(101) == 101)
    def test105(self):
        self.failUnless(mergeFilenamer.findLowerBound(105) == 101)
    def test109(self):
        self.failUnless(mergeFilenamer.findLowerBound(109) == 101)
    def test113(self):
        self.failUnless(mergeFilenamer.findLowerBound(113) == 101)

class findSequenceNumberFromDict(unittest.TestCase):
    def setUp(self):
        self.dict = mergeFilenamer.makeAdobeCodeDict()
    def test2012501(self):
        self.failUnless(self.dict['2012501'] == 201)
    def test10115043(self):
        self.failUnless(self.dict['10115043'] == 143)
    def test30135043(self):
        self.failUnless(self.dict['30135043'] == 343)
    def test55160035(self):
        self.failUnless(self.dict['55160035'] == 585)
    def test65170037(self):
        self.failUnless(self.dict['65170037'] == 687)
    def test85190022(self):
        self.failUnless(self.dict['85190022'] == 872)
    def test15050(self):
        self.failUnless(self.dict['15050'] == 50)
    def test5110050(self):
        self.failUnless(self.dict['5110050'] == 100)

class nonStandardSortFixTests(unittest.TestCase):

    def setUp(self):
        self.list1 = ['a170117371.pdf', 'a1701173710.pdf', 'a170117372.pdf', 'a170117373.pdf', 'a170117374.pdf', 'a170117375.pdf', 'a170117376.pdf', 'a170117377.pdf',]
        self.list2 = ['a1701173701.pdf', 'a1701173702.pdf', 'a1701173703.pdf', 'a1701173704.pdf', 'a1701173705.pdf', 'a1701173706.pdf', 'a1701173707.pdf', 'a1701173710.pdf',]

    def testSortFix(self):
       self.failUnless(mergeFilenamer.nonStandardSortFix(self.list1) == self.list2)

if __name__ == '__main__':
    unittest.main()
