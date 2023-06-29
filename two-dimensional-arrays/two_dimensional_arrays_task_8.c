/**
 * Program to delete the first positive column in a given MxN matrix.
 * The user is asked to input the dimensions of the matrix (M, N) and
 * the elements of the matrix. The program will then print the matrix
 * after deleting the first positive column.
 */

#include <stdio.h>

#define MAX_DIMENSION 10

int main() {
    int matrix[MAX_DIMENSION][MAX_DIMENSION], rows, columns;
    int temp[MAX_DIMENSION][MAX_DIMENSION];
    int positiveColumnIndex = -1;
    char input[50];

    printf("\nEnter the dimensions of the matrix (rows, then columns):\n");
    fgets(input, sizeof(input), stdin);
    sscanf(input, "%d%d", &rows, &columns);

    while((columns < 1 || columns > MAX_DIMENSION) || (rows < 1 || rows > MAX_DIMENSION)) {
        printf("Invalid dimensions. Please enter again (remember: 0 < rows, columns < 11):\n");
        fgets(input, sizeof(input), stdin);
        sscanf(input, "%d%d", &rows, &columns);
    }

    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < columns; j++) {
            printf("\nEnter element [%d][%d]: ", (i + 1), (j + 1));
            fgets(input, sizeof(input), stdin);
            sscanf(input, "%d", &matrix[i][j]);
        }
    }

    printf("\nOriginal matrix:\n");
    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < columns; j++) {
            printf("%d  ", matrix[i][j]);
        }
        printf("\n");
    }

    for(int j = 0; j < columns; j++) {
        int flag = 0;
        for(int i = 0; i < rows; i++) {
            if(matrix[i][j] > -1) {
                flag++;
            }
            if(flag == rows) {
                positiveColumnIndex = j;
                break;
            }
        }
        if(positiveColumnIndex != -1) {
            break;
        }
    }

    printf("\nMatrix after deleting the first positive column:\n");
    if(positiveColumnIndex != -1) {
        for(int i = 0; i < rows; i++) {
            for(int j = 0; j < positiveColumnIndex; j++) {
                temp[i][j] = matrix[i][j];
            }
            for(int j = positiveColumnIndex; j < columns - 1; j++) {
                temp[i][j] = matrix[i][j + 1];
            }
        }
        for(int i = 0; i < rows; i++) {
            for(int j = 0; j < columns - 1; j++) {
                printf("%d  ", temp[i][j]);
            }
            printf("\n");
        }
    }
    else {
        for(int i = 0; i < rows; i++) {
            for(int j = 0; j < columns; j++) {
                printf("%d  ", matrix[i][j]);
            }
            printf("\n");
        }
    }

    return 0;
}
