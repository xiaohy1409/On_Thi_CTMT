.text
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la s1, RedLed

    andi t1, t0, 0xF # số N
    srli t0, t0, 4
    andi t2, t0, 0xF # số M

    mv a0, t1
    mv a1, t2

    jal x1, tinhToan

    mv x16, a0
    sw x16, 0(s1)
    j _start
tinhToan:   
    addi sp, sp, -4
    sw ra, 0(sp)

    beq a0, x0, ReturnB
    beq a1, x0, doneTinhToan
Loop:
    beq a0, a1, doneTinhToan
    blt a0, a1, ANhoHonB
    sub a0, a0, a1
    j Loop
ANhoHonB:
    sub a1, a1, a0
    j Loop
ReturnB:
    mv a0, a1

doneTinhToan:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
