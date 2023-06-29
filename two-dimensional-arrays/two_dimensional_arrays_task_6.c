/**
 * This program reads a matrix of size MxN from the user,
 * where M and N are also provided by the user (with 0 < M,N <= 10).
 * It then finds the row with the maximum sum of its elements,
 * and prints this sum.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_DIM 10
#define BUFFER_SIZE 100

int main() {
    int matrix[MAX_DIM][MAX_DIM], row, col, dimension_m, dimension_n, sum, max_sum = -999, max_row;
    char input_buffer[BUFFER_SIZE];

    printf("\nA matrix of dimensions MxN is given.\n");
    printf("Find the row where the sum of its elements is the greatest.\nPrint the sum.\n");
    printf("Enter the dimensions of the matrix (M, then N):\n");

    fgets(input_buffer, BUFFER_SIZE, stdin);
    dimension_m = (int)strtol(strtok(input_buffer, " "), NULL, 10);
    dimension_n = (int)strtol(strtok(NULL, " "), NULL, 10);

    while ((dimension_n < 1 || dimension_n > MAX_DIM) || (dimension_m < 1 || dimension_m > MAX_DIM)) {
        printf("Please try again. Remember: 0 < M, N <= 10\n");

        fgets(input_buffer, BUFFER_SIZE, stdin);
        dimension_m = (int)strtol(strtok(input_buffer, " "), NULL, 10);
        dimension_n = (int)strtol(strtok(NULL, " "), NULL, 10);
    }

    for (row = 0; row < dimension_m; row++) {
        for (col = 0; col < dimension_n; col++) {
            printf("\nEnter element at position [%d][%d]: ", (row + 1), (col + 1));

            fgets(input_buffer, BUFFER_SIZE, stdin);
            matrix[row][col] = (int)strtol(input_buffer, NULL, 10);
        }
    }

    printf("\nThe input matrix is:\n");
    for (row = 0; row < dimension_m; row++) {
        for (col = 0; col < dimension_n; col++) {
            printf("%d ", matrix[row][col]);
        }
        printf("\n");
    }

    for (row = 0; row < dimension_m; row++) {
        sum = 0;
        for (col = 0; col < dimension_n; col++) {
            sum += matrix[row][col];
        }
        if (sum > max_sum) {
            max_sum = sum;
            max_row = row;
        }
    }

    printf("The maximum sum of elements is in row %d, and the sum is %d\n", max_row + 1, max_sum);

    return 0;
}
