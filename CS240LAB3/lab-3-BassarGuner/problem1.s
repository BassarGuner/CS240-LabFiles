lui x1, 65536
addi x30, x0, 2024
sw x30, 0(x1)
lb x2, 0(x1)             
lb x3, 1(x1)            
lb x4, 2(x1)            
lb x5, 3(x1)
sb x2, 3(x1)            
sb x3, 2(x1)            
sb x4, 1(x1)            
sb x5, 0(x1)            
ecall                   