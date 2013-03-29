import re

def extractReferenceCode(filename):
    '''
    takes filename as string
    returns reference code as string in format AAAA1111
    '''
    regex = re.compile('[A-Z]{4}[\d]{4}')
    result = regex.findall(filename)
    print result
    print len(result)
    if len(result) != 1:
        raise Exception
    if len(result[0]) != 8:
        raise Exception
    return result[0]

    # [A-Z]