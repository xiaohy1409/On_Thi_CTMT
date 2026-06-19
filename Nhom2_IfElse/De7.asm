.text 
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)

    andi s1, t0, 0xF # số a
    srli t0, t0, 4
    andi s2, t0, 0xF # số b
    jal x1, TinhToan

    la s1, RedLed
    sw x16, 0(s1)
    j _start
TinhToan:
    addi sp, sp, -4
    sw ra, 0(sp)

    mv a0, s1
    mv a1, s1

    # tính a mũ 2
    jal x1, NhanHaiSo
    li x16, 0
    add x16, x16, a0

    # tính 3b = 2b + b:
    mv t2, s2
    slli t2, t2, 1
    add t2, t2, s2
    add x16, x16, t2

    # +25
    addi x16, x16, 25

    # tính |a-b|
    blt s1, s2, NhoHon
    sub t3, s1, s2
    j DoneTinhToan
NhoHon: 
    sub t3, s2, s1
DoneTinhToan:
    add x16, x16, t3
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)


NhanHaiSo:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    mv t0, a0
    li a0, 0
LoopNhan:
    beq t0, x0, DoneNhan
    add a0, a0, a1
    addi t0, t0, -1
    j LoopNhan
DoneNhan:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)