        .global _start
        .data
memcnt: .space 64,0             @ 4 byte space for result

        .text
        .align
_start:
        @ casi orig
        ldr   r0, =0xddccbbAA   @ r0 = 0x000000AA
        ldr   r1, =memcnt       @ r1 = &memcnt
        str  r0, [r1,#11]

        @ 8a
        @ ldr   r1, =0xAA
        @ ldr   r0, =0xA000000C
        @ str  r1, [r0]

        @ 8b
        @ ldr   r1, =0xAA
        @ ldr   r0, =0xA0000009
        @ str  r1, [r0, #4]

        @ 8c
        @ ldr   r1, =0xAA
        @ ldr   r2, =0x5
        @ ldr   r0, =0xA0000009
        @ str   r1, [r0, r2]

        @ 8d
        @ ldr   r1, =0xAA
        @ ldr   r0, =0xA000000F
        @ str   r1, [r0], #4

        @ 9a
        @ ldr   r1, =0xAABB
        @ ldr   r0, =0xA000000C
        @ strh  r1, [r0]

        @ 9b
        @ ldr   r1, =0xAABB
        @ ldr   r0, =0x9FFFFFFC
        @ strh  r1, [r0, #4]

        @ 10
        @ ldr   r1, =0xAABBCCDD
        @ ldr   r0, =0xA0000000
        @ str   r1, [r0]
        @ ldr   r3, [r0]

        @ str   r1, [r0, #0x10]
        @ ldrh    r1, [r0, #2]
        @ strh   r1, [r0, #0x20]
        @ ldrb    r1, [r0, #3]
        @ strb   r1, [r0, #0x30]

        nop
stop:   b stop

