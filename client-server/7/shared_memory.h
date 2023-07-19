/**
 * Shared Memory Header
 * This file contains the structure and semaphore operations for shared memory communication.
 */

#ifndef SHARED_MEMORY_H
#define SHARED_MEMORY_H

#define MAX_BUFFER_SIZE 80
#define PERMISSIONS 0666

typedef struct shared_memory_message {
    int segment;
    char buffer[MAX_BUFFER_SIZE];
} SharedMemoryMessage;

// Semaphore operations
static struct sembuf process_wait[1] = {1, -1, 0};
static struct sembuf process_start[1] = {1, 1, 0};
static struct sembuf memory_lock[2] = {0, 0, 0, 0, 1, 0};
static struct sembuf memory_unlock[1] = {0, -1, 0};

#endif // SHARED_MEMORY_H
