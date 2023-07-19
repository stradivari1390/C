/** 
 * unix_domain_client.c
 * This program creates a UNIX domain datagram socket, binds a name to it, 
 * then reads from the socket.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>

#define MAX_BUFFER_SIZE 256
#define SERVER_PATH "./echo.server"
#define CLIENT_PATH "/tmp/clnt.XXXXXX"

char buffer[MAX_BUFFER_SIZE];
char *message = "Hello Server!";

int main() {
    struct sockaddr_un server_address, client_address;
    int socket_fd;
    int server_len, client_len, message_len;

    memset(&server_address, 0, sizeof(server_address));
    server_address.sun_family = AF_UNIX;
    strncpy(server_address.sun_path, SERVER_PATH, sizeof(server_address.sun_path) - 1);

    server_len = sizeof(server_address.sun_family) + strlen(server_address.sun_path);

    if ((socket_fd = socket(AF_UNIX, SOCK_DGRAM, 0)) < 0) {
        perror("Failed to create socket");
        exit(EXIT_FAILURE);
    }

    memset(&client_address, 0, sizeof(client_address));
    client_address.sun_family = AF_UNIX;
    strncpy(client_address.sun_path, CLIENT_PATH, sizeof(client_address.sun_path) - 1);

    if (mkstemp(client_address.sun_path) == -1) {
        perror("Failed to create unique temporary filename");
        exit(EXIT_FAILURE);
    }

    client_len = sizeof(client_address.sun_family) + strlen(client_address.sun_path);

    if (bind(socket_fd, (struct sockaddr *)&client_address, client_len) < 0) {
        perror("Failed to bind socket");
        exit(EXIT_FAILURE);
    }

    message_len = strlen(message);

    if (sendto(socket_fd, message, message_len, 0, (struct sockaddr *)&server_address, server_len) != message_len) {
        perror("Failed to send message");
        exit(EXIT_FAILURE);
    }

    exit(EXIT_SUCCESS);
}
