/**
 * This program generates a MxN matrix using a given set of M numbers.
 * The first column of the matrix is set to the given numbers.
 * For each row, every subsequent column value is calculated as the previous column's value plus a constant difference D.
 */

#include <stdio.h>

#define MAX_DIM 10

int main() {
    int matrix[MAX_DIM][MAX_DIM], rows, cols, difference;
    char input_buffer[100];

    printf("\nThree integers are given: M (number of rows), N (number of columns) and D (difference between columns).\n");
    printf("Also, a set of M numbers is given.\n");
    printf("The program will construct a MxN matrix: the first column is the given set, and A[i][j] = A[i][j-1] + D for j > 0.\n");

    printf("Enter the matrix's dimensions (M, then space, then N):\n");
    fgets(input_buffer, sizeof(input_buffer), stdin);
    sscanf(input_buffer, "%d%d", &rows, &cols);

    while ((cols < 1 || cols > MAX_DIM) || (rows < 1 || rows > MAX_DIM)) {
        printf("Try again, remember: 0 < M, N <= 10\n");
        fgets(input_buffer, sizeof(input_buffer), stdin);
        sscanf(input_buffer, "%d%d", &rows, &cols);
    }

    printf("Enter a set of %d numbers for the first column of the matrix:\n", rows);
    for (int row = 0; row < rows; row++) {
        fgets(input_buffer, sizeof(input_buffer), stdin);
        sscanf(input_buffer, "%d", &matrix[row][0]);
    }

    printf("\nEnter D (the constant difference between columns): ");
    fgets(input_buffer, sizeof(input_buffer), stdin);
    sscanf(input_buffer, "%d", &difference);

    printf("\nConstructed matrix:\n");
    for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
            if (col != 0) {
                matrix[row][col] = matrix[row][col-1] + difference;
            }
            printf("%d ", matrix[row][col]);
        }
        printf("\n");
    }

    return 0;
}