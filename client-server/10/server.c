/**
 * @file server.c
 * @brief A simple server in the internet domain using TCP
 */

#include "Socket_Inet.h"

#define MAX_BUFFER_SIZE 256
#define PORT 20000
#define LISTEN_QUEUE_SIZE 5

char buffer[MAX_BUFFER_SIZE];

void error(int error_number);

int main() {
    struct sockaddr_in server_address;
    int socket_descriptor, new_socket_descriptor;
    int n;

    socket_descriptor = socket(AF_INET, SOCK_STREAM, 0);
    if (socket_descriptor < 0)
        error(1);

    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(PORT);
    server_address.sin_addr.s_addr = htonl(INADDR_ANY);

    if (bind(socket_descriptor, (struct sockaddr*)&server_address, sizeof(server_address)) < 0)
        error(2);

    if (listen(socket_descriptor, LISTEN_QUEUE_SIZE) < 0)
        error(3);

    for (;;) {
        new_socket_descriptor = accept(socket_descriptor, NULL, NULL);
        if (new_socket_descriptor < 0)
            error(4);

        if (!fork()) {
            if (close(socket_descriptor) < 0)
                error(5);

            n = recv(new_socket_descriptor, buffer, MAX_BUFFER_SIZE, 0);
            if (n < 0)
                error(6);

            printf("Received: %s\n", buffer);
            exit(EXIT_SUCCESS);
        } else {
            if (close(new_socket_descriptor) < 0)
                error(7);
        }
    }

    return 0;
}

void error(int error_number) {
    fprintf(stderr, "Error occurred: %d\n", error_number);
    exit(EXIT_FAILURE);
}
