/**
 * Server
 * This file contains the server-side code for shared memory communication.
 */

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include "shared_memory.h"

int main() {
    SharedMemoryMessage *message_ptr;
    key_t key;
    int shared_memory_id, semaphore_id;

    if ((key = ftok("server", 'A')) < 0) {
        perror("Failed to generate key");
        exit(EXIT_FAILURE);
    }

    if ((shared_memory_id = shmget(key, sizeof(SharedMemoryMessage), PERMISSIONS | IPC_CREAT)) < 0) {
        perror("Failed to get shared memory");
        exit(EXIT_FAILURE);
    }

    if ((message_ptr = (SharedMemoryMessage *)shmat(shared_memory_id, 0, 0)) == (SharedMemoryMessage *)-1) {
        perror("Failed to attach shared memory");
        exit(EXIT_FAILURE);
    }

    if ((semaphore_id = semget(key, 2, PERMISSIONS | IPC_CREAT)) < 0) {
        perror("Failed to get semaphore");
        exit(EXIT_FAILURE);
    }

    if (semop(semaphore_id, &process_wait[0], 1) < 0) {
        perror("Failed to execute semaphore operation");
        exit(EXIT_FAILURE);
    }

    if (semop(semaphore_id, &memory_lock[0], 2) < 0) {
        perror("Failed to execute semaphore operation");
        exit(EXIT_FAILURE);
    }

    printf("%s", message_ptr->buffer);

    if (semop(semaphore_id, &memory_unlock[0], 1) < 0) {
        perror("Failed to execute semaphore operation");
        exit(EXIT_FAILURE);
    }

    if (shmdt(message_ptr) < 0) {
        perror("Failed to detach shared memory");
        exit(EXIT_FAILURE);
    }

    return EXIT_SUCCESS;
}
