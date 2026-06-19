.text
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la s1, RedLed

    andi x10, t0, 0xF
    srli t0, t0, 4
    andi x11, t0, 0XF
    li x12, 0

    jal x1, PhepNhan
doneMain:
    sw x12, 0(s1)
    j _start

PhepNhan:
    addi sp, sp, -4
    sw ra, 0(sp)

    li t0, 4

LoopNhan:
    beq t0, x0, doneNhan
    andi t1, x11, 1
    beq t1, x0, DichPhai
    slli t2, x10, 4
    add x12, x12, t2

DichPhai:
    srli x12, x12, 1
    srli x11, x11, 1
    addi t0, t0, -1
    j LoopNhan

doneNhan:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)