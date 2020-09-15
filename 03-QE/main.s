        .global _start
        .data
memcnt: .space 64,0             @ 4 byte space for result

        .text
        .align
_start:
        @ ldr     r0, =0xAABBCCDD   @ r0 = 0xAABBCCDD
        @ ldr     r1, =memcnt       @ r1 = &memcnt (points at 0xA0000000)
        @ str     r0, [r1,#0x00]
        @ strh     r0, [r1,#0x08]
        @ strb     r0, [r1,#0x10]

        ldr   r0, =0x00000001   @ r0 = 0x00000001
        ldr   r1, =memcnt       @ r1 = &memcnt
        @ Shifts: Multiply by 9
        add r2, r0, r0, LSL #3
        @ Shifts: Multiply by 3
        rsb r3, r0, r0, LSL #2

        mov r2, r0, LSL #7
        mov r3, r0, LSL #8

        
        @ IC4 Non Conditional Execution: 
        ldr r4, =0xA5A5A5A5
        mov r5, #1
        mov r6, #1
        cmp r5, r6
        bne skip1
        str r4, [r1,#0x00]
        b done
skip1:  str r4, [r1,#0x08]
done:   nop
        @  Conditional Execution: 
        ldr r4, =0xA5A5A5A5
        mov r5, #1
        mov r6, #0
        @ Add your code here
        cmp r5, r6        
        streq r4, [r1,#0x00]
        strne r4, [r1,#0x08]
        nop
stop:   b stop
