.text 
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la s1, RedLed

    srli t0, t0, 2
    andi t0, t0, 0xFF
    li t1, 0 # biến diếm điều kiện thõa mãn

    # kiểm tra điều kiện 1
    mv a0, t0
    jal x1, modChia
    bne a0, x0, CheckDK2
    addi t1, t1, 1
CheckDk2:
    li t2, 0x41
    bge t2, t0, DoneMain
    addi t1, t1, 1
DoneMain:
    li t3, 1
    bne t1, t3, DieuKien2
    li t3, 0xF
    sw t3, 0(s1)
    j _start
DieuKien2:
    li t3, 2
    bne t1, t3, ExitMain
    li t3, 0x3FF
    sw t3, 0(s1)
ExitMain:
    li t3, 0
    sw t3, 0(s1)
    j _start

modChia:
    addi sp, sp, -4
    sw ra, 0(sp)

    li a1, 0x14
Loop_chia:
    blt a0, a1, DoneChia
    sub a0, a0, t1
    j Loop_chia
DoneChia:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(ra)