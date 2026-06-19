.text 
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la s1, RedLed

    andi t1, t0, 0xF # SỐ n
    srli t0, t0, 4
    andi t2, t0, 0x3 # số M

    mv a0, t1
    mv a1, t2

    jal x1, tinhLuyThua

DoneMain:
    sw x16, 0(s1)
    j _start
tinhLuyThua:
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s2, 4(sp)
    sw s3, 0(sp)

    li t3, 1
    beq a1, t3, DoneTinhLuyThua
    beq a1, x0, return1
    mv s2, a0
    addi s3, a1, -1
LoopLuyThua:
    beq s3, x0, DoneTinhLuyThua
    mv a1, s2
    jal x1, NhanHaiSo
    addi s3, s3, -1
    j LoopLuyThua
return1:
    li a0, 1
DoneTinhLuyThua:
    mv x16, a0
    lw ra, 8(sp)
    lw s2, 4(sp)
    lw s3, 0(sp)
    addi sp, sp, 12
    jalr x0, 0(x1)

NhanHaiSo:
    addi sp, sp, -4
    sw ra, 0(sp)

    mv t3, a0
    li a0, 0
LoopNhan:
    beq t3, x0, doneNhan
    add a0, a0, a1
    addi t3, t3, -1
    j LoopNhan
doneNhan:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
