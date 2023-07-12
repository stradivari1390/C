/**
 * This header file defines the structure and operations for shared memory communication.
 */

#define MAX_BUFFER_SIZE 80
#define PERMISSIONS 0666

typedef struct shared_memory_message {
    int segment;
    char buffer[MAX_BUFFER_SIZE];
} SharedMemoryMessage;

static struct sembuf process_wait[1] = {1, -1, 0};
static struct sembuf process_start[1] = {1, 1, 0};
static struct sembuf memory_lock[2] = {0, 0, 0, 0, 1, 0};
static struct sembuf memory_unlock[1] = {0, -1, 0};
