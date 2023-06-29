/**
 * This program replaces the first occurrence of the name "Ivan" with "Petr"
 * in the user-inputted text.
 */

#include <stdio.h>
#include <string.h>
#define MAX_LEN 30

int main() {
    int i, text_len, ivan_index = -1;
    char text[MAX_LEN];

    printf("Enter a text up to %d characters long:\n", MAX_LEN-1);
    fgets(text, MAX_LEN, stdin);
    text_len = strlen(text);

    for (i = 0; i < text_len; i++) {
        if ((text[i-1] == 'I') && (text[i] == 'v') && (text[i+1] == 'a') && (text[i+2] == 'n')) {
            ivan_index = i-1;
            break;
        }
    }

    if (ivan_index != -1) {
        text[ivan_index] = 'P';
        text[ivan_index + 1] = 'e';
        text[ivan_index + 2] = 't';
        text[ivan_index + 3] = 'r';
    }

    printf("\nModified text: %s", text);

    return 0;
}