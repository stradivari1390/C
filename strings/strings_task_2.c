/**
 * This program takes a file path from the user, then asks the user
 * to choose whether they want to extract the file name or the file extension.
 * The user's choice is processed in a switch statement, and the relevant
 * part of the file path is printed to the console.
 */

#include <stdio.h>
#include <string.h>

#define MAX_LENGTH 100

int main() {
    char filePath[MAX_LENGTH];
    int slashPosition = 0, dotPosition = 0, spacePosition = 0, choice;
    size_t filePathLength;

    printf("\nEnter the file path (LINUX): ");
    fgets(filePath, MAX_LENGTH, stdin);

    filePathLength = strlen(filePath);
    filePath[filePathLength - 1] = '\0';

    for (int i = 0; i < MAX_LENGTH; i++) {
        if (filePath[i] == '/') slashPosition = i;
        if (filePath[i] == '.') dotPosition = i;
        if (filePath[i] == ' ') spacePosition = i;
    }

    printf("\nChoose what to extract from the file path: \n");
    printf("1 - File name\n");
    printf("2 - File extension\n");
    fgets(filePath, MAX_LENGTH, stdin);

    choice = filePath[0] - '0';

    switch (choice) {
        case 1: {
            printf("\nFile name: ");
            for (int i = slashPosition + 1; i < dotPosition; i++) {
                putchar(filePath[i]);
            }
            break;
        }
        case 2: {
            printf("\nFile extension: ");
            for (int i = dotPosition + 1; i < spacePosition; i++) {
                putchar(filePath[i]);
            }
            break;
        }
        default: {
            printf("\nInvalid choice.");
            break;
        }
    }

    return 0;
}
