/**This program works by taking in a size N for an integer array,
 * ensuring N is between 1 and 40. It then accepts N integer inputs from
 * the user, storing them in an array. Finally, it prints out the array twice,
 * but for any even numbers, it prints them twice.*/

#include <stdio.h>
#include <stdlib.h>

int main() {
    int i, arraySize, numbers[40];
    char buffer[40];

    printf("Integer array a[N] is given.\nPrint the even numbers twice.\n");
    printf("Enter N\n");

    fgets(buffer, sizeof(buffer), stdin);
    arraySize = strtol(buffer, NULL, 10);

    while (arraySize < 1 || arraySize > 40) {
        printf("1<=N<=40 expected\n");
        printf("Enter N\n");

        fgets(buffer, sizeof(buffer), stdin);
        arraySize = strtol(buffer, NULL, 10);
    }

    for (i = 0; i < arraySize; i++) {
        printf("Enter element %d\n", i);
        fgets(buffer, sizeof(buffer), stdin);
        numbers[i] = strtol(buffer, NULL, 10);
    }

    printf("\nHere's current array: ");
    for (i = 0; i < arraySize; i++) printf(" %d", numbers[i]);

    printf("\n\nHere's modified array: ");
    for (i = 0; i < arraySize; i++) {
        if (numbers[i] % 2 == 0) printf(" %d %d", numbers[i], numbers[i]);
        else printf(" %d", numbers[i]);
    }

    return 0;
}
