/**
 * Simple TCP client.
 * Connects to a server, sends a message, and receives a response.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#define PORT_NUMBER 1500
#define MAX_BUFFER 80
#define MESSAGE "Hello, Server!"

int main(int argc, char *argv[]){
    char buffer[MAX_BUFFER + 1];
    struct hostent *server_host;
    struct sockaddr_in server_address;
    int socket_fd;

    if (argc < 2){
        printf("Usage: %s <server address>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    if ((server_host = gethostbyname(argv[1])) == NULL){
        fprintf(stderr, "Error: gethostbyname failed (%s)\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    memset(&server_address, 0, sizeof(server_address));
    memcpy(&server_address.sin_addr, server_host->h_addr, server_host->h_length);
    server_address.sin_family = server_host->h_addrtype;
    server_address.sin_port = htons(PORT_NUMBER);

    if((socket_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0){
        fprintf(stderr, "Error: socket creation failed (%s)\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    if (connect(socket_fd, (struct sockaddr*)&server_address, sizeof(server_address)) < 0){
        fprintf(stderr, "Error: connect failed (%s)\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    send(socket_fd, MESSAGE, strlen(MESSAGE), 0);

    if(recv(socket_fd, buffer, sizeof(buffer), 0) < 0){
        fprintf(stderr, "Error: recv failed (%s)\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    printf("Server response: %s \n", buffer);
    close(socket_fd);
    printf("Client has finished its work \n");
    exit(EXIT_SUCCESS);
}
