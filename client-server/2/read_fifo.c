/**
 * This program creates a FIFO file, reads a message from it, and then removes it.
 */

#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>
#include <fcntl.h>

#define FIFO_FILE_PATH "/tmp/client_server_fifo.1"
#define MAX_BUFFER_SIZE 80

int main ()
{
    int fifo_read_fd, num_bytes_read;
    char buffer[MAX_BUFFER_SIZE];

    if(mknod(FIFO_FILE_PATH, S_IFIFO | 0666 , 0) < 0)
    {
        printf("Failed to create FIFO file.\n");
        exit(EXIT_FAILURE);
    }

    if((fifo_read_fd = open(FIFO_FILE_PATH, O_RDONLY)) < 0)
    {
        printf("Failed to open FIFO file for reading.\n");
        exit(EXIT_FAILURE);
    }

    while ((num_bytes_read = read(fifo_read_fd, buffer, MAX_BUFFER_SIZE)) > 0)
    {
        if (write(1, buffer, num_bytes_read) != num_bytes_read)
        {
            printf("Failed to write output.\n");
            exit(EXIT_FAILURE);
        }
    }

    close(fifo_read_fd);

    exit(EXIT_SUCCESS);
}
