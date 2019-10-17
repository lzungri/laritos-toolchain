#include <stdio.h>

void func(void) {
    volatile char *p = 0;
    *p = 'E';
}

static char data[100];
char datac[10] = { 1, 2, 3 };
char datac2[10] = { 1, 2, 3 };

int main(void) {
//    puts("Hello World!");
    volatile char *p = (char *) 0xffff;
    *p = 1;
    func();
    data[1] = 1;
    datac[1] = 2;
    datac2[1] = 2;
    return 0;
}
