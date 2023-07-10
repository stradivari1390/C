/**
 * @file next_day_calculator.c
 * @brief This program calculates the date of the next day given a valid date of a non-leap year.
 */

#include <stdio.h>

int main() {
    int day, month;
    int days_in_month[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    char *month_names[] = {"", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

    printf("Enter a valid date (day and month) of a non-leap year.\n");
    printf("Enter day, then month:\n");
    scanf("%d%d", &day, &month);

    while(month < 1 || month > 12) {
        printf("Invalid month! There are only 12 months in a year.\n");
        printf("Enter day, then month:\n");
        scanf("%d%d", &day, &month);
    }

    while(day < 1 || day > days_in_month[month]) {
        printf("Invalid day! There are %d days in %s.\n", days_in_month[month], month_names[month]);
        printf("Enter day, then month:\n");
        scanf("%d%d", &day, &month);
    }

    if(day < days_in_month[month]) {
        day++;
    } else {
        month = (month % 12) + 1;
        day = 1;
    }

    printf("The date of the next day is: %d of %s\n", day, month_names[month]);

    return 0;
}
