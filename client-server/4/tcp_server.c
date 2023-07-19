/**
 * Simple TCP server.
 * Listens for connections, receives a message, and sends a response.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define PORT_NUMBER 1500
#define MAX_BUFFER 80
#define MAX_WAIT_CONNECTIONS 5

int main() {
    struct sockaddr_in server_address, client_address;
    int socket_fd, client_socket_fd;
    char buffer[MAX_BUFFER + 1];

    printf("Starting TCP server...\n");

    if ((socket_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0){
        fprintf(stderr, "Error: socket creation failed (%s)\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    memset(&server_address, 0, sizeof(server_address));
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(PORT_NUMBER);

    if (bind(socket_fd, (struct sockaddr*)&server_address, sizeof(server_address)) < 0){
        fprintf(stderr, "Error: bind failed (%s)\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    printf("Server is ready: %s \n", inet_ntoa(server_address.sin_addr));

    if (listen(socket_fd, MAX_WAIT_CONNECTIONS) < 0){
        fprintf(stderr, "Error: listen failed (%s)\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    for (;;) {
        socklen_t client_len = sizeof(client_address);
        memset(&client_address, 0, sizeof(client_address));

        if ((client_socket_fd = accept(socket_fd, (struct sockaddr *)&client_address, &client_len)) < 0){
            fprintf(stderr, "Error: accept failed (%s)\n", strerror(errno));
            exit(EXIT_FAILURE);
        }

        printf("Client connected: %s\n", inet_ntoa(client_address.sin_addr));

        int received_bytes;
        while ((received_bytes = recv(client_socket_fd, buffer, sizeof(buffer), 0)) > 0){
            send(client_socket_fd, buffer, received_bytes, 0);
        }

        close(client_socket_fd);
    }

    close(socket_fd);
    exit(EXIT_SUCCESS);
}
