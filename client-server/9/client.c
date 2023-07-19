/**
 * This is a UNIX domain socket client program.
 * It sends a message to the server and receives a response.
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <sys/un.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_BUFFER_SIZE 256

char buffer[MAX_BUFFER_SIZE];

void handleError(int errorCode) {
    printf("An error occurred. Error code: %d\n", errorCode);
    exit(1);
}

int main() {
    struct sockaddr_un serverAddress, clientAddress;
    int socketFileDescriptor, serverAddressLength, clientAddressLength, messageLength, receivedBytes;
    char *message = "Hello, World!\n";

    memset(&serverAddress, 0, sizeof(serverAddress));
    serverAddress.sun_family = AF_UNIX;
    strcpy(serverAddress.sun_path, "./server.socket");
    serverAddressLength = sizeof(serverAddress.sun_family) + strlen(serverAddress.sun_path);

    if ((socketFileDescriptor = socket(AF_UNIX, SOCK_DGRAM, 0)) < 0) {
        handleError(40);
    }

    memset(&clientAddress, 0, sizeof(clientAddress));
    clientAddress.sun_family = AF_UNIX;
    strcpy(clientAddress.sun_path, "./tmp.client.XXXXXX");
    mkstemp(clientAddress.sun_path);
    clientAddressLength = sizeof(clientAddress.sun_family) + strlen(clientAddress.sun_path);

    if (bind(socketFileDescriptor, (struct sockaddr *)&clientAddress, clientAddressLength) < 0) {
        handleError(100);
    }

    messageLength = strlen(message);
    if (sendto(socketFileDescriptor, message, messageLength, 0, (struct sockaddr*) &serverAddress, serverAddressLength) < 0) {
        handleError(110);
    }

    if ((receivedBytes = recvfrom(socketFileDescriptor, buffer, MAX_BUFFER_SIZE, 0, NULL, 0)) < 0) {
        handleError(120);
    }

    printf("Received message: %s\n", buffer);

    if (close(socketFileDescriptor) < 0) {
        handleError(120);
    }

    if (unlink(clientAddress.sun_path) < 0) {
        handleError(130);
    }

    exit(0);
}
