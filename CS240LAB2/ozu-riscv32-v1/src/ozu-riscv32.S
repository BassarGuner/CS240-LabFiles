	.file	"ozu-riscv32.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	MEM_REGIONS
	.data
	.align	2
	.type	MEM_REGIONS, @object
	.size	MEM_REGIONS, 24
MEM_REGIONS:
	.word	65536
	.word	268435456
	.word	0
	.word	268435456
	.word	-1073741825
	.word	0
	.globl	CURRENT_STATE
	.bss
	.align	2
	.type	CURRENT_STATE, @object
	.size	CURRENT_STATE, 132
CURRENT_STATE:
	.zero	132
	.globl	NEXT_STATE
	.align	2
	.type	NEXT_STATE, @object
	.size	NEXT_STATE, 132
NEXT_STATE:
	.zero	132
	.globl	RUN_FLAG
	.section	.sbss,"aw",@nobits
	.align	2
	.type	RUN_FLAG, @object
	.size	RUN_FLAG, 4
RUN_FLAG:
	.zero	4
	.globl	INSTRUCTION_COUNT
	.align	2
	.type	INSTRUCTION_COUNT, @object
	.size	INSTRUCTION_COUNT, 4
INSTRUCTION_COUNT:
	.zero	4
	.globl	PROGRAM_SIZE
	.align	2
	.type	PROGRAM_SIZE, @object
	.size	PROGRAM_SIZE, 4
PROGRAM_SIZE:
	.zero	4
	.globl	prog_file
	.bss
	.align	2
	.type	prog_file, @object
	.size	prog_file, 32
prog_file:
	.zero	32
	.section	.rodata
	.align	2
.LC0:
	.string	"------------------------------------------------------------------\n"
	.align	2
.LC1:
	.string	"\t**********OZU-RV32 Disassembler and Simulator Help MENU**********\n"
	.align	2
.LC2:
	.string	"sim\t-- simulate program to completion "
	.align	2
.LC3:
	.string	"run <n>\t-- simulate program for <n> instructions"
	.align	2
.LC4:
	.string	"rdump\t-- dump register values"
	.align	2
.LC5:
	.string	"reset\t-- clears all registers/memory and re-loads the program"
	.align	2
.LC6:
	.string	"input <reg> <val>\t-- set GPR <reg> to <val>"
	.align	2
.LC7:
	.string	"mdump <start> <stop>\t-- dump memory from <start> to <stop> address"
	.align	2
.LC8:
	.string	"print\t-- print the program loaded into memory"
	.align	2
.LC9:
	.string	"?\t-- display help menu"
	.align	2
.LC10:
	.string	"quit\t-- exit the simulator\n"
	.text
	.align	2
	.globl	help
	.type	help, @function
help:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	puts
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	puts
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	puts
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	puts
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	puts
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	puts
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	puts
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	help, .-help
	.align	2
	.globl	mem_read_32
	.type	mem_read_32, @function
mem_read_32:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	zero,-20(s0)
	j	.L3
