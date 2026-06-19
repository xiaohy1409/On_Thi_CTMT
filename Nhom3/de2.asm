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
    jal x1, tinh_GT

doneMain:
    sw a0, 0(s1)
    j _start

tinh_GT:
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s0, 4(sp)
    sw s1, 0(sp)

    mv s0, a0
    li t0, 2
    add s1, s0, -1
    bge a0, t0, loop_GT
    li s0, 1
    j done_GT 
loop_GT:
    beq s1, x0, done_GT
    mv a0, s0
    mv a1, s1
    jal x1, NhanHaiSo
    mv s0, a0
    addi s1, s1, -1
    j loop_GT
done_GT:
    mv a0, s0
    lw ra, 8(sp)
    lw s0, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 12
    jalr x0, 0(x1)

NhanHaiSo:
    addi sp, sp, -4
    sw ra, 0(sp)

    mv t0, a0
    li a0, 0
loopNhan:
    beq a1, x0, DoneNhan
    add a0, a0, t0
    addi a1, a1, -1
    j loopNhan
DoneNhan:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
