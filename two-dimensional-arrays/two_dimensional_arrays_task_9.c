/**
 * This program determines if a knight's move in chess is valid or not.
 * The chessboard is assumed to be an 8x8 grid.
 * The user inputs the starting and ending coordinates of the knight's move.
 * The program then checks if the move is valid according to the rules of chess.
 */

#include <stdio.h>
#include <stdlib.h>

int main() {
    float startX, startY, endX, endY;
    char input[50];

    printf("This program determines if a knight's move in chess is valid or not.\n");
    printf("Let's make a knight's move on an 8x8 chessboard!\n");

    printf("Enter the starting coordinates of the knight (x then y):\n");
    fgets(input, sizeof(input), stdin);
    startX = strtof(input, NULL);
    fgets(input, sizeof(input), stdin);
    startY = strtof(input, NULL);

    printf("Now enter the ending coordinates (x2 then y2):\n");
    fgets(input, sizeof(input), stdin);
    endX = strtof(input, NULL);
    fgets(input, sizeof(input), stdin);
    endY = strtof(input, NULL);

    if (((startX == endX + 2) && (startY == endY + 1)) || ((startX == endX - 2) && (startY == endY + 1)) ||
        ((startX == endX + 2) && (startY == endY - 1)) || ((startX == endX - 2) && (startY == endY - 1)) ||
        ((startX == endX + 1) && (startY == endY + 2)) || ((startX == endX - 1) && (startY == endY + 2)) ||
        ((startX == endX + 1) && (startY == endY - 2)) || ((startX == endX - 1) && (startY == endY - 2))) {
        printf("Excellent! That's a valid knight's move.\n");
    } else {
        printf("That's not a valid knight's move. Try again.\n");
    }

    return 0;
}