.L6:
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	lw	a4,-36(s0)
	bltu	a4,a5,.L4
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	lw	a4,-36(s0)
	bgtu	a4,a5,.L4
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	lw	a4,-36(s0)
	sub	a5,a4,a5
	sw	a5,-24(s0)
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,8(a5)
	lw	a5,-24(s0)
	addi	a5,a5,3
	add	a5,a4,a5
	lbu	a5,0(a5)
	slli	a3,a5,24
	lui	a5,%hi(MEM_REGIONS)
	addi	a2,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a2,a5
	lw	a4,8(a5)
	lw	a5,-24(s0)
	addi	a5,a5,2
	add	a5,a4,a5
	lbu	a5,0(a5)
	slli	a5,a5,16
	or	a3,a3,a5
	lui	a5,%hi(MEM_REGIONS)
	addi	a2,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a2,a5
	lw	a4,8(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	add	a5,a4,a5
	lbu	a5,0(a5)
	slli	a5,a5,8
	or	a3,a3,a5
	lui	a5,%hi(MEM_REGIONS)
	addi	a2,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a2,a5
	lw	a4,8(a5)
	lw	a5,-24(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	or	a5,a3,a5
	j	.L5
.L4:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L3:
	lw	a4,-20(s0)
	li	a5,1
	ble	a4,a5,.L6
	li	a5,0
.L5:
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	mem_read_32, .-mem_read_32
	.align	2
	.globl	mem_write_32
	.type	mem_write_32, @function
mem_write_32:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	j	.L8
.L10:
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	lw	a4,-36(s0)
	bltu	a4,a5,.L9
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	lw	a4,-36(s0)
	bgtu	a4,a5,.L9
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	lw	a4,-36(s0)
	sub	a5,a4,a5
	sw	a5,-24(s0)
	lw	a5,-40(s0)
	srli	a2,a5,24
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,8(a5)
	lw	a5,-24(s0)
	addi	a5,a5,3
	add	a5,a4,a5
	andi	a4,a2,0xff
	sb	a4,0(a5)
	lw	a5,-40(s0)
	srli	a2,a5,16
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,8(a5)
	lw	a5,-24(s0)
	addi	a5,a5,2
	add	a5,a4,a5
	andi	a4,a2,0xff
	sb	a4,0(a5)
	lw	a5,-40(s0)
	srli	a2,a5,8
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,8(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	add	a5,a4,a5
	andi	a4,a2,0xff
	sb	a4,0(a5)
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,8(a5)
	lw	a5,-24(s0)
	add	a5,a4,a5
	lw	a4,-40(s0)
	andi	a4,a4,0xff
	sb	a4,0(a5)
.L9:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L8:
	lw	a4,-20(s0)
	li	a5,1
	ble	a4,a5,.L10
	nop
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	mem_write_32, .-mem_write_32
	.align	2
	.globl	cycle
	.type	cycle, @function
cycle:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	handle_instruction
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lui	a5,%hi(NEXT_STATE)
	addi	a5,a5,%lo(NEXT_STATE)
	mv	a3,a5
	li	a5,132
	mv	a2,a5
	mv	a1,a3
	mv	a0,a4
	call	memcpy
	lui	a5,%hi(INSTRUCTION_COUNT)
	lw	a5,%lo(INSTRUCTION_COUNT)(a5)
	addi	a4,a5,1
	lui	a5,%hi(INSTRUCTION_COUNT)
	sw	a4,%lo(INSTRUCTION_COUNT)(a5)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	cycle, .-cycle
	.section	.rodata
	.align	2
.LC11:
	.string	"Simulation Stopped\n"
	.align	2
.LC12:
	.string	"Running simulator for %d cycles...\n\n"
	.align	2
.LC13:
	.string	"Simulation Stopped.\n"
	.text
	.align	2
	.globl	run
	.type	run, @function
run:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	lui	a5,%hi(RUN_FLAG)
	lw	a5,%lo(RUN_FLAG)(a5)
	bne	a5,zero,.L13
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	puts
	j	.L12
.L13:
	lw	a1,-36(s0)
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	printf
	sw	zero,-20(s0)
	j	.L15
.L17:
	lui	a5,%hi(RUN_FLAG)
	lw	a5,%lo(RUN_FLAG)(a5)
	bne	a5,zero,.L16
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	puts
	j	.L12
.L16:
	call	cycle
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L15:
	lw	a4,-20(s0)
	lw	a5,-36(s0)
	blt	a4,a5,.L17
.L12:
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	run, .-run
	.section	.rodata
	.align	2
.LC14:
	.string	"Simulation Started...\n"
	.align	2
.LC15:
	.string	"Simulation Finished.\n"
	.text
	.align	2
	.globl	runAll
	.type	runAll, @function
runAll:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	lui	a5,%hi(RUN_FLAG)
	lw	a5,%lo(RUN_FLAG)(a5)
	bne	a5,zero,.L19
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	puts
	j	.L18
.L19:
	lui	a5,%hi(.LC14)
	addi	a0,a5,%lo(.LC14)
	call	puts
	j	.L21
.L22:
	call	cycle
.L21:
	lui	a5,%hi(RUN_FLAG)
	lw	a5,%lo(RUN_FLAG)(a5)
	bne	a5,zero,.L22
	lui	a5,%hi(.LC15)
	addi	a0,a5,%lo(.LC15)
	call	puts
.L18:
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	runAll, .-runAll
	.section	.rodata
	.align	2
.LC16:
	.string	"-------------------------------------------------------------"
	.align	2
.LC17:
	.string	"Memory content [0x%08x..0x%08x] :\n"
	.align	2
.LC18:
	.string	"\t[Address in Hex (Dec) ]\t[Value]"
	.align	2
.LC19:
	.string	"\t0x%08x (%d) :\t0x%08x\n"
	.text
	.align	2
	.globl	mdump
	.type	mdump, @function
mdump:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lui	a5,%hi(.LC16)
	addi	a0,a5,%lo(.LC16)
	call	puts
	lw	a2,-40(s0)
	lw	a1,-36(s0)
	lui	a5,%hi(.LC17)
	addi	a0,a5,%lo(.LC17)
	call	printf
	lui	a5,%hi(.LC16)
	addi	a0,a5,%lo(.LC16)
	call	puts
	lui	a5,%hi(.LC18)
	addi	a0,a5,%lo(.LC18)
	call	puts
	lw	a5,-36(s0)
	sw	a5,-20(s0)
	j	.L24
.L25:
	lw	a0,-20(s0)
	call	mem_read_32
	mv	a5,a0
	mv	a3,a5
	lw	a2,-20(s0)
	lw	a1,-20(s0)
	lui	a5,%hi(.LC19)
	addi	a0,a5,%lo(.LC19)
	call	printf
	lw	a5,-20(s0)
	addi	a5,a5,4
	sw	a5,-20(s0)
.L24:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	bleu	a4,a5,.L25
	li	a0,10
	call	putchar
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	mdump, .-mdump
	.section	.rodata
	.align	2
.LC20:
	.string	"-------------------------------------"
	.align	2
.LC21:
	.string	"Dumping Register Content"
	.align	2
.LC22:
	.string	"# Instructions Executed\t: %u\n"
	.align	2
.LC23:
	.string	"PC\t: 0x%08x\n"
	.align	2
.LC24:
	.string	"[Register]\t[Value]"
	.align	2
.LC25:
	.string	"[R%d]\t: 0x%08x\n"
	.text
	.align	2
	.globl	rdump
	.type	rdump, @function
rdump:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC20)
	addi	a0,a5,%lo(.LC20)
	call	puts
	lui	a5,%hi(.LC21)
	addi	a0,a5,%lo(.LC21)
	call	puts
	lui	a5,%hi(.LC20)
	addi	a0,a5,%lo(.LC20)
	call	puts
	lui	a5,%hi(INSTRUCTION_COUNT)
	lw	a5,%lo(INSTRUCTION_COUNT)(a5)
	mv	a1,a5
	lui	a5,%hi(.LC22)
	addi	a0,a5,%lo(.LC22)
	call	printf
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC23)
	addi	a0,a5,%lo(.LC23)
	call	printf
	lui	a5,%hi(.LC20)
	addi	a0,a5,%lo(.LC20)
	call	puts
	lui	a5,%hi(.LC24)
	addi	a0,a5,%lo(.LC24)
	call	puts
	lui	a5,%hi(.LC20)
	addi	a0,a5,%lo(.LC20)
	call	puts
	sw	zero,-20(s0)
	j	.L27
.L28:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a2,a5
	lw	a1,-20(s0)
	lui	a5,%hi(.LC25)
	addi	a0,a5,%lo(.LC25)
	call	printf
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L27:
	lw	a4,-20(s0)
	li	a5,31
	ble	a4,a5,.L28
	lui	a5,%hi(.LC20)
	addi	a0,a5,%lo(.LC20)
	call	puts
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	rdump, .-rdump
	.section	.rodata
	.align	2
.LC26:
	.string	"OZU-RISCV SIM:> "
	.align	2
.LC27:
	.string	"%s"
	.align	2
.LC28:
	.string	"%x %x"
	.align	2
.LC29:
	.string	"**************************"
	.align	2
.LC30:
	.string	"Exiting OZU-RISCV! Good Bye..."
	.align	2
.LC31:
	.string	"%d"
	.align	2
.LC32:
	.string	"%u %i"
	.align	2
.LC33:
	.string	"Invalid Command."
	.text
	.align	2
	.globl	handle_command
	.type	handle_command, @function
handle_command:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	lui	a5,%hi(.LC26)
	addi	a0,a5,%lo(.LC26)
	call	printf
	addi	a5,s0,-36
	mv	a1,a5
	lui	a5,%hi(.LC27)
	addi	a0,a5,%lo(.LC27)
	call	scanf
	mv	a4,a0
	li	a5,-1
	bne	a4,a5,.L30
	li	a0,0
	call	exit
.L30:
	lbu	a5,-36(s0)
	addi	a5,a5,-63
	li	a4,52
	bgtu	a5,a4,.L31
	slli	a4,a5,2
	lui	a5,%hi(.L33)
	addi	a5,a5,%lo(.L33)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L33:
	.word	.L39
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L38
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L37
	.word	.L31
	.word	.L31
	.word	.L36
	.word	.L35
	.word	.L34
	.word	.L32
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L38
	.word	.L31
	.word	.L31
	.word	.L31
	.word	.L37
	.word	.L31
	.word	.L31
	.word	.L36
	.word	.L35
	.word	.L34
	.word	.L32
	.text
.L32:
	call	runAll
	j	.L40
.L37:
	addi	a4,s0,-44
	addi	a5,s0,-40
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(.LC28)
	addi	a0,a5,%lo(.LC28)
	call	scanf
	mv	a4,a0
	li	a5,2
	bne	a4,a5,.L49
	lw	a5,-40(s0)
	lw	a4,-44(s0)
	mv	a1,a4
	mv	a0,a5
	call	mdump
	j	.L40
.L39:
	call	help
	j	.L40
.L35:
	lui	a5,%hi(.LC29)
	addi	a0,a5,%lo(.LC29)
	call	puts
	lui	a5,%hi(.LC30)
	addi	a0,a5,%lo(.LC30)
	call	puts
	lui	a5,%hi(.LC29)
	addi	a0,a5,%lo(.LC29)
	call	puts
	li	a0,0
	call	exit
.L34:
	lbu	a4,-35(s0)
	li	a5,100
	beq	a4,a5,.L42
	lbu	a4,-35(s0)
	li	a5,68
	bne	a4,a5,.L43
.L42:
	call	rdump
	j	.L44
.L43:
	lbu	a4,-35(s0)
	li	a5,101
	beq	a4,a5,.L45
	lbu	a4,-35(s0)
	li	a5,69
	bne	a4,a5,.L46
.L45:
	call	reset
	j	.L44
.L46:
	addi	a5,s0,-48
	mv	a1,a5
	lui	a5,%hi(.LC31)
	addi	a0,a5,%lo(.LC31)
	call	scanf
	mv	a4,a0
	li	a5,1
	bne	a4,a5,.L50
	lw	a5,-48(s0)
	mv	a0,a5
	call	run
	j	.L40
.L44:
	j	.L40
.L38:
	addi	a4,s0,-56
	addi	a5,s0,-52
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(.LC32)
	addi	a0,a5,%lo(.LC32)
	call	scanf
	mv	a4,a0
	li	a5,2
	bne	a4,a5,.L51
	lw	a4,-56(s0)
	lw	a5,-52(s0)
	mv	a3,a4
	lui	a4,%hi(CURRENT_STATE)
	addi	a4,a4,%lo(CURRENT_STATE)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	lw	a4,-56(s0)
	lw	a5,-52(s0)
	mv	a3,a4
	lui	a4,%hi(NEXT_STATE)
	addi	a4,a4,%lo(NEXT_STATE)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L40
.L36:
	call	print_program
	j	.L40
.L31:
	lui	a5,%hi(.LC33)
	addi	a0,a5,%lo(.LC33)
	call	puts
	j	.L40
.L49:
	nop
	j	.L52
.L50:
	nop
	j	.L52
.L51:
	nop
.L40:
.L52:
	nop
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	handle_command, .-handle_command
	.align	2
	.globl	reset
	.type	reset, @function
reset:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	j	.L54
.L55:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	zero,4(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L54:
	lw	a4,-20(s0)
	li	a5,31
	ble	a4,a5,.L55
	sw	zero,-20(s0)
	j	.L56
.L57:
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a3,4(a5)
	lui	a5,%hi(MEM_REGIONS)
	addi	a2,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a2,a5
	lw	a5,0(a5)
	sub	a5,a3,a5
	addi	a5,a5,1
	sw	a5,-24(s0)
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,8(a5)
	lw	a2,-24(s0)
	li	a1,0
	mv	a0,a5
	call	memset
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L56:
	lw	a4,-20(s0)
	li	a5,1
	ble	a4,a5,.L57
	call	load_program
	lui	a5,%hi(INSTRUCTION_COUNT)
	sw	zero,%lo(INSTRUCTION_COUNT)(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	li	a4,65536
	sw	a4,0(a5)
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	mv	a3,a5
	li	a5,132
	mv	a2,a5
	mv	a1,a3
	mv	a0,a4
	call	memcpy
	lui	a5,%hi(RUN_FLAG)
	li	a4,1
	sw	a4,%lo(RUN_FLAG)(a5)
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	reset, .-reset
	.align	2
	.globl	init_memory
	.type	init_memory, @function
init_memory:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	j	.L59
.L60:
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a3,4(a5)
	lui	a5,%hi(MEM_REGIONS)
	addi	a2,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a2,a5
	lw	a5,0(a5)
	sub	a5,a3,a5
	addi	a5,a5,1
	sw	a5,-24(s0)
	lw	a0,-24(s0)
	call	malloc
	mv	a5,a0
	mv	a2,a5
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a2,8(a5)
	lui	a5,%hi(MEM_REGIONS)
	addi	a3,a5,%lo(MEM_REGIONS)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,1
	add	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,8(a5)
	lw	a2,-24(s0)
	li	a1,0
	mv	a0,a5
	call	memset
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L59:
	lw	a4,-20(s0)
	li	a5,1
	ble	a4,a5,.L60
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	init_memory, .-init_memory
	.section	.rodata
	.align	2
.LC34:
	.string	"r"
	.align	2
.LC35:
	.string	"Error: Can't open program file %s\n"
	.align	2
.LC36:
	.string	"writing 0x%08x into address 0x%08x (%d)\n"
	.align	2
.LC37:
	.string	"%x\n"
	.align	2
.LC38:
	.string	"Program loaded into memory.\n%d words written into memory.\n\n"
	.text
	.align	2
	.globl	load_program
	.type	load_program, @function
load_program:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC34)
	addi	a1,a5,%lo(.LC34)
	lui	a5,%hi(prog_file)
	addi	a0,a5,%lo(prog_file)
	call	fopen
	sw	a0,-24(s0)
	lw	a5,-24(s0)
	bne	a5,zero,.L62
	lui	a5,%hi(prog_file)
	addi	a1,a5,%lo(prog_file)
	lui	a5,%hi(.LC35)
	addi	a0,a5,%lo(.LC35)
	call	printf
	li	a0,-1
	call	exit
.L62:
	sw	zero,-20(s0)
	j	.L63
.L64:
	lw	a4,-20(s0)
	li	a5,65536
	add	a5,a4,a5
	sw	a5,-28(s0)
	lw	a5,-32(s0)
	mv	a1,a5
	lw	a0,-28(s0)
	call	mem_write_32
	lw	a5,-32(s0)
	lw	a3,-28(s0)
	lw	a2,-28(s0)
	mv	a1,a5
	lui	a5,%hi(.LC36)
	addi	a0,a5,%lo(.LC36)
	call	printf
	lw	a5,-20(s0)
	addi	a5,a5,4
	sw	a5,-20(s0)
.L63:
	addi	a5,s0,-32
	mv	a2,a5
	lui	a5,%hi(.LC37)
	addi	a1,a5,%lo(.LC37)
	lw	a0,-24(s0)
	call	fscanf
	mv	a4,a0
	li	a5,-1
	bne	a4,a5,.L64
	lw	a5,-20(s0)
	srai	a4,a5,31
	andi	a4,a4,3
	add	a5,a4,a5
	srai	a5,a5,2
	mv	a4,a5
	lui	a5,%hi(PROGRAM_SIZE)
	sw	a4,%lo(PROGRAM_SIZE)(a5)
	lui	a5,%hi(PROGRAM_SIZE)
	lw	a5,%lo(PROGRAM_SIZE)(a5)
	mv	a1,a5
	lui	a5,%hi(.LC38)
	addi	a0,a5,%lo(.LC38)
	call	printf
	lw	a0,-24(s0)
	call	fclose
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	load_program, .-load_program
	.section	.rodata
	.align	2
.LC39:
	.string	"Program exited with ECALL."
	.text
	.align	2
	.globl	handle_instruction
	.type	handle_instruction, @function
handle_instruction:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a5,0(a5)
	mv	a0,a5
	call	mem_read_32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	andi	a5,a5,127
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	srli	a5,a5,7
	andi	a5,a5,31
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	srli	a5,a5,12
	andi	a5,a5,7
	sw	a5,-32(s0)
	lw	a5,-20(s0)
	srli	a5,a5,15
	andi	a5,a5,31
	sw	a5,-36(s0)
	lw	a5,-20(s0)
	srli	a5,a5,20
	andi	a5,a5,31
	sw	a5,-40(s0)
	lw	a5,-20(s0)
	srli	a5,a5,25
	sw	a5,-44(s0)
	sw	zero,-48(s0)
	lw	a4,-24(s0)
	li	a5,115
	beq	a4,a5,.L66
	lw	a4,-24(s0)
	li	a5,115
	bgtu	a4,a5,.L67
	lw	a4,-24(s0)
	li	a5,111
	beq	a4,a5,.L68
	lw	a4,-24(s0)
	li	a5,111
	bgtu	a4,a5,.L67
	lw	a4,-24(s0)
	li	a5,99
	beq	a4,a5,.L69
	lw	a4,-24(s0)
	li	a5,99
	bgtu	a4,a5,.L67
	lw	a4,-24(s0)
	li	a5,3
	beq	a4,a5,.L70
	lw	a4,-24(s0)
	li	a5,3
	bltu	a4,a5,.L67
	lw	a4,-24(s0)
	li	a5,55
	bgtu	a4,a5,.L67
	lw	a4,-24(s0)
	li	a5,19
	bltu	a4,a5,.L67
	lw	a5,-24(s0)
	addi	a5,a5,-19
	li	a4,36
	bgtu	a5,a4,.L67
	slli	a4,a5,2
	lui	a5,%hi(.L72)
	addi	a5,a5,%lo(.L72)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L72:
	.word	.L76
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L75
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L74
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L73
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L71
	.text
.L73:
	lw	a4,-32(s0)
	li	a5,7
	bgtu	a4,a5,.L133
	lw	a5,-32(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L79)
	addi	a5,a5,%lo(.L79)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L79:
	.word	.L85
	.word	.L84
	.word	.L83
	.word	.L133
	.word	.L82
	.word	.L81
	.word	.L80
	.word	.L78
	.text
.L85:
	lw	a5,-44(s0)
	bne	a5,zero,.L86
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L134
.L86:
	lw	a4,-44(s0)
	li	a5,32
	bne	a4,a5,.L88
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	sub	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L134
.L88:
	lw	a4,-44(s0)
	li	a5,1
	bne	a4,a5,.L134
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a3,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a3,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L134
.L84:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	andi	a5,a5,31
	sll	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L77
.L83:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	sltu	a5,a4,a5
	andi	a5,a5,0xff
	mv	a3,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L77
.L82:
	lw	a5,-44(s0)
	bne	a5,zero,.L89
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	xor	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L135
.L89:
	lw	a4,-44(s0)
	li	a5,1
	bne	a4,a5,.L135
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a3,a5
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a1,a5
	mv	a0,a3
	call	__divsi3
	mv	a5,a0
	mv	a3,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L135
.L81:
	lw	a5,-44(s0)
	bne	a5,zero,.L91
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	andi	a5,a5,31
	srl	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L136
.L91:
	lw	a4,-44(s0)
	li	a5,32
	bne	a4,a5,.L136
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a3,a5
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	andi	a5,a5,31
	sra	a5,a3,a5
	mv	a3,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L136
.L80:
	lw	a5,-44(s0)
	bne	a5,zero,.L93
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	or	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L137
.L93:
	lw	a4,-44(s0)
	li	a5,1
	bne	a4,a5,.L137
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a3,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a1,a5
	mv	a0,a3
	call	__udivsi3
	mv	a5,a0
	mv	a3,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L137
.L78:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	and	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L77
.L134:
	nop
	j	.L133
.L135:
	nop
	j	.L133
.L136:
	nop
	j	.L133
.L137:
	nop
.L77:
	j	.L133
.L76:
	lw	a5,-20(s0)
	srai	a5,a5,20
	sw	a5,-48(s0)
	lw	a4,-32(s0)
	li	a5,7
	bgtu	a4,a5,.L138
	lw	a5,-32(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L97)
	addi	a5,a5,%lo(.L97)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L97:
	.word	.L103
	.word	.L102
	.word	.L101
	.word	.L138
	.word	.L100
	.word	.L99
	.word	.L98
	.word	.L96
	.text
.L103:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L95
.L96:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	and	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L95
.L98:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	or	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L95
.L100:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	xor	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L95
.L102:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	andi	a5,a5,31
	sll	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L95
.L99:
	lw	a5,-48(s0)
	srai	a5,a5,10
	bne	a5,zero,.L104
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	andi	a5,a5,31
	srl	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L95
.L104:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a4,a5
	lw	a5,-48(s0)
	andi	a5,a5,31
	sra	a5,a4,a5
	mv	a3,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L95
.L101:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	sltu	a5,a4,a5
	andi	a5,a5,0xff
	mv	a3,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	nop
.L95:
	j	.L138
.L70:
	lw	a5,-20(s0)
	srai	a5,a5,20
	sw	a5,-48(s0)
	lw	a4,-32(s0)
	li	a5,5
	bgtu	a4,a5,.L139
	lw	a5,-32(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L108)
	addi	a5,a5,%lo(.L108)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L108:
	.word	.L112
	.word	.L111
	.word	.L110
	.word	.L139
	.word	.L109
	.word	.L107
	.text
.L110:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	mem_read_32
	mv	a3,a0
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L106
.L112:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	mem_read_32
	mv	a5,a0
	slli	a5,a5,24
	srai	a5,a5,24
	mv	a3,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L106
.L111:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	mem_read_32
	mv	a5,a0
	slli	a5,a5,16
	srai	a5,a5,16
	mv	a3,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L106
.L109:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	mem_read_32
	mv	a5,a0
	andi	a4,a5,255
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L106
.L107:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	mem_read_32
	mv	a5,a0
	slli	a4,a5,16
	srli	a4,a4,16
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	nop
.L106:
	j	.L139
.L74:
	lw	a5,-20(s0)
	srli	a5,a5,25
	slli	a4,a5,5
	lw	a5,-20(s0)
	srli	a5,a5,7
	andi	a5,a5,31
	or	a5,a4,a5
	sw	a5,-48(s0)
	lw	a4,-32(s0)
	li	a5,2
	beq	a4,a5,.L113
	lw	a4,-32(s0)
	li	a5,2
	bgtu	a4,a5,.L140
	lw	a5,-32(s0)
	beq	a5,zero,.L115
	lw	a4,-32(s0)
	li	a5,1
	beq	a4,a5,.L116
	j	.L140
.L113:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	add	a3,a4,a5
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a1,a5
	mv	a0,a3
	call	mem_write_32
	j	.L114
.L115:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	add	a3,a4,a5
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	andi	a5,a5,255
	mv	a1,a5
	mv	a0,a3
	call	mem_write_32
	j	.L114
.L116:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lw	a5,-48(s0)
	add	a3,a4,a5
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	slli	a5,a5,16
	srli	a5,a5,16
	mv	a1,a5
	mv	a0,a3
	call	mem_write_32
	nop
.L114:
	j	.L140
.L69:
	lw	a5,-20(s0)
	srli	a5,a5,31
	slli	a4,a5,12
	lw	a5,-20(s0)
	srli	a5,a5,7
	slli	a3,a5,11
	li	a5,4096
	addi	a5,a5,-2048
	and	a5,a3,a5
	or	a4,a4,a5
	lw	a5,-20(s0)
	srli	a5,a5,25
	slli	a5,a5,5
	andi	a5,a5,2016
	or	a4,a4,a5
	lw	a5,-20(s0)
	srli	a5,a5,8
	andi	a5,a5,15
	or	a5,a4,a5
	sw	a5,-48(s0)
	lw	a4,-32(s0)
	li	a5,7
	bgtu	a4,a5,.L141
	lw	a5,-32(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L119)
	addi	a5,a5,%lo(.L119)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L119:
	.word	.L124
	.word	.L123
	.word	.L141
	.word	.L141
	.word	.L122
	.word	.L121
	.word	.L120
	.word	.L118
	.text
.L124:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	bne	a4,a5,.L142
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a4,0(a5)
	lw	a5,-48(s0)
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a5,a5,%lo(NEXT_STATE)
	sw	a4,0(a5)
	j	.L142
.L123:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	beq	a4,a5,.L143
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a4,0(a5)
	lw	a5,-48(s0)
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a5,a5,%lo(NEXT_STATE)
	sw	a4,0(a5)
	j	.L143
.L122:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a3,a5
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	bge	a3,a5,.L144
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a4,0(a5)
	lw	a5,-48(s0)
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a5,a5,%lo(NEXT_STATE)
	sw	a4,0(a5)
	j	.L144
.L121:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a3,a5
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	blt	a3,a5,.L145
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a4,0(a5)
	lw	a5,-48(s0)
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a5,a5,%lo(NEXT_STATE)
	sw	a4,0(a5)
	j	.L145
.L120:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	bgeu	a4,a5,.L146
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a4,0(a5)
	lw	a5,-48(s0)
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a5,a5,%lo(NEXT_STATE)
	sw	a4,0(a5)
	j	.L146
.L118:
	lui	a5,%hi(CURRENT_STATE)
	addi	a4,a5,%lo(CURRENT_STATE)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a3,a5,%lo(CURRENT_STATE)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,4(a5)
	bltu	a4,a5,.L147
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a4,0(a5)
	lw	a5,-48(s0)
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a5,a5,%lo(NEXT_STATE)
	sw	a4,0(a5)
	j	.L147
.L142:
	nop
	j	.L141
.L143:
	nop
	j	.L141
.L144:
	nop
	j	.L141
.L145:
	nop
	j	.L141
.L146:
	nop
	j	.L141
.L147:
	nop
	j	.L141
.L71:
	lw	a4,-20(s0)
	li	a5,-4096
	and	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L67
.L75:
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a4,0(a5)
	lw	a3,-20(s0)
	li	a5,-4096
	and	a5,a3,a5
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	j	.L67
.L68:
	lw	a5,-20(s0)
	srli	a5,a5,31
	slli	a4,a5,20
	lw	a3,-20(s0)
	li	a5,1044480
	and	a5,a3,a5
	or	a4,a4,a5
	lw	a5,-20(s0)
	srli	a5,a5,20
	slli	a3,a5,11
	li	a5,4096
	addi	a5,a5,-2048
	and	a5,a3,a5
	or	a4,a4,a5
	lw	a5,-20(s0)
	srli	a5,a5,21
	slli	a5,a5,1
	andi	a5,a5,2046
	or	a5,a4,a5
	sw	a5,-48(s0)
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a5,0(a5)
	addi	a4,a5,4
	lui	a5,%hi(NEXT_STATE)
	addi	a3,a5,%lo(NEXT_STATE)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a4,0(a5)
	lw	a5,-48(s0)
	add	a4,a4,a5
	lui	a5,%hi(NEXT_STATE)
	addi	a5,a5,%lo(NEXT_STATE)
	sw	a4,0(a5)
	j	.L65
.L66:
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a4,72(a5)
	li	a5,93
	bne	a4,a5,.L148
	lui	a5,%hi(.LC39)
	addi	a0,a5,%lo(.LC39)
	call	puts
	lui	a5,%hi(RUN_FLAG)
	sw	zero,%lo(RUN_FLAG)(a5)
	j	.L148
.L133:
	nop
	j	.L67
.L138:
	nop
	j	.L67
.L139:
	nop
	j	.L67
.L140:
	nop
	j	.L67
.L141:
	nop
	j	.L67
.L148:
	nop
.L67:
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	lw	a5,0(a5)
	addi	a4,a5,4
	lui	a5,%hi(NEXT_STATE)
	addi	a5,a5,%lo(NEXT_STATE)
	sw	a4,0(a5)
.L65:
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	handle_instruction, .-handle_instruction
	.align	2
	.globl	initialize
	.type	initialize, @function
initialize:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	init_memory
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	li	a4,65536
	sw	a4,0(a5)
	lui	a5,%hi(NEXT_STATE)
	addi	a4,a5,%lo(NEXT_STATE)
	lui	a5,%hi(CURRENT_STATE)
	addi	a5,a5,%lo(CURRENT_STATE)
	mv	a3,a5
	li	a5,132
	mv	a2,a5
	mv	a1,a3
	mv	a0,a4
	call	memcpy
	lui	a5,%hi(RUN_FLAG)
	li	a4,1
	sw	a4,%lo(RUN_FLAG)(a5)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	initialize, .-initialize
	.align	2
	.globl	print_program
	.type	print_program, @function
print_program:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	j	.L151
.L152:
	lw	a4,-20(s0)
	li	a5,16384
	add	a5,a4,a5
	slli	a5,a5,2
	sw	a5,-24(s0)
	lw	a0,-24(s0)
	call	print_instruction
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L151:
	lw	a4,-20(s0)
	lui	a5,%hi(PROGRAM_SIZE)
	lw	a5,%lo(PROGRAM_SIZE)(a5)
	bltu	a4,a5,.L152
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	print_program, .-print_program
	.section	.rodata
	.align	2
.LC40:
	.string	"add x%d, x%d, x%d\n"
	.align	2
.LC41:
	.string	"sub x%d, x%d, x%d\n"
	.align	2
.LC42:
	.string	"mul x%d, x%d, x%d\n"
	.align	2
.LC43:
	.string	"sll x%d, x%d, x%d\n"
	.align	2
.LC44:
	.string	"slt x%d, x%d, x%d\n"
	.align	2
.LC45:
	.string	"xor x%d, x%d, x%d\n"
	.align	2
.LC46:
	.string	"div x%d, x%d, x%d\n"
	.align	2
.LC47:
	.string	"srl x%d, x%d, x%d\n"
	.align	2
.LC48:
	.string	"sra x%d, x%d, x%d\n"
	.align	2
.LC49:
	.string	"or x%d, x%d, x%d\n"
	.align	2
.LC50:
	.string	"divu x%d, x%d, x%d\n"
	.align	2
.LC51:
	.string	"and x%d, x%d, x%d\n"
	.align	2
.LC52:
	.string	"addi x%d, x%d, %d\n"
	.align	2
.LC53:
	.string	"andi x%d, x%d, %d\n"
	.align	2
.LC54:
	.string	"ori x%d, x%d, %d\n"
	.align	2
.LC55:
	.string	"xori x%d, x%d, %d\n"
	.align	2
.LC56:
	.string	"slli x%d, x%d, %d\n"
	.align	2
.LC57:
	.string	"SRLI x%d, x%d, %d\n"
	.align	2
.LC58:
	.string	"SRAI x%d, x%d, %d\n"
	.align	2
.LC59:
	.string	"SLTI x%d, x%d, %d\n"
	.align	2
.LC60:
	.string	"lw x%d, %d(x%d)\n"
	.align	2
.LC61:
	.string	"lb x%d, %d(x%d)\n"
	.align	2
.LC62:
	.string	"lh x%d, %d(x%d)\n"
	.align	2
.LC63:
	.string	"lbu x%d, %d(x%d)\n"
	.align	2
.LC64:
	.string	"lhu x%d, %d(x%d)\n"
	.align	2
.LC65:
	.string	"sw x%d, %d(x%d)\n"
	.align	2
.LC66:
	.string	"sb x%d, %d(x%d)\n"
	.align	2
.LC67:
	.string	"sh x%d, %d(x%d)\n"
	.align	2
.LC68:
	.string	"beq x%d, x%d, %d\n"
	.align	2
.LC69:
	.string	"bne x%d, x%d, %d\n"
	.align	2
.LC70:
	.string	"blt x%d, x%d, %d\n"
	.align	2
.LC71:
	.string	"bge x%d, x%d, %d\n"
	.align	2
.LC72:
	.string	"bltu x%d, x%d, %d\n"
	.align	2
.LC73:
	.string	"bgeu x%d, x%d, %d\n"
	.align	2
.LC74:
	.string	"lui x%d, 0x%x\n"
	.align	2
.LC75:
	.string	"auipc x%d, 0x%x\n"
	.align	2
.LC76:
	.string	"jal x%d, %d\n"
	.align	2
.LC77:
	.string	"ecall"
	.align	2
.LC78:
	.string	"unknown instruction"
	.text
	.align	2
	.globl	print_instruction
	.type	print_instruction, @function
print_instruction:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	sw	a0,-52(s0)
	lw	a0,-52(s0)
	call	mem_read_32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	andi	a5,a5,127
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	srli	a5,a5,7
	andi	a5,a5,31
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	srli	a5,a5,12
	andi	a5,a5,7
	sw	a5,-32(s0)
	lw	a5,-20(s0)
	srli	a5,a5,15
	andi	a5,a5,31
	sw	a5,-36(s0)
	lw	a5,-20(s0)
	srli	a5,a5,20
	andi	a5,a5,31
	sw	a5,-40(s0)
	lw	a5,-20(s0)
	srli	a5,a5,25
	sw	a5,-44(s0)
	lw	a4,-24(s0)
	li	a5,115
	beq	a4,a5,.L154
	lw	a4,-24(s0)
	li	a5,115
	bgtu	a4,a5,.L155
	lw	a4,-24(s0)
	li	a5,111
	beq	a4,a5,.L156
	lw	a4,-24(s0)
	li	a5,111
	bgtu	a4,a5,.L155
	lw	a4,-24(s0)
	li	a5,99
	beq	a4,a5,.L157
	lw	a4,-24(s0)
	li	a5,99
	bgtu	a4,a5,.L155
	lw	a4,-24(s0)
	li	a5,3
	beq	a4,a5,.L158
	lw	a4,-24(s0)
	li	a5,3
	bltu	a4,a5,.L155
	lw	a4,-24(s0)
	li	a5,55
	bgtu	a4,a5,.L155
	lw	a4,-24(s0)
	li	a5,19
	bltu	a4,a5,.L155
	lw	a5,-24(s0)
	addi	a5,a5,-19
	li	a4,36
	bgtu	a5,a4,.L155
	slli	a4,a5,2
	lui	a5,%hi(.L160)
	addi	a5,a5,%lo(.L160)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L160:
	.word	.L164
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L163
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L162
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L161
	.word	.L155
	.word	.L155
	.word	.L155
	.word	.L159
	.text
.L161:
	lw	a4,-32(s0)
	li	a5,7
	bgtu	a4,a5,.L214
	lw	a5,-32(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L167)
	addi	a5,a5,%lo(.L167)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L167:
	.word	.L173
	.word	.L172
	.word	.L171
	.word	.L214
	.word	.L170
	.word	.L169
	.word	.L168
	.word	.L166
	.text
.L173:
	lw	a5,-44(s0)
	bne	a5,zero,.L174
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC40)
	addi	a0,a5,%lo(.LC40)
	call	printf
	j	.L215
.L174:
	lw	a4,-44(s0)
	li	a5,32
	bne	a4,a5,.L176
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC41)
	addi	a0,a5,%lo(.LC41)
	call	printf
	j	.L215
