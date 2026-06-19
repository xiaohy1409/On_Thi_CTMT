.text
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la s1, RedLed

    andi t0, t0, 0xF
    mv a0, t0
    li t1, 2
    bge a0, t1, tinhGiaiThua
    li a0, 1
    beq x0, x0, DoneMain
tinhGiaiThua:
    jal x1, TinhToan

DoneMain:
    
    sw a0, 0(s1)
    j _start

TinhToan: 
    addi sp, sp, -4
    sw ra, 0(sp)
    
    addi a1, a0, -1
LoopTinhToan:
    beq a1, x0, doneTinhToan
    jal x1, NhanHaiSo
    addi a1, a1, -1
    j LoopTinhToan
doneTinhToan:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
    
NhanHaiSo:
    addi sp, sp, -4
    sw ra, 0(sp)

    mv t0, a0
    li a0, 0
    mv t1, a1

loopNhan:
    beq t1, x0, exitNhan
    add a0, a0, t0
    addi t1, t1, -1
    j loopNhan
exitNhan:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)

    