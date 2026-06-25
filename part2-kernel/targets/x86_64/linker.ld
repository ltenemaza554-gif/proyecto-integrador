ENTRY(start)

SECTIONS {
    . = 1M;

    .boot :
    {
        /* asegura que el header multiboot2 esté al inicio */
        *(.multiboot_header)
    }

    .text :
    {
        *(.text)
    }
}
