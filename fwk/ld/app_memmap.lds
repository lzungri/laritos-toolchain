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
        *(.comment)
        *(.ARM.attributes)
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
    ASSERT(__text_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app .text")

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
    ASSERT(__bss_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app .bss")

    /* NOLOAD: Do not load it into memory. Here we use it to prevent allocating unnecessary
       space for the heap in the file itself (similar to .bss) */
    .heap (NOLOAD) : {
        . = ALIGN(4);
        __heap_start = ABSOLUTE(.);
        KEEP(*(.heap))
        . = ALIGN(4);
        __heap_end = ABSOLUTE(.);
    } > mem
    ASSERT(__heap_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app .heap")

    /* NOLOAD: Do not load it into memory. Here we use it to prevent allocating unnecessary
       space for the stack in the file itself (similar to .bss) */
    .stack (NOLOAD) : {
        . = ALIGN(4);
        __stack_start = ABSOLUTE(.);
        KEEP(*(.stack))
        . = ALIGN(4);
        __stack_end = ABSOLUTE(.);
    } > mem
    ASSERT(__stack_end < ORIGIN(mem) + LENGTH(mem), "Not enough memory to fit the app .stack")
}
