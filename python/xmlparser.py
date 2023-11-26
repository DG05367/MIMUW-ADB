# -*- coding: utf-8 -*-

from xml.sax import parse
from xml.sax.handler import ContentHandler
import csv
import logging as log
import sys

PUBLICATION_TAGNAMES = {
    'article',
    'inproceedings',
    'proceedings',
    'book',
    'incollection',
    'phdthesis',
    'mastersthesis',
    'www',
    'data'
}

ALLOWEDTAGS = ['booktitle','pages','year','address','journal','volume','number','month','ee','cdrom','publisher','crossref','isbn','school','chapter','publnr','stream', 'note', 'cite', 'url']

PERSON_TAGNAMES = {
    'author',
    'editor'
}

def isCorrectPubData(elementTag):
    return elementTag in ALLOWEDTAGS

def startsWithCorrect(citeText):
    return (citeText.startswith('books') or citeText.startswith('journals') or citeText.startswith('conf') or citeText.startswith('reference') or citeText.startswith('series') or citeText.startswith('www') or citeText.startswith('person'))

def isCite(citeText):
    return (citeText.count('/') >= 1 and startsWithCorrect(citeText))


class PublicationHandler(ContentHandler):
    def __init__(self):
        self.key = ""
        self.mdate = "" 
        self.publtype = ""
        self.cdate = ""
        self.type = ""  
        self.rating = "" 
        self.reviewid = ""
        self.dataList = ['key', 'type', 'mdate', 'type', 'publtype','cdate', 'rating', 'reviewid'] + ALLOWEDTAGS
        self.dictionary = {};
        self.current_element = ''

    def startElement(self, tag, attrs):
        self.type = tag
        if tag in PUBLICATION_TAGNAMES:
            for attrkey in self.dataList:
                if attrkey == 'type':
                    self.dictionary[attrkey] = tag
                elif attrkey in attrs.keys():
                    self.dictionary[attrkey] = attrs[attrkey]
                else:
                    self.dictionary[attrkey] = "null"
        elif isCorrectPubData:
            self.metaDataType = tag
        else:
            self.metaDataType = ""

    def endElement(self, tag):
        if isCorrectPubData(tag):
            self.dictionary[tag] = self.current_element.strip()
            self.current_element = ""
        if tag in PUBLICATION_TAGNAMES:
           writer.writerow(self.dictionary.values())
           print(f"CURRENT: {self.dictionary}")

    def characters(self, content):
        if (content.strip() != "") & (isCorrectPubData(self.metaDataType)):
            self.current_element += content.replace('\'', '`').replace(',', ';')

    
class PersonHandler(ContentHandler):
    def __init__(self):
        self.id = 1
        self.name = ""
        self.bibtex = ""
        self.orcid = ""
        self.label = ""
        self.type = ""
        self.dataList = ['id','name','bibtex','orcid','label','type']
        self.dictionary = {}
        self.personDictionary = {}
        self.current_element = ""
        self.attrs = ""
      
    def startElement(self, tag, attrs):
        if tag in PERSON_TAGNAMES:
            self.current_element = tag
            self.attrs = attrs
        else:
            self.current_element = ""

    def endElement(self, tag):
        if (self.current_element in PERSON_TAGNAMES):
            if (self.name not in self.personDictionary):
                self.personDictionary[self.name] = self.id
                for attrKey in self.dataList:
                    if attrKey == 'id':
                        self.dictionary[attrKey] = self.id
                        self.id += 1
                    elif attrKey == 'name':
                        self.dictionary[attrKey] = self.name
                    elif attrKey in self.attrs.keys():
                        self.dictionary[attrKey] = self.attrs[attrKey].replace('\'', '`').replace(',', ';')
                    else:
                        self.dictionary[attrKey] = "null"
                writer.writerow(self.dictionary.values())
                print(f"CURRENT: {self.dictionary}\n")

        self.name = ""
        
    def characters(self, content):
        if (content.strip() != "") & (self.current_element == 'author' or self.current_element == 'editor'):
            self.name += content.replace('\'', '`').replace(',', ';')


