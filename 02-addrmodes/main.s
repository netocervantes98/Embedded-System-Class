        .global _start
        .data
memcnt: .space 64,0             @ 4 byte space for result

        .text
        .align
_start:
        ldr   r0, =0x000000AA   @ r0 = 0x000000AA
        ldr   r1, =memcnt       @ r1 = &memcnt
        strb  r0, [r1,#12]
        nop
        nop
        nop
stop:   b stop

