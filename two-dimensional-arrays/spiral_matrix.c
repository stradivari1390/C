/**
 * This program takes a square matrix of odd dimension as input from the user.
 * It then prints the elements of the matrix in a spiral order.
 */

#include <stdio.h>

#define MATRIX_SIZE 11

int main() {
    int matrix[MATRIX_SIZE][MATRIX_SIZE], dimension, i, j;
    printf("Enter the elements of a square matrix of odd dimension in a spiral order.\n");

    do {
        printf("Enter the dimension of the matrix:\n");
        scanf("%d", &dimension);
        if(dimension < 1 || (dimension % 2 == 0)) {
            printf("Error! Dimension should be an odd number greater than 0.\n");
        }
    } while(dimension < 1 || (dimension % 2 == 0));

    for (i = 0; i < dimension; i++) {
        for (j = 0; j < dimension; j++) {
            printf ("Enter the element at position [%d][%d]:\n", i+1, j+1);
            scanf("%d", &matrix[i][j]);
        }
    }

    printf("Matrix before transformation:\n");
    for (i = 0; i < dimension; i++) {
        for (j = 0; j < dimension; j++) {
            printf ("%3d", matrix[i][j]);
        }
        printf("\n");
    }

    printf("\nMatrix after transformation:\n");
    for(i = 0; i < dimension; i++) {
        for (j = i; j < dimension - i; j++)
            printf("%3d", matrix[j][i]);
        for (j = i; j < dimension - i; j++)
            printf("%3d", matrix[dimension - 1 - i][j]);
        for (j = dimension - 1 - i; j > i; j--)
            printf("%3d", matrix[j][dimension - 1 - i]);
        for (j = dimension - 1 - i; j > i; j--)
            printf("%3d", matrix[i][j]);
    }
    printf("%3d", matrix[dimension / 2][dimension / 2]);

    return 0;
}
