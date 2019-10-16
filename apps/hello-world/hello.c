#include <stdio.h>

void func(void) {
    volatile char *p = 0;
    *p = 'E';
}

int main(void) {
//    puts("Hello World!");
    volatile char *p = (char *) 0xffff;
    *p = 1;
    func();
    return 0;
}
