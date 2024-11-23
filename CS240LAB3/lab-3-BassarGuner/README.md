RISCV32 ASSEMBLER


The C code provided in the folder takes RISCV32 instruction and assemble it to machine code hex.


S files:

File problem1.s holds instructions that converts big endian to little endian.

File problem2.s holds instructions that finds fibonacci number of a given value.


hex and bin files :

Generated using the command on WSL terminal :

./assembler problem1.s    and     ./assembler problem2.s



To create executable used commands: 

riscv32-unknown-elf-as -mabi=ilp32 problem1.asm -o problem1.o  
riscv32-unknown-elf-ld -T myLinkScript.ld -o problem1 problem1.o @ldoptions.tx  

Launch spike in debug mode to check if its correct by using command :

spike --isa=RV32IMA -d pk problem1


Afterwards type: 

untiln pc 0 00010000 


Finally press space until you see ecall(finishes program) and check memory's and register's value.
