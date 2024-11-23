	.file	"GCD.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	gcd
	.type	gcd, @function
gcd:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	j	.L2
.L3:
	lw	a5,-40(s0)
	sw	a5,-20(s0)
	lw	a5,-36(s0)
	lw	a1,-40(s0)
	mv	a0,a5
	call	__modsi3
	mv	a5,a0
	sw	a5,-40(s0)
	lw	a5,-20(s0)
	sw	a5,-36(s0)
.L2:
	lw	a5,-40(s0)
	bne	a5,zero,.L3
	lw	a5,-36(s0)
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	gcd, .-gcd
	.section	.rodata
	.align	2
.LC0:
	.string	"The GCD of %d and %d is: %d\n"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a5,20
	sw	a5,-20(s0)
	li	a5,40
	sw	a5,-24(s0)
	lw	a1,-24(s0)
	lw	a0,-20(s0)
	call	gcd
	sw	a0,-28(s0)
	lw	a3,-28(s0)
	lw	a2,-24(s0)
	lw	a1,-20(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.globl	__modsi3
	.ident	"GCC: (g04696df0963) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
