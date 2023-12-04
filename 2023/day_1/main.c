#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool isDigit(char c) {
    return c >= '0' && c <= '9';
}

int part1() {
    FILE *file = fopen("input.txt", "r");
    char line[1024];

    if (file == NULL) {
        printf("Error opening file");
        return 1;
    }
    
    int sum = 0; 
    while (fgets(line, sizeof(line), file) != NULL) {
        char firstDigit;
        char lastDigit = '\0';
        bool firstDigitFound = false;

        for (int i = 0; i < 1024; i++) {
            if (line[i] == '\0') {
                break;
            }
            
            if (isDigit(line[i]) && !firstDigitFound) {
                firstDigit = line[i];
                firstDigitFound = true;
            } else if (isDigit(line[i])) {
                lastDigit = line[i];
            }
        }
        if (lastDigit == '\0') {
            lastDigit = firstDigit;
        }

        char combined[3] = {firstDigit, lastDigit, '\0'};
        int number = atoi(combined);
        sum += number;
    }
    fclose(file); 

    printf("%d\n", sum);

    return 0;
}

int main() {
    part1();
    part2();
    return 0;
}
