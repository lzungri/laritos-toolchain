#include <stdio.h>
#include <printf.h>

int readline_and_prompt(char *buf, int buflen) {
    if (buflen < 1) {
        return CHAR_EOF;
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
        } else if (buf[i] == CHAR_END_OF_TEXT) {
            return CHAR_EOF;
        } else {
            printf("%c", buf[i]);
            i++;
        }
    }
    buf[i] = '\0';
    printf("\n");

    return i;
}
