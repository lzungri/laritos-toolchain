#include <stdio.h>

char data[0xaa];
char datac[16] = { 1, 2, 3 };
char datac2[16] = { 4, 5, 6 };
char datac3[16] = { 8, 9, 0 };

void func(void) {
    data[1] = 1;
    datac3[1] = 2;
}

int main(void) {
//    puts("Hello World!");
    func();
    data[0] = 0;
    datac[1] = 1;
    datac2[2] = 2;
    return 0;
}
