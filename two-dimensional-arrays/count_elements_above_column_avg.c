/**
 * This program reads a MxN matrix of integers from the user,
 * calculates the average of each column and counts the number
 * of elements in each column that are greater than the column's average.
 */
#include <stdio.h>

#define MAX_SIZE 10

int main() {
    int matrix[MAX_SIZE][MAX_SIZE], row, column, numRows, numColumns;
    int columnAvg[MAX_SIZE], numAboveAvg[MAX_SIZE];
    int total = 0, count = 0;

    printf("\nEnter the dimensions of the matrix (rows, then columns):\n");
    scanf("%d%d", &numRows, &numColumns);

    while((numRows<1 || numRows>MAX_SIZE) || (numColumns<1 || numColumns>MAX_SIZE)) {
        printf("Invalid dimensions. Please enter values between 1 and 10.\n");
        scanf("%d%d", &numRows, &numColumns);
    }

    for(row=0; row<numRows; row++) {
        for(column=0; column<numColumns; column++) {
            printf("\nEnter element at position [%d][%d]: ", row+1, column+1);
            scanf("%d", &matrix[row][column]);
        }
    }

    printf("\nYour matrix:\n");
    for(row=0; row<numRows; row++) {
        for(column=0; column<numColumns; column++) {
            printf("%d ", matrix[row][column]);
        }
        printf("\n");
    }

    for(column=0; column<numColumns; column++) {
        for(row=0; row<numRows; row++) {
            total += matrix[row][column];
            count++;
        }
        columnAvg[column] = total / count;
        total = 0;
        count = 0;
    }

    for(column=0; column<numColumns; column++) {
        for(row=0; row<numRows; row++) {
            if(matrix[row][column] > columnAvg[column]) {
                count++;
            }
        }
        numAboveAvg[column] = count;
        count = 0;
    }

    for(column=0; column<numColumns; column++) {
        printf("\nThere are %d elements in column %d that are above the column's average.\n", numAboveAvg[column], column+1);
    }

    return 0;
}