.L176:
	lw	a4,-44(s0)
	li	a5,1
	bne	a4,a5,.L215
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC42)
	addi	a0,a5,%lo(.LC42)
	call	printf
	j	.L215
.L172:
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC43)
	addi	a0,a5,%lo(.LC43)
	call	printf
	j	.L165
.L171:
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC44)
	addi	a0,a5,%lo(.LC44)
	call	printf
	j	.L165
.L170:
	lw	a5,-44(s0)
	bne	a5,zero,.L177
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC45)
	addi	a0,a5,%lo(.LC45)
	call	printf
	j	.L216
.L177:
	lw	a4,-44(s0)
	li	a5,1
	bne	a4,a5,.L216
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC46)
	addi	a0,a5,%lo(.LC46)
	call	printf
	j	.L216
.L169:
	lw	a5,-44(s0)
	bne	a5,zero,.L179
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC47)
	addi	a0,a5,%lo(.LC47)
	call	printf
	j	.L217
.L179:
	lw	a4,-44(s0)
	li	a5,32
	bne	a4,a5,.L217
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC48)
	addi	a0,a5,%lo(.LC48)
	call	printf
	j	.L217
.L168:
	lw	a5,-44(s0)
	bne	a5,zero,.L181
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC49)
	addi	a0,a5,%lo(.LC49)
	call	printf
	j	.L218
