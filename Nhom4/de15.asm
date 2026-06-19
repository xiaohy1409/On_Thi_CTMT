.text
.equ Switches, 0xFF200040
.equ HEX, 0xFF200020
.global _start
_start:
    li sp, 0x03FFFFFC
    la s0, Switches
    lw t0, 0(s0)
    la s1, HEX

    andi t1, t0, 0xF
    srli t0, t0, 4
    andi t2, t0, 0xF

    mv a0, t1
    mv a1, t2
    jal x1, TinhToan

tachSo:
    li t0, 0 # hàng chục
    mv t1, x16  #hàng đơn vị
    li t2, 10
LoopTachSo:
    blt t1, t2, traBang
    sub t1, t1, t2
    addi t0, t0, 1
    j LoopTachSo
traBang:
    la s2, SEVEN_SEG_DECODE_TABLE
    
    add a0, t0, s2
    lb t0, 0(a0)

    add a0, t1, s2
    lb t1, 0(a0)

    slli t0, t0, 8
    or t0, t0, t1

    sw t0, 0(s1)
    j _start

TinhToan: 
    addi sp, sp, -4
    sw ra, 0(sp)

    li t0, 0
    
    # tính t0 = A + B
    add t0, a0, a1

    # tính |a-b|
    blt a0, a1, AnhoHonB
    sub t1, a0, a1
    j skip
AnhoHonB:
    sub t1, a1, a0
skip:
    add t0, t0, t1
doneTinhToan:
    mv x16, t0
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)

.data
SEVEN_SEG_DECODE_TABLE: 
    .byte 0b00111111, 0b00000110, 0b01011011, 0b01001111 
    .byte 0b01100110, 0b01101101, 0b01111101, 0b00000111 
    .byte 0b01111111, 0b01100111, 0b00000000, 0b00000000 
    .byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
