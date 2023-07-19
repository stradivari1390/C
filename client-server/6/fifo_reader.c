/**
 * This program creates a FIFO, reads a message from it, and then deletes the FIFO.
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define FIFO_NAME "fifo1"
#define BUFFER_SIZE 80

int main() {
    int fifo_fd;
    char buffer[BUFFER_SIZE];

    // Create the FIFO
    if (mknod(FIFO_NAME, S_IFIFO | 0666, 0) < 0) {
        perror("Failed to create FIFO");
        exit(EXIT_FAILURE);
    }

    // Open the FIFO for reading
    if ((fifo_fd = open(FIFO_NAME, O_RDONLY)) < 0) {
        perror("Failed to open FIFO");
        exit(EXIT_FAILURE);
    }

    // Read from the FIFO and write to stdout
    ssize_t n;
    while ((n = read(fifo_fd, buffer, BUFFER_SIZE)) > 0) {
        if (write(STDOUT_FILENO, buffer, n) != n) {
            perror("Failed to write to stdout");
            exit(EXIT_FAILURE);
        }
    }

    // Close the FIFO
    close(fifo_fd);

    exit(EXIT_SUCCESS);
}
