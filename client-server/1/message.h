/** 
 * This header file defines the message structure and related constants.
 */

#define MAXBUFF 80
#define PERM 0666

typedef struct our_msgbuf
{
    long mtype;
    char buff[MAXBUFF];
} Message;
