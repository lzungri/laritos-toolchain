MEMORY
{
    mem : ORIGIN = 0x00000000, LENGTH = 0x800000000  /* 32 GB */
}

SECTIONS
{
    /* Point the location counter to the origin of the mem memory */
    . = ORIGIN(mem);

    /* Application binary header (appheader_t)*/
    .header : {
        /* "LARO" magic number */
        LONG(0x4F52414c);

        LONG(__text_start);
        LONG(__text_end);

        LONG(__data_start);
        LONG(__data_end);

        LONG(__got_start);
        LONG(__got_end);

        LONG(__bss_start);
        LONG(__bss_end);

        LONG(__heap_start);
        LONG(__heap_end);

        LONG(__stack_end);
        LONG(__stack_top);

        LONG(__reloc_start);
        LONG(__reloc_end);
    } > mem

    /* App code */
    .text : {
        /* Code */
        . = ALIGN(4);
        __text_start = ABSOLUTE(.);
        *(.text);
        *(.text.*);

        /* Keep the read only data in the mem */
        *(.rodata*);

        /* ARM stuff */
        *(.glue*);
        *(.vfp11_veneer);
        *(.v4_bx*);

        . = ALIGN(4);
        __text_end = ABSOLUTE(.);
        __text_size = __text_end - __text_start;
    } > mem

    /* Data section/s will be manually relocated in ram. */
    .data : {
        . = ALIGN(4);
        __data_start = ABSOLUTE(.);
        . = ALIGN(4);
        *(.data);
        *(.data.*);
        . = ALIGN(4);
        __data_end = ABSOLUTE(.);
        __data_size = __data_end - __data_start;

        . = ALIGN(4);
        __got_start = ABSOLUTE(.);
        . = ALIGN(4);
        *(.got);
        *(.got.*);
        . = ALIGN(4);
        __got_end = ABSOLUTE(.);
        __got_size = __got_end - __got_start;
     } > mem
    ASSERT(__data_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app .data")

    /* Non initialized data will be manually allocated (and zeroed) in ram */
    .bss : {
        . = ALIGN(4);
        __bss_start = ABSOLUTE(.);
        *(.bss);
        *(.bss.*);
        . = ALIGN(4);
        __bss_end = ABSOLUTE(.);
        __bss_size = __bss_end - __bss_start;
    } > mem
    ASSERT(__bss_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app .bss")

    /* Heap located right after the .bss section */
    . = ALIGN(4);
    __heap_start = .;
    __heap_end = __heap_start + 1 * 1024 * 1024;
    . = __heap_end;
    ASSERT(__heap_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app heap")

    /* Stack located right after the heap */
    . = ALIGN(4);
    __stack_end = .;
    __stack_top = __stack_end + 8 * 1024;
    __stack_size = __stack_top - __stack_end;
    ASSERT(__stack_top < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app stack")

    .reloc : {
        . = ALIGN(4);
        __reloc_start = ABSOLUTE(.);
        . = ALIGN(4);
        /* Only code relocations */
        *(.rel.text);
        . = ALIGN(4);
        __reloc_end = ABSOLUTE(.);
        __reloc_size = __reloc_end - __reloc_start;
     } > mem

    .misc : {
        . = ALIGN(4);
        __misc_start = ABSOLUTE(.);
        . = ALIGN(4);
        *(.igot.*);
        *(.iplt);
        /* All the other relocations */
        *(.rel.*);
        . = ALIGN(4);
        __misc_end = ABSOLUTE(.);
        __misc_size = __misc_end - __misc_start;
     } > mem
    ASSERT(__misc_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app .reloc")
}
