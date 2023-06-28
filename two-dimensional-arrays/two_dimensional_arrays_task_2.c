/** This is a simple command-line application in C that allows a user to input a matrix of integers
 * within specified dimensions (between 1 and 10 for both rows and columns).
 * The application will then manipulate the matrix by switching the first column with the last column
 * that contains only positive values, if such a column exists. The matrices before
 * and after the manipulation are printed out to the console for the user to see. */

#include <stdio.h>
#include <stdlib.h>

#define MAX_DIM 10
#define BUFFER_SIZE 32

int main() {
    int matrix[MAX_DIM][MAX_DIM], row, col, dimension_m, dimension_n;
    int positive_column_index = -1, positive_count, temp[MAX_DIM];
    char buffer[BUFFER_SIZE];

    printf("\nA matrix MxN is given.\nChange column #1 with the last positive column.\n");
    printf("Enter matrix's dimensions (M, then N):\n");

    fgets(buffer, BUFFER_SIZE, stdin);
    dimension_m = (int) strtol(buffer, NULL, 10);

    fgets(buffer, BUFFER_SIZE, stdin);
    dimension_n = (int) strtol(buffer, NULL, 10);

    while ((dimension_n < 1 || dimension_n > MAX_DIM) || (dimension_m < 1 || dimension_m > MAX_DIM)) {
        printf("Try again, remember: positive M & N are less or equal 10\n");

        fgets(buffer, BUFFER_SIZE, stdin);
        dimension_m = (int) strtol(buffer, NULL, 10);

        fgets(buffer, BUFFER_SIZE, stdin);
        dimension_n = (int) strtol(buffer, NULL, 10);
    }

    for (row = 0; row < dimension_m; row++) {
        for (col = 0; col < dimension_n; col++) {
            printf("\nEnter a[%d][%d]: ", (row + 1), (col + 1));
            fgets(buffer, BUFFER_SIZE, stdin);
            matrix[row][col] = (int) strtol(buffer, NULL, 10);
        }
    }

    printf("\nInitial matrix:\n");
    for (row = 0; row < dimension_m; row++) {
        for (col = 0; col < dimension_n; col++) {
            printf("%d ", matrix[row][col]);
        }
        printf("\n");
    }

    for (col = 0; col < dimension_n; col++) {
        positive_count = 0;
        for (row = 0; row < dimension_m; row++) {
            if (matrix[row][col] > -1) {
                positive_count++;
            }
        }
        if (positive_count == dimension_m) {
            positive_column_index = col;
        }
    }

    printf("\nFinal matrix:\n");
    if (positive_column_index != -1) {
        for (row = 0; row < dimension_m; row++) {
            temp[row] = matrix[row][positive_column_index];
            matrix[row][positive_column_index] = matrix[row][0];
            matrix[row][0] = temp[row];
        }
    }

    for (row = 0; row < dimension_m; row++) {
        for (col = 0; col < dimension_n; col++) {
            printf("%d ", matrix[row][col]);
        }
        printf("\n");
    }

    return 0;
}