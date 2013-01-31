#! /usr/bin/env python

# Copyright 2003 (c) Alberto Ferrarini

import re
import sys
import string


class Entry:
    def __init__(self):
        self.kind = ''
        self.key = ''
        self.attribs = {}

    def __str__(self):
        a = ''
        for attrib in self.attribs:
            a = a + attrib + ": {" + self.attribs[attrib] + "}\n"
        return self.kind + "\nkey: " + self.key + "\n" + a

class BibParser:
    def __init__(self):
        self.entries = []
        self.entry = re.compile(r"@(.+)?\{.*?,")
        self.attrib = re.compile(r"(?:\s*(.*?)\s*=\s*\{\s*(.*)\s*\}\s*[,\}])")

    def __toupleListToDic(self, list):
        dict={}
        for touple in list:
            dict[touple[0]]=touple[1]
        return dict

    def __listAttribs(self,s):
        attribs=[]
        mtchobj = self.attrib.search(s)
        if mtchobj:
            attribs.append((mtchobj.group(1), mtchobj.group(2)))
            attribs = attribs + self.__listAttribs(s[mtchobj.end(2):])
        return attribs

    def feed(self, s):
        entrysplit = self.entry.split(s)
        entrysplit.pop(0)
        i = 0
        while 1:
            if not len(entrysplit): break
            entry = Entry()
            entry.kind = entrysplit.pop(0)
            entry.attribs = self.__toupleListToDic(self.__listAttribs(entrysplit.pop(0)))
            self.entries.append(entry)
        return self.entries


class KeyGen:
    def __init__(self):
        self.entries = []
        self.keys = []

    def getFirstAuthor(self, author):
        authorslist = string.split(author, "and")
        first = string.split(string.strip(authorslist[0]))
        if len(self.rems(first[-1]))>1:
            return first[-1]
        else:
            return self.rems(first[0])

    def rems(self, s):
        return re.sub("[\s,.\{]","",s)

    def mkkey(self, entry, i=0):
        if "author" in entry.attribs:
            key = string.lower(self.getFirstAuthor(entry.attribs["author"]))
        else:
            key = self.rems(string.lower(entry.attribs["title"]))[0:5]
        if "year" in entry.attribs:
            key = key + entry.attribs["year"]
        if key in self.keys:
            key = key + string.lowercase[i]
            if key in self.keys:
                key = self.mkkey(entry, i+1)
        self.keys.append(key)
        return key

    def gen(self, entries):
        for entry in entries:
            entry.key = self.mkkey(entry)
        return entries

def printBib(entries):
    for entry in entries:
        print "@" + entry.kind + "{" + entry.key + ","
        i = len(entry.attribs)
        for attrib in entry.attribs:
            print "     " + attrib + " = {",
#            if attrib == "title":
#                print "{",
            print  entry.attribs[attrib],
#            if attrib == "title":
#                print "}",
            i = i - 1
            if i:
                print "},"
            else:
                print "}\n}"
        
if __name__=="__main__":
    if sys.argv[1:]:
        input = open(sys.argv[1])
    else:
        input = sys.stdin
    content=input.read()
    input.close()
    bp = BibParser()
    entries = bp.feed(content)
    kg = KeyGen()
    printBib(kg.gen(entries))
