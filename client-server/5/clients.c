/**
 * @file client.c
 * @brief This file contains the client-side code for inter-process communication using message queues.
 */

#include "message.h"
#include <sys/msg.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    Message message;
    int msgid, length;
    key_t key;

    message.type = 1L;

    if ((key = ftok("server", 'A')) < 0) {
        perror("Failed to generate key");
        exit(EXIT_FAILURE);
    }

    if ((msgid = msgget(key, 0)) < 0) {
        perror("Failed to get message queue");
        exit(EXIT_FAILURE);
    }

    if ((length = sprintf(message.buffer, "Make love not spam\n")) < 0) {
        perror("Failed to write to buffer");
        exit(EXIT_FAILURE);
    }

    if (msgsnd(msgid, (void*) &message, length, 0) != 0) {
        perror("Failed to send message");
        exit(EXIT_FAILURE);
    }

    if (msgctl(msgid, IPC_RMID, 0) < 0) {
        perror("Failed to remove message queue");
        exit(EXIT_FAILURE);
    }

    return EXIT_SUCCESS;
}
