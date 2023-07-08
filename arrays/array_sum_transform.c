/**
 * This program generates a new array from a given array. The new array is
 * created such that each element at index k is the sum of all elements
 * from index k to n in the original array. The user provides the size and
 * elements of the original array.
 */
#include <stdio.h>

#define MAX_SIZE 40

int main() {
    int originalArray[MAX_SIZE], arraySize, index, innerIndex, tempSum = 0;

    printf("\nThis program generates a new array from a given array.\nThe new array's elements are calculated as the sum of all elements\nfrom the current index to the end of the original array.\n");

    printf("Enter the size of the array (between 1 and 40):\n");
    scanf("%d", &arraySize);

    while(arraySize < 1 || arraySize > MAX_SIZE) {
        printf("Invalid input! The size of the array must be between 1 and 40.\n");
        printf("Enter the size of the array again:\n");
        scanf("%d", &arraySize);
    }

    for(index = 0; index < arraySize; index++) {
        printf("Enter element %d:\n", index + 1);
        scanf("%d", &originalArray[index]);
    }

    printf("\nOriginal array: ");
    for(index = 0; index < arraySize; index++) {
        printf("%d ", originalArray[index]);
    }

    printf("\nGenerated array: ");
    for(index = 0; index < arraySize; index++) {
        for(innerIndex = index; innerIndex < arraySize; innerIndex++) {
            tempSum += originalArray[innerIndex];
        }
        originalArray[index] = tempSum;
        tempSum = 0;
        printf("%d ", originalArray[index]);
    }

    printf("\nPress any key to exit.");
    getchar(); // To capture the newline character from previous input.
    getchar(); // To wait for user input before exiting.

    return 0;
}