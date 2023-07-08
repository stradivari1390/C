/**
 * This program takes an array of integers and rotates its elements by a given number of positions.
 * The size of the array and the number of positions to rotate are provided by the user.
 */

#include <stdio.h>
#define MAX_SIZE 40

int main() {
    int originalArray[MAX_SIZE], arraySize, rotation, i, rotatedArray[MAX_SIZE];

    printf("\nThis program rotates the elements of an array by a certain number of positions.\n");

    printf("Enter the size of the array (between 1 and 40):\n");
    scanf("%d", &arraySize);

    while((arraySize < 1) || (arraySize > MAX_SIZE)) {
        printf("Invalid input! The size of the array should be between 1 and 40. Please try again.\n");
        printf("Enter the size of the array:\n");
        scanf("%d", &arraySize);
    }

    for(i = 0; i < arraySize; i++) {
        printf("Enter element number %d:\n", i + 1);
        scanf("%d", &originalArray[i]);
    }

    printf("\nOriginal array: ");
    for(i = 0; i < arraySize; i++) printf(" %d", originalArray[i]);

    printf("\nEnter the number of positions to rotate the array (should be a positive number):\n");
    scanf("%d", &rotation);

    while(rotation < 0) {
        printf("Invalid input! Rotation should be a positive number. Please try again.\n");
        printf("\nEnter the number of positions to rotate the array:\n");
        scanf("%d", &rotation);
    }

    rotation = rotation - arraySize * (rotation / arraySize);

    for(i = 0; i < arraySize; i++) {
        if(rotation + i < arraySize) rotatedArray[i + rotation] = originalArray[i];
        else rotatedArray[i - arraySize + rotation] = originalArray[i];
    }

    printf("\nRotated array: ");
    for(i = 0; i < arraySize; i++) printf(" %d", rotatedArray[i]);

    getchar();
    return 0;
}
