/**
 * This program calculates a specific mathematical expression using the elements of an array.
 * The expression is: a[0]*(a[0]+a[1])*(a[0]*a[1]*a[2]) + sum(a[0]...a[n]).
 * The program prompts the user to enter the elements of the array, and then computes and outputs the result.
 */

#define MAX_SIZE 40
#include <stdio.h>
#include <stdlib.h>

int main() {
    int array_size, index;
    float array[MAX_SIZE], temp_sum = 0, dummy_var;
    char input[100];

    printf("Given an array of size N, this program will calculate the following expression:\na[0]*(a[0]+a[1])*(a[0]*a[1]*a[2]) + sum(a[0]...a[n])\n");
    printf("Please enter the size of the array (N):\n");
    fgets(input, sizeof(input), stdin);
    array_size = strtol(input, NULL, 10);

    while (array_size < 1 || array_size > MAX_SIZE) {
        printf("Invalid size! Please enter a size between 1 and 40:\n");
        fgets(input, sizeof(input), stdin);
        array_size = strtol(input, NULL, 10);
    }

    for (index = 0; index < array_size; index++) {
        printf("Please enter element %d of the array:\n", index);
        fgets(input, sizeof(input), stdin);
        array[index] = strtof(input, NULL);
    }

    for (index = 0; index < array_size; index++) {
        temp_sum += array[index];
    }

    temp_sum = array[0]*(array[0]+array[1])*(array[0]*array[1]*array[2]) + temp_sum;
    printf("\nThe computed sum is %.1f", temp_sum);

    // Dummy input to pause the console.
    fgets(input, sizeof(input), stdin);
    dummy_var = strtof(input, NULL);

    return 0;
}
