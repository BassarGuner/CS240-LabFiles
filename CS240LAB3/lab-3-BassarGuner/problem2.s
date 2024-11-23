addi x1, x0, 11
addi x2, x0, 0
addi x3, x0, 1 
addi x4, x0, 2 

add x5, x2, x3
addi x2, x3,0
addi x3, x5, 0 
addi x4, x4, 1
bne x4, x1, -16

addi x7, x5, 0 
ecall

