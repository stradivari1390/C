/** 
 * unix_domain_server.c
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

char buffer[MAX_BUFFER_SIZE];

int main() {
    struct sockaddr_un server_address, client_address;
    int socket_fd;
    int server_len, client_len, max_client_len, num_bytes;

    if ((socket_fd = socket(AF_UNIX, SOCK_DGRAM, 0)) < 0) {
        perror("Failed to create socket");
        exit(EXIT_FAILURE);
    }

    unlink(SERVER_PATH);

    memset(&server_address, 0, sizeof(server_address));
    server_address.sun_family = AF_UNIX;
    strncpy(server_address.sun_path, SERVER_PATH, sizeof(server_address.sun_path) - 1);

    server_len = sizeof(server_address.sun_family) + strlen(server_address.sun_path);

    if (bind(socket_fd, (struct sockaddr *)&server_address, server_len) < 0) {
        perror("Failed to bind socket");
        exit(EXIT_FAILURE);
    }

    max_client_len = sizeof(client_address);

    for (;;) {
        client_len = max_client_len;
        num_bytes = recvfrom(socket_fd, buffer, MAX_BUFFER_SIZE, 0, (struct sockaddr *)&client_address, &client_len);

        if (num_bytes < 0) {
            perror("Failed to receive message");
            exit(EXIT_FAILURE);
        }

        if (sendto(socket_fd, buffer, num_bytes, 0, (struct sockaddr *)&client_address, client_len) != num_bytes) {
            perror("Failed to send message");
            exit(EXIT_FAILURE);
        }
    }

    exit(EXIT_SUCCESS);
}
