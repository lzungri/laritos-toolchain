#include <stdio.h>

void func(void) {
    volatile char *p = 0;
    *p = 'E';
}

static char data[100] = { 0 };

int main(void) {
//    puts("Hello World!");
    volatile char *p = (char *) 0xffff;
    *p = 1;
    func();
    data[1] = 1;
    return 0;
}
