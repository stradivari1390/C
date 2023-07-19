/**
 * @file client.c
 * @brief A simple client in the internet domain using TCP
 */

#include "Socket_Inet.h"

#define PORT 20000

void error(int error_number);

int main() {
    char *message = "Hello, World!\n";
    struct sockaddr_in server_address;
    int socket_descriptor;

    socket_descriptor = socket(AF_INET, SOCK_STREAM, 0);
    if (socket_descriptor < 0)
        error(10);

    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(PORT);
    server_address.sin_addr.s_addr = inet_addr("127.0.0.1");

    if (connect(socket_descriptor, (struct sockaddr*)&server_address, sizeof(server_address)) < 0)
        error(11);

    if (send(socket_descriptor, message, strlen(message), 0) < 0)
        error(12);

    if (close(socket_descriptor) < 0)
        error(13);

    return 0;
}

void error(int error_number) {
    fprintf(stderr, "Error occurred: %d\n", error_number);
    exit(EXIT_FAILURE);
}
