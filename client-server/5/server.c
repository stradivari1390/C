/*программа 2(сообщения)*/
/*заголовочный файл*/
/**
 * @file server.c
 * @brief This file contains the server-side code for inter-process communication using message queues.
 */

#include "message.h"
#include <sys/msg.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>

#define PERMISSIONS 0666

int main() {
    Message message;
    key_t key;
    int msgid, n;

    if ((key = ftok("server", 'A')) < 0) {
        perror("Failed to generate key");
        exit(EXIT_FAILURE);
    }

    message.type = 1L;

    if ((msgid = msgget(key, PERMISSIONS | IPC_CREAT)) < 0) {
        perror("Failed to get message queue descriptor");
        exit(EXIT_FAILURE);
    }

    n = msgrcv(msgid, &message, sizeof(message), message.type, 0);

    if (n > 0) {
        if (write(1, message.buffer, n) != n) {
            perror("Failed to write message");
            exit(EXIT_FAILURE);
        }
    } else {
        perror("Failed to receive message");
        exit(EXIT_FAILURE);
    }

    return EXIT_SUCCESS;
}
