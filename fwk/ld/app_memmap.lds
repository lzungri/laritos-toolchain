MEMORY
{
    mem : ORIGIN = 0x00000000, LENGTH = 0x800000000  /* 32 GB */
}

SECTIONS
{
    /* Point the location counter to the origin of the mem memory */
    . = ORIGIN(mem);

    /* Special ld section to ignore input sections */
    /DISCARD/ : {
        *(.ARM.exidx*)
        *(.ARM.extab*)
        *(.igot.*)
        *(.iplt)
    }

    /* App code */
    .text : {
        /* Code */
        . = ALIGN(4);
        __text_start = ABSOLUTE(.);
        /* Put the main() function right after the header so we know where to jump to start
           the app (implicit entry point).
           Note: each func has its own section thanks to -ffunction-sections */
        *(.text.main)
        *(.text)
        *(.text.*)

        /* Keep the read only data in the mem */
        *(.rodata*)

        /* ARM stuff */
        *(.glue*)
        *(.vfp11_veneer)
        *(.v4_bx*)

        . = ALIGN(4);
        __text_end = ABSOLUTE(.);
    } > mem
    __text_size = __text_end - __text_start;

    /* Data section/s will be manually relocated in ram. */
    .data : {
        . = ALIGN(4);
        __data_start = ABSOLUTE(.);
        . = ALIGN(4);
        *(.data)
        *(.data.*)

        . = ALIGN(4);
        __got_start = ABSOLUTE(.);
        . = ALIGN(4);
        *(.got)
        *(.got.*)
        . = ALIGN(4);
        __got_end = ABSOLUTE(.);
        . = ALIGN(4);
        __data_end = ABSOLUTE(.);
     } > mem
    __data_size = __data_end - __data_start;
    __got_size = __got_end - __got_start;
    ASSERT(__data_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app .data")

    /* Non initialized data will be manually allocated (and zeroed) in ram */
    .bss : {
        . = ALIGN(4);
        __bss_start = ABSOLUTE(.);
        *(.bss)
        *(.bss.*)
        . = ALIGN(4);
        __bss_end = ABSOLUTE(.);
    } > mem
    __bss_size = __bss_end - __bss_start;
    ASSERT(__bss_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app .bss")

    /* Heap located right after the .bss section */
    . = ALIGN(4);
    __heap_start = .;
    __heap_size = 1 * 1024 * 1024;
    __heap_end = __heap_start + __heap_size;
    . = __heap_end;
    ASSERT(__heap_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app heap")

    /* Stack located right after the heap */
    . = ALIGN(4);
    __stack_end = .;
    __stack_size = 8 * 1024;
    __stack_top = __stack_end + __stack_size;
    . = __stack_top;
    ASSERT(__stack_top < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app stack")
}
