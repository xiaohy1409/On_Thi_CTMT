.text
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la s1, RedLed

    mv a0, t0
    jal x1, kiemTra
doneMain:
    sw a0, 0(s1)
    j _start
kiemTra:  
    addi sp, sp, -4
    sw ra, 0(sp)

    li t2, 0
    li t0, 7
    li t1, 0xD
LoopKT:
    beq t0, x0, DoneKT
    andi t3, a0, 0xF

    srli a0, a0, 1
    addi t0, t0, -1
    bne t1, t3, LoopKT
    addi t2, t2, 1
    j LoopKT
DoneKT:
    mv a0, t2
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)