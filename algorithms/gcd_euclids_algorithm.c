/**
 * This program computes the Greatest Common Divisor (GCD) of two numbers
 * using Euclid's algorithm.
 */

#include <stdio.h>
#include <stdlib.h>

int gcd(int number1, int number2) {
    int remainder;
    while (number2) {
        remainder = number1 % number2;
        number1 = number2;
        number2 = remainder;
    }
    return number1;
}

int main() {
    char input[50];
    int number1, number2, result;

    printf("\nThis program computes the Greatest Common Divisor (GCD) of two natural numbers\n");
    printf("using Euclid's algorithm.\n");
    printf("\nGive it a try! (e.g., GCD(16,72) = 8)\n");
    printf("\nEnter first number: ");
    fgets(input, sizeof(input), stdin);
    number1 = strtol(input, NULL, 10);

    printf("Enter second number: ");
    fgets(input, sizeof(input), stdin);
    number2 = strtol(input, NULL, 10);

    result = gcd(number1, number2);
    printf("\nThe GCD of %d and %d is %d\n", number1, number2, result);

    return 0;
}