.L181:
	lw	a4,-44(s0)
	li	a5,1
	bne	a4,a5,.L218
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC50)
	addi	a0,a5,%lo(.LC50)
	call	printf
	j	.L218
.L166:
	lw	a3,-40(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC51)
	addi	a0,a5,%lo(.LC51)
	call	printf
	j	.L165
.L215:
	nop
	j	.L214
.L216:
	nop
	j	.L214
.L217:
	nop
	j	.L214
.L218:
	nop
.L165:
	j	.L214
.L164:
	lw	a5,-20(s0)
	srai	a5,a5,20
	sw	a5,-48(s0)
	lw	a4,-32(s0)
	li	a5,7
	bgtu	a4,a5,.L219
	lw	a5,-32(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L186)
	addi	a5,a5,%lo(.L186)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L186:
	.word	.L192
	.word	.L191
	.word	.L190
	.word	.L219
	.word	.L189
	.word	.L188
	.word	.L187
	.word	.L185
	.text
.L192:
	lw	a3,-48(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC52)
	addi	a0,a5,%lo(.LC52)
	call	printf
	j	.L184
.L185:
	lw	a3,-48(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC53)
	addi	a0,a5,%lo(.LC53)
	call	printf
	j	.L184
.L187:
	lw	a3,-48(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC54)
	addi	a0,a5,%lo(.LC54)
	call	printf
	j	.L184
