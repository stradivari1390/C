/**
 * This program takes a matrix of size MxN as input from the user.
 * It then sorts the rows of the matrix in ascending order based on the first element of each row.
 */

#include <stdio.h>

#define ROW_SIZE 11
#define COL_SIZE 11

int main() {
    int matrix[ROW_SIZE][COL_SIZE], rows, cols, i, j, k, minIndex, minValue, temp;
    printf("Enter the elements of a matrix of size MxN. The program will sort the rows in ascending order.\n");

    do {
        printf("Enter the dimensions of the matrix (MxN):\n");
        scanf("%d%d", &rows, &cols);
        if(rows < 1 || cols < 1) {
            printf("Error! Both M and N should be greater than 0.\n");
        }
    } while(rows < 1 || cols < 1);

    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            printf ("Enter the element at position [%d][%d]:\n", i+1, j+1);
            scanf("%d", &matrix[i][j]);
        }
    }

    printf("Matrix before transformation:\n");
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            printf ("%d ", matrix[i][j]);
        }
        printf("\n");
    }

    for (i = 0; i < rows - 1; i++)  {
        minValue = matrix[i][0];
        minIndex = i;
        for (j = i + 1; j < rows; j++) {
            if (minValue > matrix[j][0]) {
                minValue = matrix[j][0];
                minIndex = j;
            }
        }
        for (k = 0; k < cols; k++) {
            temp = matrix[i][k];
            matrix[i][k] = matrix[minIndex][k];
            matrix[minIndex][k] = temp;
        }
    }

    printf("Matrix after transformation:\n");
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            printf ("%d ", matrix[i][j]);
        }
        printf("\n");
    }

    return 0;
}
