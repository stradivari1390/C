/**
 * This program writes a message to a FIFO and then deletes the FIFO.
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define FIFO_NAME "fifo1"

int main() {
    int fifo_fd;

    // Open the FIFO for writing
    if ((fifo_fd = open(FIFO_NAME, O_WRONLY)) < 0) {
        perror("Failed to open FIFO");
        exit(EXIT_FAILURE);
    }

    // Write a message to the FIFO
    const char* message = "HELLO WORLD\n";
    if (write(fifo_fd, message, strlen(message)) != strlen(message)) {
        perror("Failed to write to FIFO");
        exit(EXIT_FAILURE);
    }

    // Close the FIFO
    close(fifo_fd);

    // Delete the FIFO
    if (unlink(FIFO_NAME) < 0) {
        perror("Failed to delete FIFO");
        exit(EXIT_FAILURE);
    }

    exit(EXIT_SUCCESS);
}
