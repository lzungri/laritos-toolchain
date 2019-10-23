#include <stdint.h>
#include <main-config.h>

__attribute__ ((section(".heap"), used)) uint8_t heap[MEM_HEAP_SIZE];
