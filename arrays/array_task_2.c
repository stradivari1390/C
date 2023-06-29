/**
 * This program finds the local minima in an array of floating-point numbers.
 * A local minimum is an element which is smaller than its neighbours.
 * The user is asked to input the size of the array and its elements.
 * The program then prints out all the local minima.
 */

#define MAX_SIZE 40
#include <stdio.h>
#include <stdlib.h>

int main() {
    int array_size, i;
    float array[MAX_SIZE], current_element;
    char input[100];

    printf("An array of size N is given. The task is to find the maximum local minimum.\n");
    printf("Enter the size of the array (N):\n");

    fgets(input, sizeof(input), stdin);
    array_size = strtol(input, NULL, 10);

    while(array_size < 1 || array_size > MAX_SIZE) {
        printf("Invalid input. Please enter a number between 1 and 40:\n");
        fgets(input, sizeof(input), stdin);
        array_size = strtol(input, NULL, 10);
    }

    for(i = 0; i < array_size; i++) {
        printf("Enter element %d:\n", i);
        fgets(input, sizeof(input), stdin);
        array[i] = strtof(input, NULL);
    }

    for(i = 1; i < array_size - 1; i++) {
        if(array[i] < array[i - 1] && array[i] < array[i + 1]) {
            printf("%.1f is a local minimum (element #%d)\n", array[i], i);
        }
    }

    return 0;
}
