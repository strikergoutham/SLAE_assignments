#Crypter AES - 256
#Author : goutham madhwaraj

import base64
import hashlib
from Crypto.Cipher import AES
from Crypto import Random
from ctypes import *
import sys
import argparse


parser = argparse.ArgumentParser()
parser.add_argument('-k', "--key", help='secret key used to encrypt shellcode')
parser.add_argument('-s', "--shellcode", help='shellcode should have \ escaped ')

args = parser.parse_args()

if args.key == None and args.shellcode == None :
    parser.print_help()
    exit()

print("Pycrypto AES-256 crypter\n")

secret = args.key
shellcode = args.shellcode

print("provided key :\t",secret,"\n")
print("provided shellcode :\t",shellcode,"\n")

BLOCK_SIZE = 16
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * chr(BLOCK_SIZE - len(s) % BLOCK_SIZE)
unpad = lambda s: s[:-ord(s[len(s) - 1:])]

def encrypt(raw, password):
    private_key = hashlib.sha256(password.encode("utf-8")).digest()
    raw = pad(raw)
    iv = Random.new().read(AES.block_size)
    cipher = AES.new(private_key, AES.MODE_CBC, iv)
    return base64.b64encode(iv + cipher.encrypt(raw))




shellcode_encrypted = encrypt(shellcode, secret)
print("encrypted shellcode :\t",shellcode_encrypted)