.L189:
	lw	a3,-48(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC55)
	addi	a0,a5,%lo(.LC55)
	call	printf
	j	.L184
.L191:
	lw	a5,-48(s0)
	andi	a5,a5,31
	mv	a3,a5
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC56)
	addi	a0,a5,%lo(.LC56)
	call	printf
	j	.L184
.L188:
	lw	a5,-48(s0)
	srai	a5,a5,10
	bne	a5,zero,.L193
	lw	a5,-48(s0)
	andi	a5,a5,31
	mv	a3,a5
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC57)
	addi	a0,a5,%lo(.LC57)
	call	printf
	j	.L184
.L193:
	lw	a5,-48(s0)
	andi	a5,a5,31
	mv	a3,a5
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC58)
	addi	a0,a5,%lo(.LC58)
	call	printf
	j	.L184
.L190:
	lw	a3,-48(s0)
	lw	a2,-36(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC59)
	addi	a0,a5,%lo(.LC59)
	call	printf
	nop
.L184:
	j	.L219
.L158:
	lw	a5,-20(s0)
	srai	a5,a5,20
	sw	a5,-48(s0)
	lw	a4,-32(s0)
	li	a5,5
	bgtu	a4,a5,.L220
	lw	a5,-32(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L197)
	addi	a5,a5,%lo(.L197)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L197:
	.word	.L201
	.word	.L200
	.word	.L199
	.word	.L220
	.word	.L198
	.word	.L196
	.text
