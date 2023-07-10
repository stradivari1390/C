/**
 * This program calculates the percentage of the original volume of liquid
 * that a fish will occupy in an aquarium. The user inputs the diameter of the fish
 * and the edge length of the aquarium. The program then calculates and prints the
 * percentage if the fish can fit in the aquarium.
 */

#include<stdio.h>

int main() {
    float fish_diameter, aquarium_edge, pi, volume_percentage;
    pi = 3.14;

    printf("Enter the diameter of the fish\n");
    if (scanf("%f", &fish_diameter) != 1) {
        printf("Invalid input. Please enter a number.\n");
        return 1;
    }

    printf("Now, enter the edge length of the aquarium\n");
    if (scanf("%f", &aquarium_edge) != 1) {
        printf("Invalid input. Please enter a number.\n");
        return 1;
    }

    if (fish_diameter <= aquarium_edge) {
        volume_percentage = (pi * fish_diameter * fish_diameter * fish_diameter) / (6 * aquarium_edge * aquarium_edge * aquarium_edge);
        printf("The fish occupies %5.1f percent of the original volume of the liquid\n", volume_percentage * 100);
    } else {
        printf("Try to fit such a fish in such an aquarium first =) \n");
    }

    return 0;
}
