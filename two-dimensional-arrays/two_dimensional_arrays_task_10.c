/**
 * This program determines the quadrant in which a given point lies
 * based on its x and y coordinates.
 */

#include <stdio.h>
#include <stdlib.h>

int main() {
    char input[50];
    float coordinate_x, coordinate_y;

    printf("This program will determine which quadrant a point belongs to.\n");
    printf("Enter the coordinates of the point (x y):\n");
    fgets(input, sizeof(input), stdin);
    sscanf(input, "%f%f", &coordinate_x, &coordinate_y);

    if (coordinate_x > 0 && coordinate_y > 0)
        printf("The point lies in the first quadrant.\n");
    else if (coordinate_x < 0 && coordinate_y > 0)
        printf("The point lies in the second quadrant.\n");
    else if (coordinate_x < 0 && coordinate_y < 0)
        printf("The point lies in the third quadrant.\n");
    else if (coordinate_x > 0 && coordinate_y < 0)
        printf("The point lies in the fourth quadrant.\n");
    else if (coordinate_x == 0 && coordinate_y > 0)
        printf("The point lies on the positive y-axis.\n");
    else if (coordinate_x == 0 && coordinate_y < 0)
        printf("The point lies on the negative y-axis.\n");
    else if (coordinate_y == 0 && coordinate_x > 0)
        printf("The point lies on the positive x-axis.\n");
    else if (coordinate_y == 0 && coordinate_x < 0)
        printf("The point lies on the negative x-axis.\n");
    else if (coordinate_x == 0 && coordinate_y == 0)
        printf("The point lies at the origin.\n");

    return 0;
}
