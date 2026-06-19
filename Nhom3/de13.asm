.text
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la s1, RedLed

    andi t0, t0, 0xFF    # số N
    mv a0, t0
    jal x1, KiemTra_NT
doneMain:
    sw a0, 0(s1)
    j _start

KiemTra_NT:
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s0, 4(sp)
    sw s1, 0(sp)

    mv s0, a0
    li s1, 2
    bge s0, s1, LoopKT
    li a0, 0
    j exit
LoopKT:
    mv a0, s0
    mv a1, s1
    beq s0, s1, doneKT
    jal x1, modChia
    beq a0, 0, exit
    addi s1, s1, 1
    j LoopKT

doneKT:
    li a0, 0xFFFFFFFF
exit:
    lw ra, 8(sp)
    lw s0, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 12
    jalr x0, 0(x1)

modChia:
    addi sp, sp, -4
    sw ra, 0(sp)

    
loopChia:
    blt a0, a1, doneChia
    sub a0, a0, a1
    j loopChia
doneChia:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
