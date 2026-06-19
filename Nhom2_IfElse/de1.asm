.text
.equ Switches, 0XFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la t0, Switches
    lw t1, 0(t0)

    srli t1, t1, 2
    andi t1, t1, 0xF
    jal x1, TinhToan
    
    la t2, RedLed
    andi t3, x16, 1
    beq t3, x0, Chan

    li t4, 1
    beq t3, t4, Le 
Chan:  
    sw x16, 0(t2)
    j _start
Le: 
    slli x16, x16, 1
    addi x16, x16, 1
    sw x16, 0(t2)
    j _start
TinhToan:
    addi sp, sp, -8
    sw ra, 4(sp)
    sw s0, 0(sp)

    li s0, 0
    li t2, 1
LOOP:
    blt t1, x0, DONE
    add s0, s0, t2
    addi t2, t2, 2
    addi t1, t1, -1
    j LOOP
DONE: 
    mv x16, s0
    lw ra, 4(sp)
    lw s0, 0(sp)
    addi sp, sp, 8
    jalr x0, 0(x1)