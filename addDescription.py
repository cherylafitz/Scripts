from pyPdf import PdfFileWriter, PdfFileReader
import pyPdf
import os

def getFiles():
    return [file for file in os.listdir('.')]

try:
    os.mkdir("output")
except:
    pass

def combinePdfs(doc1,doc2):
    output = PdfFileWriter()
    pieces = [doc1,doc2]
    # for piece in pieces:
    #     if isPdfEncrypted(piece) == True:
    #         raise Exception(piece)
    for piece in pieces:
#        if isPdfEncrypted(piece) == False:
        input = PdfFileReader(file(piece, "rb"))
        numPages = input.getNumPages()
        for page in range (numPages):
            output.addPage(input.getPage(page))
        # else:
        #     print "skipping", piece
        outputName = "output/" + doc1
        outputStream = file(outputName, "wb")
        output.write(outputStream)
        outputStream.close()

description = "Description.pdf"

def go():
    for filename in getFiles():
        if filename != description:
            try:
                combinePdfs(filename,description)
            except:
                pass
