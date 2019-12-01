#include <stdint.h>
#include <main-config.h>

__attribute__ ((section(".stack"), used)) uint8_t stack[MEM_STACK_SIZE];
