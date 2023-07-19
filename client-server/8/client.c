/**
 * This file contains the client-side code for a UNIX domain socket.
 * The client sends a message to the server and receives an echo of the message.
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
    int server_address_length, client_address_length, message_length, received_length;
    char *message = "Promote peace, not spam\n";
    char buffer[MAX_BUFFER_SIZE];

    memset(&server_address, 0, sizeof(server_address));
    server_address.sun_family = AF_UNIX;
    strcpy(server_address.sun_path, "./echo.server");
    server_address_length = sizeof(server_address.sun_family) + strlen(server_address.sun_path);

    if ((socket_file_descriptor = socket(AF_UNIX, SOCK_DGRAM, 0)) < 0) {
        perror("Failed to create socket");
        exit(EXIT_FAILURE);
    }

    memset(&client_address, 0, sizeof(client_address));
    client_address.sun_family = AF_UNIX;
    strcpy(client_address.sun_path, "/tmp/client.XXXXXX");
    mkstemp(client_address.sun_path);
    client_address_length = sizeof(client_address.sun_family) + strlen(client_address.sun_path);

    if (bind(socket_file_descriptor, (struct sockaddr *) &client_address, client_address_length) < 0) {
        perror("Failed to connect socket");
        exit(EXIT_FAILURE);
    }

    message_length = strlen(message);

    if (sendto(socket_file_descriptor, message, message_length, 0, (struct sockaddr *) &server_address, server_address_length) != message_length) {
        perror("Failed to send message");
        exit(EXIT_FAILURE);
    }

    if ((received_length = recvfrom(socket_file_descriptor, buffer, MAX_BUFFER_SIZE, 0, NULL, NULL)) < 0) {
        perror("Failed to receive message");
        exit(EXIT_FAILURE);
    }

    printf("Received echo: %s \n", buffer);

    close(socket_file_descriptor);
    unlink(client_address.sun_path);

    exit(EXIT_SUCCESS);
}