.L199:
	lw	a3,-36(s0)
	lw	a2,-48(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC60)
	addi	a0,a5,%lo(.LC60)
	call	printf
	j	.L195
.L201:
	lw	a3,-36(s0)
	lw	a2,-48(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC61)
	addi	a0,a5,%lo(.LC61)
	call	printf
	j	.L195
.L200:
	lw	a3,-36(s0)
	lw	a2,-48(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC62)
	addi	a0,a5,%lo(.LC62)
	call	printf
	j	.L195
.L198:
	lw	a3,-36(s0)
	lw	a2,-48(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC63)
	addi	a0,a5,%lo(.LC63)
	call	printf
	j	.L195
.L196:
	lw	a3,-36(s0)
	lw	a2,-48(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC64)
	addi	a0,a5,%lo(.LC64)
	call	printf
	nop
.L195:
	j	.L220
.L162:
	lw	a5,-20(s0)
	srli	a5,a5,25
	slli	a4,a5,5
	lw	a5,-20(s0)
	srli	a5,a5,7
	andi	a5,a5,31
	or	a5,a4,a5
	sw	a5,-48(s0)
	lw	a4,-32(s0)
	li	a5,2
	beq	a4,a5,.L202
	lw	a4,-32(s0)
	li	a5,2
	bgtu	a4,a5,.L221
	lw	a5,-32(s0)
	beq	a5,zero,.L204
	lw	a4,-32(s0)
	li	a5,1
	beq	a4,a5,.L205
	j	.L221
