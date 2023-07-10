/**
 * This program calculates the sum of a series: 1-A+A^2-...+(-1)^N*A^N
 * The user is prompted to input the material number A and an integer N (>0).
 * The program ensures that N is greater than 0 before proceeding with the calculation.
 * The result is then printed to the console.
 */

#include <stdio.h>
#include <math.h>

int main() {
    int seriesLength, i;
    float materialNumber, sum = 0.0f;
    int sign = 1;

    printf("Enter the length of the series (N > 0) and the material number (A):\n");
    scanf("%d %f", &seriesLength, &materialNumber);

    while(seriesLength < 1) {
        printf("The length of the series must be greater than 0. Please enter the length of the series and the material number again:\n");
        scanf("%d %f", &seriesLength, &materialNumber);
    }

    for(i = 0; i <= seriesLength; i++) {
        sum += sign * pow(materialNumber, i);
        sign *= -1;
    }

    printf("The sum of the series is %.3f\n", sum);

    return 0;
}