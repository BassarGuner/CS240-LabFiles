LAB SESSION 2 : 

Created a RISCV32 dissambler in C code.

Dissambler tested in hex files that in the folder.

Test has been done in WSL environment using the command :

make
./ozu-riscv32 ../input/test1.hex  // ozu-riscv32 is the name of the C file. Input is the name of the folder that test1.hex in. test1 is the name of the file.


To generate the executable from the testAssembly.s file, assembled and linked the program using commands : 

riscv32-unknown-elf-as -mabi=ilp32 testAssembly.s -o testAssembly.o
riscv32-unknown-elf-ld -T myLinkScript.ld testAssembly.o -o testAssembly @ldoptions.txt
