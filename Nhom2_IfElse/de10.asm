.text 
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
li sp, 0x03FFFFFC
    la s0, Switches
    lw s1, 0(s0)
    la s2, RedLed

    srli t0, s1, 2
    andi t0, t0, 0xFF # số N    
    li t1, 0 # biến kiểm tra điều kiện
    mv a0, t0
    
    # kiểm tra điều kiện 1:
    jal x1, MOD_Chia
    bne a0, x0, Check_2
    addi t1, t1, 1

    # kiểm tra điều kiện 2:
    li t2, 0x18
    bge t2, t0, Done
    li t3, 0x40
    bge t0, t3, Done
    addi t1, t1, 1

Done:
    li t4, 1
    bne t1, t4, Check_2
    li t4, 0x0F
    sw t4, 0(s2)
    j _start
Check_2:
    li t4, 2
    bne t1, t4, KoThoa
    li t4, 0xF0
    sw t4, 0(s2)
    j _start
KoThoa:
    li t4, 0x000
    sw t4, 0(s2)
    j _start

MOD_Chia:
    addi sp, sp, -4
    sw ra, 0(sp)
    li a1, 0x11
LOOP_Chia:
    blt a0, a1, DoneChia
    sub a0, a0, a1
    j LOOP_Chia

DoneChia:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(ra)

