/**
 * The program takes as input an even-dimensioned MxN matrix, 
 * and swaps the top-left and bottom-right quarters of the matrix.
 * Matrix dimensions M and N must be even numbers in the range 1 to 10.
 * Each element of the matrix should be an integer.
 */

#include <stdio.h>
#include <stdlib.h>

#define MAX_DIM 10

int main() {
    int matrix[MAX_DIM][MAX_DIM], temp_matrix[MAX_DIM][MAX_DIM];
    int rows, cols, row_idx, col_idx;

    printf("\nPlease provide the dimensions (M rows, N columns) of an MxN matrix."
           "\nBoth M and N must be even numbers within the range 1 to 10:\n");

    char m_input[10];
    fgets(m_input, 10, stdin);
    rows = atoi(m_input);

    char n_input[10];
    fgets(n_input, 10, stdin);
    cols = atoi(n_input);

    while ((rows < 1 || rows > MAX_DIM) || (cols < 1 || cols > MAX_DIM) || (rows % 2 != 0 || cols % 2 != 0)) {
        printf("Invalid input."
               "\nBoth dimensions must be even numbers within the range 1 to 10."
               "\nPlease try again:\n");
        fgets(m_input, 10, stdin);
        rows = atoi(m_input);
        fgets(n_input, 10, stdin);
        cols = atoi(n_input);
    }

    for (row_idx = 0; row_idx < rows; row_idx++) {
        for (col_idx = 0; col_idx < cols; col_idx++) {
            printf("Enter matrix element a[%d][%d]:\n", (row_idx + 1), (col_idx + 1));
            char element_input[10];
            fgets(element_input, 10, stdin);
            matrix[row_idx][col_idx] = atoi(element_input);
        }
    }

    printf("\nOriginal matrix:\n");
    for (row_idx = 0; row_idx < rows; row_idx++) {
        for (col_idx = 0; col_idx < cols; col_idx++) {
            printf("%d ", matrix[row_idx][col_idx]);
        }
        printf("\n");
    }

    for (row_idx = 0; row_idx < rows / 2; row_idx++) {
        for (col_idx = 0; col_idx < cols / 2; col_idx++) {
            temp_matrix[row_idx][col_idx] = matrix[row_idx][col_idx];
            matrix[row_idx][col_idx] = matrix[row_idx + rows / 2][col_idx + cols / 2];
            matrix[row_idx + rows / 2][col_idx + cols / 2] = temp_matrix[row_idx][col_idx];
        }
    }

    printf("\nModified matrix:\n");
    for (row_idx = 0; row_idx < rows; row_idx++) {
        for (col_idx = 0; col_idx < cols; col_idx++) {
            printf("%d ", matrix[row_idx][col_idx]);
        }
        printf("\n");
    }

    return 0;
}