/**
 * This program sorts an array of floating point numbers in ascending order.
 * The array size is defined by the user and should be between 1 and 40.
 * All elements are ordered in increasing order, except the last one.
 * The program moves the last element to a new position to make the array ordered.
 */

#include <stdio.h>

#define MAX_ARRAY_SIZE 40

int main() {
    int arraySize, i, j;
    float array[MAX_ARRAY_SIZE], temp;

    printf("Enter the size of the array (between 1 and 40):\n");
    while (scanf("%d", &arraySize) != 1 || arraySize < 1 || arraySize > MAX_ARRAY_SIZE) {
        printf("Invalid input. Expected a number between 1 and 40. Please try again:\n");
        while(getchar() != '\n'); // clear input buffer
    }

    for(i = 0; i < arraySize; i++) {
        printf("Enter element %d:\n", i);
        while(scanf("%f", &array[i]) != 1) {
            printf("Invalid input. Expected a number. Please try again:\n");
            while(getchar() != '\n'); // clear input buffer
        }
    }

    printf("Here's the unsorted array: ");
    for(i = 0; i < arraySize; i++) printf("%.0f ", array[i]);
    printf("\n");

    // Bubble sort
    for(i = arraySize - 1; i >= 0; i--) {
        for(j = i; j >= 1; j--) {
            if(array[j] < array[j - 1]) {
                temp = array[j];
                array[j] = array[j - 1];
                array[j - 1] = temp;
            }
        }
    }

    printf("Here's the sorted array: ");
    for(i = 0; i < arraySize; i++) printf("%.0f ", array[i]);
    printf("\n");

    return 0;
}
