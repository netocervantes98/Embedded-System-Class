        .global _start
        .data
memcnt: .space 64,0             @ 4 byte space for result
av:      .space 4,0
bv:      .space 4,0
cv:      .space 4,0
dv:      .space 4,0
xv:      .space 4,0
yv:      .space 4,0

vv:     .space 20,0

        .text
        .align
_start:
        @ ldr     r0, =0xAABBCCDD   @ r0 = 0xAABBCCDD
        @ ldr     r1, =memcnt       @ r1 = &memcnt (points at 0xA0000000)
        @ str     r0, [r1,#0x00]
        @ strh     r0, [r1,#0x08]
        @ strb     r0, [r1,#0x10]

@         ldr   r0, =0x00000001   @ r0 = 0x00000001
@         ldr   r1, =memcnt       @ r1 = &memcnt
@         @ Shifts: Multiply by 9
@         add r2, r0, r0, LSL #3
@         @ Shifts: Multiply by 3
@         rsb r3, r0, r0, LSL #2

@         mov r2, r0, LSL #7
@         mov r3, r0, LSL #8

        
@         @ IC4 Non Conditional Execution: 
@         ldr r4, =0xA5A5A5A5
@         mov r5, #1
@         mov r6, #1
@         cmp r5, r6
@         bne skip1
@         str r4, [r1,#0x00]
@         b done
@ skip1:  str r4, [r1,#0x08]
@ done:   nop
@         @  Conditional Execution: 
@         ldr r4, =0xA5A5A5A5
@         mov r5, #1
@         mov r6, #0
@         @ Add your code here
@         cmp r5, r6        
@         streq r4, [r1,#0x00]
@         strne r4, [r1,#0x08]

@ ldr     r0, =av
@ ldr     r1, [r0]
@ ldr     r0, =bv
@ ldr     r2, [r0]
@ ldr     r0, =cv
@ ldr     r3, [r0]
@ ldr     r0, =dv
@ ldr     r4, [r0]

@ cmp     r1, r2
@ movgt   r5, #5
@ addgt   r6, r3, r4
@ suble   r6, r3, r4
@ ldrgt   r0, =xv
@ strgt   r5, [r0]
@ strle   r6, [r0]
@ ldrgt   r0, =yv
@ strgt   r6, [r0]

        ldr     r0, =vv
        ldr     r1, =0x05
        str     r1, [r0]
        ldr     r1, =0x02
        str     r1, [r0, #4]
        ldr     r1, =0x08
        str     r1, [r0, #8]
        ldr     r1, =0x04
        str     r1, [r0, #0xC]
        ldr     r1, =0x01
        str     r1, [r0, #0x10]
        mov     r4, #4
        mov     r3, #0
        mov     r2, #0
again:  ldr     r1, [r0]
        add     r0, r0, #4
        add     r3, r3, #1
        cmp     r2, r1
        movlt   r2, r1
        cmp     r3, r4
        bne     again
        ldr     r0, =vv
        str     r2, [r0, #0x20]

        nop
stop:   b stop
