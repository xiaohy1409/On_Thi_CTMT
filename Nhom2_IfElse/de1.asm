.text
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
    li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la, s1, RedLed

    srli t0, t0, 2
    andi t0, t0, 0xF
    mv a0, t0
    jal x1, TinhToan

# kiểm tra chẵn lẻ
    andi t1, x16, 1
    beq t1, x0, Chan
    slli x16, x16, 1
    addi x16, x16, 1
Chan:
    sw x16, 0(s1)
    j _start

TinhToan:
    addi sp, sp, -4
    sw ra, 0(sp)

    li t0, 0
    li t1, 1

Loop:
    beq a0, x0, doneTinhToan
    add t0, t0, t1
    addi t1, t1, 2
    addi a0, a0, -1
    j Loop
doneTinhToan:
    mv x16, t0
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
