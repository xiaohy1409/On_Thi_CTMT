.text
.equ Switches, 0xFF200040
.equ HEX, 0xFF200020
.global _start
_start:
    la s0, Switches
    lw t0, 0(s0)
    la s1, HEX

    andi t0, t0, 0X3FF
    mv a0, t0
    jal x1, KiemTra
TachSo:
    li t0, 0 # hàng chục
    mv t1, a0 # hàng đơn vị
    li  t2, 10
LoopTachSo:
    blt t1, t2, TraBang
    addi t0, t0, 1
    sub t1, t1, t2
    j LoopTachSo
TraBang:
    la s2, SEVEN_SEG_DECODE_TABLE

    add t2, t0, s2
    lb t3, 0(t2)

    add t2, t1, s2
    lb t4, 0(t2) 

    slli t3, t3, 8
    or t3, t3, t4

    sw t3, 0(s1)
    j _start

KiemTra:
    addi sp, sp, -4
    sw ra, 0(sp)

    li t1, 0
    li t3, 10
LoopKT:
    beq t3, x0, DoneKT
    andi t4, a0, 1
    srli a0, a0, 1
    addi t3, t3, -1
    beq t4, x0, LoopKT
    addi t1, t1, 1
    j LoopKT
DoneKT:
    mv a0, t1
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)

.data
SEVEN_SEG_DECODE_TABLE: 
    .byte 0b00111111, 0b00000110, 0b01011011, 0b01001111 
    .byte 0b01100110, 0b01101101, 0b01111101, 0b00000111 
    .byte 0b01111111, 0b01100111, 0b00000000, 0b00000000 
    .byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
