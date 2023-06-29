/**
 * This program receives a MxN matrix from the user, where M and N are integers between 1 and 10.
 * It finds and prints the maximal element among those columns which are ordered in decreasing order.
 * If there aren't any ordered columns, it prints 0.
 */

#include <stdio.h>
#include <stdlib.h>

#define MAX_DIM 10

int main() {
    int matrix[MAX_DIM][MAX_DIM], row, col, dimension_m, dimension_n, max_value = -999, ordered_flag = 0, temp[MAX_DIM][MAX_DIM], ordered_columns = 0;
    char input[20];

    printf("\nEnter the dimensions of the matrix (M, then N):\n");
    fgets(input, sizeof(input), stdin);
    dimension_m = (int) strtol(input, NULL, 10);
    fgets(input, sizeof(input), stdin);
    dimension_n = (int) strtol(input, NULL, 10);

    while((dimension_n < 1 || dimension_n > MAX_DIM) || (dimension_m < 1 || dimension_m > MAX_DIM)) {
        printf("Invalid input. Remember: 1 <= M, N <= 10.\n");
        fgets(input, sizeof(input), stdin);
        dimension_m = (int) strtol(input, NULL, 10);
        fgets(input, sizeof(input), stdin);
        dimension_n = (int) strtol(input, NULL, 10);
    }

    for(row = 0; row < dimension_m; row++) {
        for(col = 0; col < dimension_n; col++) {
            printf("\nEnter element a[%d][%d]: ", (row + 1), (col + 1));
            fgets(input, sizeof(input), stdin);
            matrix[row][col] = (int) strtol(input, NULL, 10);
        }
    }

    printf("\nYour matrix is:\n");
    for(row = 0; row < dimension_m; row++) {
        for(col = 0; col < dimension_n; col++) {
            printf("%d ", matrix[row][col]);
        }
        printf("\n");
    }

    for(col = 0; col < dimension_n - 1; col++) {
        for(row = 0; row < dimension_m; row++) {
            if(matrix[row][col] > matrix[row][col + 1]) {
                ordered_flag++;
            }
        }
        if(ordered_flag == dimension_m) {
            for(row = 0; row < dimension_m; row++) {
                temp[row][ordered_columns] = matrix[row][col];
            }
            ordered_columns++;
        }
        ordered_flag = 0;
    }

    for(row = 0; row < dimension_m; row++) {
        for(col = 0; col < ordered_columns; col++) {
            if(temp[row][col] > max_value) {
                max_value = temp[row][col];
            }
        }
    }

    if(max_value != -999) {
        printf("\nThe maximal element among the columns in decreasing order is: %d\n", max_value);
    } else {
        printf("\nThere are no columns in decreasing order.\n");
    }

    return 0;
}
