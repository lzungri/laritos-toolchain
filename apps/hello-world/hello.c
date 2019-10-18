#include <stdio.h>

void func(void) {
    volatile char *p = 0;
    *p = 'E';
}

char data[0xaa];
char datac[16] = { 1, 2, 3 };
char datac2[16] = { 4, 5, 6 };

int main(void) {
//    puts("Hello World!");
    volatile char *p = (char *) 0xffff;
    *p = 1;
    func();
    data[0] = 0;
    datac[1] = 1;
    datac2[2] = 2;
    return 0;
}