class TitleHandler(ContentHandler):
    def __init__(self):
        self.publication_key = ""
        self.attrs = ""
        self.type = ""
        self.title = ""
        self.dataList = ['id','title','bibtex','label','type', 'publication_key']
        self.dictionary = {};
        self.counter = 1
      
    
    def startElement(self, tag, attrs):
        if tag in PUBLICATION_TAGNAMES:
            self.publication_key = attrs["key"]
        if tag == 'title':
            self.attrs = attrs
            self.type = tag
        else:
            self.title = ""

    def endElement(self, tag):
        if tag == 'title':
            for attrKey in self.dataList:
                if attrKey == 'id':
                    self.dictionary[attrKey] = self.counter
                    self.counter = self.counter +1
                elif attrKey == 'title':
                    self.dictionary[attrKey] = self.title
                elif attrKey == "publication_key":
                    self.dictionary[attrKey] = self.publication_key
                elif attrKey in self.attrs.keys():
                    self.dictionary[attrKey] = self.attrs[attrKey].replace('\'', '`').replace(',', ';')
                else:
                    self.dictionary[attrKey] = "null"
            writer.writerow(self.dictionary.values())
            print(f"MDATE: {self.dictionary}")
            self.title = ""
        
            
    def characters(self, content):
        if (content.strip() != "") & (self.type == "title"):
            self.title += content.replace('\'', '`').replace(',', ';')

class RelHandler(ContentHandler):
    def __init__(self):
        self.publication_key = ""
        self.attrs = ""
        self.type = ""
        self.rel = ""
        self.dataList = ['id','rel','label','type','uri','sort','publication_key']
        self.dictionary = {};
        self.counter = 1
      
    
    def startElement(self, tag, attrs):
        if tag in PUBLICATION_TAGNAMES:
            self.publication_key = attrs["key"]
        if tag == 'rel':
            self.attrs = attrs
            self.type = tag
        else:
            self.rel = ""

    def endElement(self, tag):
        if tag == 'rel':
            for attrKey in self.dataList:
                if attrKey == 'id':
                    self.dictionary[attrKey] = self.counter
                    self.counter = self.counter +1
                elif attrKey == 'rel':
                    self.dictionary[attrKey] = self.rel
                elif attrKey == "publication_key":
                    self.dictionary[attrKey] = self.publication_key
                elif attrKey in self.attrs.keys():
                    self.dictionary[attrKey] = self.attrs[attrKey].replace('\'', '`').replace(',', ';')
                else:
                    self.dictionary[attrKey] = "null"
            writer.writerow(self.dictionary.values())
            print(f"MDATE: {self.dictionary}")
            self.rel = ""
        
            
    def characters(self, content):
        if (content.strip() != "") & (self.type == "rel"):
            self.rel += content.replace('\'', '`').replace(',', ';')

        
class SeriesHandler(ContentHandler):
    def __init__(self):
        self.publication_key = ""
        self.attrs = ""
        self.type = ""
        self.series = ""
        self.dataList = ['id','series','href','label','type','publication_key']
        self.dictionary = {};
        self.counter = 1
      
    
    def startElement(self, tag, attrs):
        if tag in PUBLICATION_TAGNAMES:
            self.publication_key = attrs["key"]
        if tag == 'series':
            self.attrs = attrs
            self.type = tag
        else:
            self.series = ""

    def endElement(self, tag):
        if tag == 'series':
            for attrKey in self.dataList:
                if attrKey == 'id':
                    self.dictionary[attrKey] = self.counter
                    self.counter = self.counter +1
                elif attrKey == 'series':
                    self.dictionary[attrKey] = self.series
                elif attrKey == "publication_key":
                    self.dictionary[attrKey] = self.publication_key
                elif attrKey in self.attrs.keys():
                    self.dictionary[attrKey] = self.attrs[attrKey].replace('\'', '`').replace(',', ';')
                else:
                    self.dictionary[attrKey] = "null"
            writer.writerow(self.dictionary.values())
            print(f"MDATE: {self.dictionary}")
            self.series = ""
        
            
    def characters(self, content):
        if (content.strip() != "") & (self.type == "series"):
            self.series += content.replace('\'', '`').replace(',', ';')
            
            