.L202:
	lw	a3,-36(s0)
	lw	a2,-48(s0)
	lw	a1,-40(s0)
	lui	a5,%hi(.LC65)
	addi	a0,a5,%lo(.LC65)
	call	printf
	j	.L203
.L204:
	lw	a3,-36(s0)
	lw	a2,-48(s0)
	lw	a1,-40(s0)
	lui	a5,%hi(.LC66)
	addi	a0,a5,%lo(.LC66)
	call	printf
	j	.L203
.L205:
	lw	a3,-36(s0)
	lw	a2,-48(s0)
	lw	a1,-40(s0)
	lui	a5,%hi(.LC67)
	addi	a0,a5,%lo(.LC67)
	call	printf
	nop
.L203:
	j	.L221
.L157:
	lw	a5,-20(s0)
	srli	a5,a5,31
	slli	a4,a5,12
	lw	a5,-20(s0)
	srli	a5,a5,7
	slli	a3,a5,11
	li	a5,4096
	addi	a5,a5,-2048
	and	a5,a3,a5
	or	a4,a4,a5
	lw	a5,-20(s0)
	srli	a5,a5,25
	slli	a5,a5,5
	andi	a5,a5,2016
	or	a4,a4,a5
	lw	a5,-20(s0)
	srli	a5,a5,8
	andi	a5,a5,15
	or	a5,a4,a5
	sw	a5,-48(s0)
	lw	a4,-32(s0)
	li	a5,7
	bgtu	a4,a5,.L222
	lw	a5,-32(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L208)
	addi	a5,a5,%lo(.L208)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L208:
	.word	.L213
	.word	.L212
	.word	.L222
	.word	.L222
	.word	.L211
	.word	.L210
	.word	.L209
	.word	.L207
	.text
