.text
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la s1, RedLed

    andi t1, t0, 0xF # số A
    srli t2, t0, 4
    andi t2, t2, 0xF # số B

    # kiểm tra A:
    mv a0, t1
    mv a1, t2
    jal x1, KiemTra
doneMain:
    sw a0, 0(s1)
    j _start

KiemTra:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s3, 0(sp)

    mv s0, a0
    mv s1, a1
    
    #kiem tra A:
    jal x1, modChia
    li s3, 0
    add s3, s3, a0

    # kiểm tra B:
    mv a0, s1
    jal x1, modChia
    add s3, s3, a0

    # kiểm tra A+B:
    add a0, s0, s1
    jal x1, modChia
    add s3, s3, a0

    # kiểm tra A - B:
    sub a0, s0, s1
    blt a0, x0, doneKT
    jal x1, modChia
    add s3, s3, a0
doneKT:
    mv a0, s3
    lw s3, 0(sp)
    lw s1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16
    jalr x0, 0(x1)

modChia:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    li t0, 3
loopChia:
    blt a0, t0, KiemTraSoDu
    sub a0, a0, t0
    j loopChia
KiemTraSoDu:
    li t1, 1
    beq a0, t1, doneChia
    li a0, 0
doneChia:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
    
