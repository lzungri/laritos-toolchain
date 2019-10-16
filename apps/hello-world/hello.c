#include <stdio.h>

int main(void) {
//    puts("Hello World!");
    volatile char *p = (char *) 0xffff;
    *p = 1;
    return 0;
}
