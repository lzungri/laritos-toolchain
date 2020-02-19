#include <stdio.h>
#include <printf.h>

int readline_and_prompt(char *buf, int buflen) {
    if (buflen < 1) {
        return -1;
    }

    int i;
    for (i = 0; i < buflen - 1 && ((buf[i] = getc()) != '\r'); i++) {
        printf("%c", buf[i]);
    }
    buf[i] = '\0';
    printf("\n");

    return i;
}
