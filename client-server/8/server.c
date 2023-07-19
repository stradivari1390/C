/**
 * This file contains the server-side code for a UNIX domain socket.
 * The server receives a message from the client and sends back an echo of the message.
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#define MAX_BUFFER_SIZE 256

int main() {
    struct sockaddr_un server_address, client_address;
    int socket_file_descriptor;
    int server_address_length, client_address_length, max_client_address_length, received_length;

    if ((socket_file_descriptor = socket(AF_UNIX, SOCK_DGRAM, 0)) < 0) {
        perror("Failed to create socket");
        exit(EXIT_FAILURE);
    }

    unlink("./echo.server");

    memset(&server_address, 0, sizeof(server_address));
    server_address.sun_family = AF_UNIX;
    strcpy(server_address.sun_path, "./echo.server");
    server_address_length = sizeof(server_address.sun_family) + strlen(server_address.sun_path);

    if (bind(socket_file_descriptor, (struct sockaddr *) &server_address, server_address_length) < 0) {
        perror("Failed to connect socket to address");
        exit(EXIT_FAILURE);
    }

    max_client_address_length = sizeof(client_address);

    for (;;) {
        char buffer[MAX_BUFFER_SIZE];
        client_address_length = max_client_address_length;
        received_length = recvfrom(socket_file_descriptor, buffer, MAX_BUFFER_SIZE, 0, (struct sockaddr *) &client_address, &client_address_length);

        if (received_length < 0) {
            perror("Failed to receive message");
            exit(EXIT_FAILURE);
        }

        if (sendto(socket_file_descriptor, buffer, received_length, 0, (struct sockaddr *) &client_address, client_address_length) != received_length) {
            perror("Failed to send message");
            exit(EXIT_FAILURE);
        }
    }
}
