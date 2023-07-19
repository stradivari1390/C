/**
 * @file message.h
 * @brief This file contains the definition of the Message structure used for inter-process communication.
 */

#ifndef MESSAGE_H
#define MESSAGE_H

#define MAX_BUFFER_SIZE 80

typedef struct Message {
    long type;
    char buffer[MAX_BUFFER_SIZE];
} Message;

#endif // MESSAGE_H