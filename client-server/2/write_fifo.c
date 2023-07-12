/**
 * This program writes a message to a FIFO file and then removes it.
 */

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define MAX_BUFFER_SIZE 80
#define FIFO_FILE_PATH "/tmp/client_server_fifo.1"

int main ()
{
    int fifo_write_fd;

    if((fifo_write_fd = open(FIFO_FILE_PATH, O_WRONLY)) < 0)
    {
        printf("Failed to open FIFO file for writing.\n");
        exit(EXIT_FAILURE);
    }

    if(write(fifo_write_fd, "Hello, World!\n", 14) != 14)
    {
        printf("Failed to write to FIFO file.\n");
        exit(EXIT_FAILURE);
    }

    close(fifo_write_fd);

    if(unlink(FIFO_FILE_PATH) < 0)
    {
        printf("Failed to remove FIFO file.\n");
        exit(EXIT_FAILURE);
    }

    exit(EXIT_SUCCESS);
}