.L213:
	lw	a3,-48(s0)
	lw	a2,-40(s0)
	lw	a1,-36(s0)
	lui	a5,%hi(.LC68)
	addi	a0,a5,%lo(.LC68)
	call	printf
	j	.L206
.L212:
	lw	a3,-48(s0)
	lw	a2,-40(s0)
	lw	a1,-36(s0)
	lui	a5,%hi(.LC69)
	addi	a0,a5,%lo(.LC69)
	call	printf
	j	.L206
.L211:
	lw	a3,-48(s0)
	lw	a2,-40(s0)
	lw	a1,-36(s0)
	lui	a5,%hi(.LC70)
	addi	a0,a5,%lo(.LC70)
	call	printf
	j	.L206
.L210:
	lw	a3,-48(s0)
	lw	a2,-40(s0)
	lw	a1,-36(s0)
	lui	a5,%hi(.LC71)
	addi	a0,a5,%lo(.LC71)
	call	printf
	j	.L206
.L209:
	lw	a3,-48(s0)
	lw	a2,-40(s0)
	lw	a1,-36(s0)
	lui	a5,%hi(.LC72)
	addi	a0,a5,%lo(.LC72)
	call	printf
	j	.L206
.L207:
	lw	a3,-48(s0)
	lw	a2,-40(s0)
	lw	a1,-36(s0)
	lui	a5,%hi(.LC73)
	addi	a0,a5,%lo(.LC73)
	call	printf
	nop
.L206:
	j	.L222
.L159:
	lw	a5,-20(s0)
	srli	a5,a5,12
	mv	a2,a5
	lw	a1,-28(s0)
	lui	a5,%hi(.LC74)
	addi	a0,a5,%lo(.LC74)
	call	printf
	j	.L183
.L163:
	lw	a4,-20(s0)
	li	a5,-4096
	and	a5,a4,a5
	mv	a2,a5
	lw	a1,-28(s0)
	lui	a5,%hi(.LC75)
	addi	a0,a5,%lo(.LC75)
	call	printf
	j	.L183
.L156:
	lw	a5,-20(s0)
	srli	a5,a5,31
	slli	a4,a5,20
	lw	a3,-20(s0)
	li	a5,1044480
	and	a5,a3,a5
	or	a4,a4,a5
	lw	a5,-20(s0)
	srli	a5,a5,20
	slli	a3,a5,11
	li	a5,4096
	addi	a5,a5,-2048
	and	a5,a3,a5
	or	a4,a4,a5
	lw	a5,-20(s0)
	srli	a5,a5,21
	slli	a5,a5,1
	andi	a5,a5,2046
	or	a5,a4,a5
	sw	a5,-48(s0)
	lw	a2,-48(s0)
	lw	a1,-28(s0)
	lui	a5,%hi(.LC76)
	addi	a0,a5,%lo(.LC76)
	call	printf
	j	.L183
.L154:
	lui	a5,%hi(.LC77)
	addi	a0,a5,%lo(.LC77)
	call	puts
	j	.L183
.L155:
	lui	a5,%hi(.LC78)
	addi	a0,a5,%lo(.LC78)
	call	puts
	j	.L183
.L214:
	nop
	j	.L223
.L219:
	nop
	j	.L223
.L220:
	nop
	j	.L223
.L221:
	nop
	j	.L223
.L222:
	nop
.L183:
.L223:
	nop
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	print_instruction, .-print_instruction
	.section	.rodata
	.align	2
.LC79:
	.string	"\n********************************"
	.align	2
.LC80:
	.string	"Welcome to OZU-RISCV SIMULATOR..."
	.align	2
.LC81:
	.string	"*********************************\n"
	.align	2
.LC82:
	.string	"Error: You should provide input file.\nUsage: %s <input program> \n\n"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lui	a5,%hi(.LC79)
	addi	a0,a5,%lo(.LC79)
	call	puts
	lui	a5,%hi(.LC80)
	addi	a0,a5,%lo(.LC80)
	call	puts
	lui	a5,%hi(.LC81)
	addi	a0,a5,%lo(.LC81)
	call	puts
	lw	a4,-20(s0)
	li	a5,1
	bgt	a4,a5,.L225
	lw	a5,-24(s0)
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC82)
	addi	a0,a5,%lo(.LC82)
	call	printf
	li	a0,1
	call	exit
.L225:
	lw	a5,-24(s0)
	addi	a5,a5,4
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(prog_file)
	addi	a0,a5,%lo(prog_file)
	call	strcpy
	call	initialize
	call	load_program
	call	help
.L226:
	call	handle_command
	j	.L226
	.size	main, .-main
	.globl	__udivsi3
	.globl	__divsi3
	.globl	__mulsi3
	.ident	"GCC: (g04696df0963) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
