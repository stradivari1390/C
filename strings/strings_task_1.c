/**This code reads two strings S1 and S2 from the user,
 * then uses the strstr function to find the first occurrence of S2 within S1.
 * If strstr returns a non-null pointer, it subtracts the pointer to the start of S1
 * to find the starting position of S2 in S1 (add 1 to the result to make the position 1-based).
 * If strstr returns null (i.e., S2 is not found in S1), it prints 0.*/

#include <stdio.h>
#include <string.h>

#define N 50

int main() {
    char S1[N], S2[N];

    printf("\n2 lines are given: S1 & S2."
           "\nCheck up, whether line S2 in line S1 contains."
           "\nIf true - deduce number of position, since which S2 contains in S1,"
           "\nif false - print 0.\n");
    printf("Enter S1, then S2\n");

    fgets(S1, N, stdin);
    S1[strcspn(S1, "\n")] = 0;

    fgets(S2, N, stdin);
    S2[strcspn(S2, "\n")] = 0;

    char* found = strstr(S1, S2);

    if (found)
        printf("\n%lld", found - S1 + 1);
    else
        printf("\n0");

    return 0;
}
