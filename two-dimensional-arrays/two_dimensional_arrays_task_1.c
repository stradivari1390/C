/** code is trying to modify a matrix by inserting a column of ones
 * before the first column that only contains non-negative numbers. */

#include <stdio.h>
#include <stdlib.h>

#define M 10
#define N 10

int main() {
    int matrix[M][N], i, j, m, n, t = -1, flag = 0, result_matrix[M][N + 1];
    char buffer[50], *endptr;

    printf("\nA matrix MxN is given.\nPrint ones column before first positive column.\n");
    printf("Enter matrix's dimension (M + space + N):\n");

    fgets(buffer, sizeof(buffer), stdin);
    m = strtol(buffer, &endptr, 10);
    n = strtol(endptr, NULL, 10);

    while (n < 1 || n > 10 || m < 1 || m > 10) {
        printf("Try again, remember: M & N - from 1 to 10\n");
        fgets(buffer, sizeof(buffer), stdin);
        m = strtol(buffer, &endptr, 10);
        n = strtol(endptr, NULL, 10);
    }

    for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {
            printf("\nEnter a[%d][%d]: ", (i + 1), (j + 1));
            fgets(buffer, sizeof(buffer), stdin);
            matrix[i][j] = strtol(buffer, NULL, 10);
        }
    }

    printf("\nInitial matrix:\n");
    for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {
            printf("%d  ", matrix[i][j]);
        }
        printf("\n");
    }

    for (j = 0; j < n; j++) {
        for (i = 0; i < m; i++) {
            if (matrix[i][j] >= 0) flag++;
        }
        if (flag == m) {
            t = j;
            break;
        }
        flag = 0;
    }

    printf("\nMatrix with additional ones: \n");
    if (t != -1) {
        for (i = 0; i < m; i++) {
            for (j = 0; j <= n; j++) {
                if (j < t) result_matrix[i][j] = matrix[i][j];
                else if (j == t) result_matrix[i][j] = 1;
                else result_matrix[i][j] = matrix[i][j - 1];
            }
        }
        for (i = 0; i < m; i++) {
            for (j = 0; j <= n; j++) {
                printf("%d  ", result_matrix[i][j]);
            }
            printf("\n");
        }
    } else {
        for (i = 0; i < m; i++) {
            for (j = 0; j < n; j++) {
                printf("%d  ", matrix[i][j]);
            }
            printf("\n");
        }
    }

    getchar();
    return 0;
}