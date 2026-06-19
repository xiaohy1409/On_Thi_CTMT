.text 
.equ Switches, 0xFF200040
.equ RedLed, 0xFF200000
.global _start

_start:
    li sp, 0x03FFFFFC
    la s0, Switches         # s0 giữ vĩnh viễn địa chỉ Switches
    la s1, RedLed           # s1 giữ vĩnh viễn địa chỉ RedLed
    
    lw t0, 0(s0)

    andi a0, t0, 0xF        # CHUẨN HÓA: Truyền số A thẳng vào a0
    srli t0, t0, 4
    andi a1, t0, 0xF        # CHUẨN HÓA: Truyền số B thẳng vào a1
    jal x1, TinhToan

    sw x16, 0(s1)           # In kết quả ra LED
    j _start

TinhToan:
    # --- MỞ STACK CHUẨN MỰC ---
    # Phải lưu ra, và lưu s2, s3 vì ta sẽ mượn chúng để cất giữ A và B
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s2, 4(sp)
    sw s3, 0(sp)

    # --- BẢO VỆ THAM SỐ GỐC ---
    mv s2, a0               # Cất A vào s2 an toàn
    mv s3, a1               # Cất B vào s3 an toàn

    # 1. Tính A^2 (Gọi NhanHaiSo với a0=A, a1=A)
    mv a0, s2
    mv a1, s2
    jal x1, NhanHaiSo       
    mv x16, a0              # Kết quả trả về lưu vào x16 (x16 = A^2)

    # 2. Tính 3B = 2B + B
    mv t2, s3               # Phục hồi B từ s3 để tính toán
    slli t2, t2, 1          # 2B
    add t2, t2, s3          # + B
    add x16, x16, t2        # x16 = A^2 + 3B

    # 3. Cộng 25
    addi x16, x16, 25

    # 4. Tính |A - B|
    blt s2, s3, NhoHon      # So sánh trực tiếp s2 (A) và s3 (B)
    sub t3, s2, s3
    j DoneTinhToan
NhoHon: 
    sub t3, s3, s2
DoneTinhToan:
    add x16, x16, t3        # Tổng kết quả cuối cùng
    
    # --- ĐÓNG STACK CHUẨN MỰC ---
    lw s3, 0(sp)
    lw s2, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    jalr x0, 0(x1)

NhanHaiSo:
    # --- KHUNG STACK BẮT BUỘC (Mặc dù là hàm lá) ---
    addi sp, sp, -4
    sw ra, 0(sp)
    
    mv t0, a0               # a0 hiện đang chứa số nhân
    li a0, 0                # a0 đóng vai trò lưu tổng (kết quả trả về)
LoopNhan:
    beq t0, x0, DoneNhan
    add a0, a0, a1
    addi t0, t0, -1
    j LoopNhan
DoneNhan:
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)