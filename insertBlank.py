# -*- coding: utf-8 -*-

from pyPdf import PdfFileReader, PdfFileWriter
import re
import os

blankPage = file("blank.pdf", "rb")

def do_nothing():
    pass

try:
    os.mkdir("output")
except:
    do_nothing()

def findPdfs():
    files = os.listdir(".")
    output = []
    for filename in files:
        if ".pdf" in filename:
            output.append(filename)
    return output

def findOddPdfs(pdfList):
    allPdfs = findPdfs()
    output = []
    for pdf in allPdfs:
        reader = PdfFileReader(file(pdf, "rb"))
        pages = reader.getNumPages()
        if pages % 2 != 0 and pdf != 'blank.pdf':
            output.append(pdf)
    return output

def addBlankPages(pdfList):
    for filename in pdfList:
        output = PdfFileWriter()
        input_file = PdfFileReader(file(filename, "rb"))
        numPages = input_file.getNumPages()
        for page in range (numPages):
            output.addPage(input_file.getPage(page))
        output.addPage(PdfFileReader(blankPage).getPage(0))
        output_filename = "".join(["output", "/", filename])
        output_stream = file(output_filename, "wb")
        output.write(output_stream)
        output_stream.close()



def main():
    allPdfs = findPdfs()
    oddPdfs = findOddPdfs(allPdfs)
    addBlankPages(oddPdfs)

