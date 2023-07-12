/** 
 * This program sends a message to a message queue.
 * It first generates a key for the message queue, then sends a message to it.
 * If any step fails, it prints an error message and exits with status 1.
 */

#include "common_headers.h"
#include "message.h"

int main()
{
    Message msg;
    key_t key;
    int msg_id, msg_length;

    msg.mtype = 1L;

    if ((key = ftok("server", 'A')) < 0) {
        printf("Unable to generate key\n");
        exit(1);
    }

    if ((msg_id = msgget(key, 0)) < 0) {
        printf("Unable to access message queue\n");
        exit(1);
    }

    if ((msg_length = sprintf(msg.buff, "Hello!\n")) < 0) {
        printf("Error copying to buffer\n");
        exit(1);
    }

    if (msgsnd(msg_id, (void *) &msg, msg_length, 0) != 0) {
        printf("Error writing message to queue\n");
        exit(1);
    }

    if (msgctl(msg_id, IPC_RMID, 0) < 0) {
        printf("Error deleting queue\n");
        exit(1);
    }

    return 0;
}
