/** 
 * This program receives a message from a message queue.
 * It first generates a key for the message queue, then reads a message from it.
 * If any step fails, it prints an error message and exits with status 1.
 */

#include "common_headers.h"
#include "message.h"

int main()
{
    Message msg;
    key_t key;
    int msg_id, msg_length, n;

    if ((key = ftok("server", 'A')) < 0) {
        printf("Unable to generate key\n");
        exit(1);
    }

    msg.mtype = 1L;

    if ((msg_id = msgget(key, PERM | IPC_CREAT)) < 0) {
        printf("Unable to create queue\n");
        exit(1);
    }

    n = msgrcv(msg_id, &msg, sizeof(msg), msg.mtype, 0);

    if (n > 0) {
        if (write(1, msg.buff, n) != n) {
            printf("Input error\n");
            exit(1);
        }
    } else {
        printf("Error reading message\n");
        exit(1);
    }

    return 0;
}
