#include <stdio.h>
#include <printf.h>

#define CHAR_DELETE (0x7f)
#define CURSOR_LEFT "\033[1D"

int readline_and_prompt(char *buf, int buflen) {
    if (buflen < 1) {
        return -1;
    }

    int i = 0;
    while (i < buflen - 1 && (buf[i] = getc()) != '\r') {
        // Check whether user hit <backspace>
        if (buf[i] == CHAR_DELETE) {
            // Don't go before the line origin
            if (i > 0) {
                i--;
                // Erase previous buffered char
                buf[i] = '\0';
                // Replace printed char with a space
                printf(CURSOR_LEFT " " CURSOR_LEFT);
            }
        } else {
            printf("%c", buf[i]);
            i++;
        }
    }
    buf[i] = '\0';
    printf("\n");

    return i;
}
