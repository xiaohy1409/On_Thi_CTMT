.text
.equ Key, 0xFF200050
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start
_start:
    li sp, 0x03FFFFFC # khai báo địa chỉ đầu stacks

    li t0, 0xF
    la t1, RedLed
    sw t0, 0(t1)
Loop:
    la s1, Key
Check_Key:
    lw t5, 0(s1)
    beq t5, x0, Check_Key

Wait:
    lw t6, 0(s1)
    bne t6, x0, Wait

    andi t5, t5, 0xE

    li t1, 2
    bne t5, t1, KiemTraKey2
    jal ra, DichTrai
KiemTraKey2:
    li t2, 4
    bne t5, t2, KiemTraKey3
    jal ra, DichPhai
KiemTraKey3:
    li t3, 8
    bne t5, t3, DONE
    jal ra, DocSwitches
DONE:
    j Loop

### hàm con
DichTrai:
    addi sp, sp, -4    
    sw ra, 0(sp)

    la t0, RedLed
    lw t1, 0(t0)

    srli t2, t1, 9
    andi t2, t2, 1

    slli t1, t1, 1
    li t3, 0x3FF
    and t1, t1, t3
    or t1, t1, t2

    sw t1, 0(t0)
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
DichPhai:
    addi sp, sp, -4
    sw ra, 0(sp)

    la t0, RedLed
    lw t1, 0(t0)

    andi t2, t1, 1
    slli t2, t2, 9

    srli t1, t1, 1
    or t1, t1, t2

    sw t1, 0(t0)
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
DocSwitches:
    addi sp, sp, -4
    sw ra, 0(sp)

    la t0, Switches
    lw t1, 0(t0)

    la t2, RedLed
    sw t1, 0(t2)
    
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)