class CiteHandler(ContentHandler):
    def __init__(self):
        self.publication_key = ""
        self.attrs = ""
        self.type = ""
        self.cite = ""
        self.dataList = ['id','cite','aux','label','type','ref','publication_key']
        self.dictionary = {};
        self.counter = 1
      
    
    def startElement(self, tag, attrs):
        if tag in PUBLICATION_TAGNAMES:
            self.publication_key = attrs["key"]
        if tag == 'cite':
            self.attrs = attrs
            self.type = tag
        else:
            self.cite = ""
    

    def endElement(self, tag):
        if tag == 'cite' and isCite(self.cite):
            for attrKey in self.dataList:
                if attrKey == 'id':
                    self.dictionary[attrKey] = self.counter
                    self.counter = self.counter +1
                elif attrKey == 'cite':
                    self.dictionary[attrKey] = self.cite
                elif attrKey == "publication_key":
                    self.dictionary[attrKey] = self.publication_key
                elif attrKey in self.attrs.keys():
                    self.dictionary[attrKey] = self.attrs[attrKey].replace('\'', '`').replace(',', ';')
                else:
                    self.dictionary[attrKey] = "null"
            writer.writerow(self.dictionary.values())
            print(f"CURRENT: {self.dictionary}")
        
            
    def characters(self, content):
        if (content.strip() != "") & (self.type == "cite"):
            self.cite = content.strip().replace('\'', '`').replace(',', ';')
      
      
class PersonPublicationHandler(ContentHandler):
    def __init__(self):
        self.publication_key = ""
        self.attrs = ""
        self.type = ""
        self.orderedList = ['relation_id','role','person_id','publication_key']
        self.attrDict = {};
        self.counter = 1
        self.counterDict = 1
        self.person = ""
        self.personDict = {}
      
    
    def startElement(self, tag, attrs):
        if tag in PUBLICATION_TAGNAMES:
            self.publication_key = attrs["key"]
        if tag in PERSON_TAGNAMES:
            self.type = tag
            self.attrs = attrs
        else:
            self.type = ""

            
    def endElement(self, tag):
        if tag in PERSON_TAGNAMES:
            if self.person not in self.personDict:
                self.personDict[self.person] = self.counterDict
                self.counterDict = self.counterDict +1
            for attrKey in self.orderedList:
                if attrKey == 'relation_id':
                    self.attrDict[attrKey] = self.counter
                    self.counter = self.counter +1
                elif attrKey == 'role':
                    self.attrDict[attrKey] = tag
                elif attrKey == 'person_id':
                    self.attrDict[attrKey] = self.personDict[self.person]
                elif attrKey == 'publication_key':
                    self.attrDict[attrKey] = self.publication_key
                else:
                    self.attrDict[attrKey] = "null"
            writer.writerow(self.attrDict.values())
            print(f"CURRENT: {self.attrDict}")
        
            self.person = ""
        
            
    def characters(self, content):
        if (content.strip() != "") and (self.type == "author" or self.type == 'editor'):
            self.person += content.replace('\'', '`').replace(',', ';')

if __name__ == '__main__':
    if len(sys.argv) < 1:
        log.error(f"Usage: {sys.argv[0]} [target] [filename]\n[target]: publication, person, noteurlcite, series, title, rel\n[filename]: path to .xml file")
        exit(2)
        
    target = sys.argv[1]

    filename = "../dataset/dblp.xml"
    
    if target == 'publication':
        f = open('../dataset/parsed/publication.csv', 'w')
        writer = csv.writer(f)
        parse(filename, PublicationHandler())   
        
    elif target == 'person':
        f = open('../dataset/parsed/person.csv', 'w')
        writer = csv.writer(f)
        parse(filename, PersonHandler())      
        
    elif target == 'series':
        f = open('../dataset/parsed/series.csv', 'w')
        writer = csv.writer(f)
        parse(filename, SeriesHandler())
        
    elif target == 'title':
        f = open('../dataset/parsed/title.csv', 'w')
        writer = csv.writer(f)
        parse(filename, TitleHandler())
        
    elif target == 'rel':
        f = open('../dataset/parsed/rel.csv', 'w')
        writer = csv.writer(f)
        parse(filename, RelHandler())
        
    elif target == 'cite':
        f = open('../dataset/parsed/cite.csv', 'w')
        writer = csv.writer(f)
        parse(filename, CiteHandler())
        
    elif target == 'personpublication':
        f = open('../dataset/parsed/person_publication.csv', 'w')
        writer = csv.writer(f)
        parse(filename, PersonPublicationHandler())
        
    f.close()
