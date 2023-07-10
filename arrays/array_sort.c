/**
 * This program takes an array of floating point numbers from the user.
 * The size of the array is also determined by the user, but it should be between 1 and 10.
 * After the array is filled, the program prints the elements in a specific order.
 * The order is as follows: first, second, last, second last, third, fourth, third last, fourth last, and so on.
 */

#include <stdio.h>
#define MAX_SIZE 10

void printArrayInSpecificOrder(float* array, int n) {
    int i = 0;
    int j = n - 1;

    while (i <= j) {
        if (i == j) {
            printf("%.1f ", array[i]);
        } else {
            printf("%.1f ", array[i]);
            printf("%.1f ", array[i+1]);
            if (i+1 != j) {
                printf("%.1f ", array[j]);
                printf("%.1f ", array[j-1]);
            }
        }
        i += 2;
        j -= 2;
    }
    printf("\n");
}

int main() {
    int arraySize, index;
    float array[MAX_SIZE];

    printf("This program takes an array of floating point numbers.\n");
    printf("Enter the size of the array (between 1 and 10):\n");
    scanf("%d", &arraySize);

    while(arraySize < 1 || arraySize > MAX_SIZE) {
        printf("Invalid input! The size of the array should be between 1 and 10.\n");
        printf("Enter the size of the array again:\n");
        scanf("%d", &arraySize);
    }

    for(index = 0; index < arraySize; index++) {
        printf("Enter element %d:\n", index + 1);
        scanf("%f", &array[index]);
    }

    printArrayInSpecificOrder(array, arraySize);

    return 0;
}
