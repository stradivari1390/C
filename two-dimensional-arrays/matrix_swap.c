/**
 * This program swaps the maximum and minimum elements in each column
 * of a user-inputted matrix. The dimensions of the matrix (M, N)
 * must be between 1 and 10 inclusive.
 */

#include <stdio.h>

#define MAX_DIMENSION 10

int main() {
    int matrix[MAX_DIMENSION][MAX_DIMENSION], row, column, matrixM, matrixN, minIndex, maxIndex, temp;
    int maxVal = -999, minVal = 999;

    printf("\nGiven a matrix MxN, we will swap the max and min elements in each column.\n");
    printf("Enter matrix's dimensions (M, then N):\n");
    scanf("%d%d", &matrixM, &matrixN);

    while((matrixN<1 || matrixN>MAX_DIMENSION) || (matrixM<1 || matrixM>MAX_DIMENSION)) {
        printf("Invalid dimensions. Remember: 1 <= M, N <= 10\n");
        scanf("%d%d", &matrixM, &matrixN);
    }

    for(row = 0; row < matrixM; row++) {
        for(column = 0; column < matrixN; column++) {
            printf("\nEnter matrix[%d][%d]: ", (row + 1), (column + 1));
            scanf("%d", &matrix[row][column]);
        }
    }

    printf("\nInitial matrix:\n");
    for(row = 0; row < matrixM; row++) {
        for(column = 0; column < matrixN; column++) {
            printf("%d\t", matrix[row][column]);
        }
        printf("\n");
    }

    for(column = 0; column < matrixN; column++) {
        for(row = 0; row < matrixM; row++) {
            if(matrix[row][column] > maxVal) {
                maxIndex = row;
                maxVal = matrix[row][column];
            }

            if(matrix[row][column] < minVal) {
                minIndex = row;
                minVal = matrix[row][column];
            }
        }

        temp = matrix[minIndex][column];
        matrix[minIndex][column] = matrix[maxIndex][column];
        matrix[maxIndex][column] = temp;

        maxVal = -999;
        minVal = 999;
    }

    printf("\nMatrix after swapping max and min elements in each column:\n");
    for(row = 0; row < matrixM; row++) {
        for(column = 0; column < matrixN; column++) {
            printf("%d\t", matrix[row][column]);
        }
        printf("\n");
    }

    return 0;
}
