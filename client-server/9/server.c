/**
 * This is a UNIX domain socket server program.
 * It receives a message from the client and sends a response back.
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
    int socketFileDescriptor, serverAddressLength, clientAddressLength, maxClientAddressLength, receivedBytes;
    struct sockaddr_un serverAddress, clientAddress;

    if ((socketFileDescriptor = socket(AF_UNIX, SOCK_DGRAM, 0)) < 0) {
        handleError(1);
    }

    unlink("./server.socket");

    memset(&serverAddress, 0, sizeof(serverAddress));
    serverAddress.sun_family = AF_UNIX;
    strcpy(serverAddress.sun_path, "./server.socket");
    serverAddressLength = sizeof(serverAddress.sun_family) + strlen(serverAddress.sun_path);

    if (bind(socketFileDescriptor, (struct sockaddr*)&serverAddress, serverAddressLength) < 0) {
        handleError(6);
    }

    maxClientAddressLength = sizeof(clientAddress);

    for (;;) {
        clientAddressLength = maxClientAddressLength;
        if ((receivedBytes = recvfrom(socketFileDescriptor, buffer, MAX_BUFFER_SIZE, 0, (struct sockaddr*)&clientAddress, &clientAddressLength)) < 0) {
            handleError(7);
        }

        if (sendto(socketFileDescriptor, buffer, receivedBytes, 0, (struct sockaddr *)&clientAddress, clientAddressLength) < 0) {
            handleError(8);
        }
    }

    exit(0);
}
