	.text
	addi $t1, $0, 1073741824
	sw	 $t1, n4
	lb	 $a0, n5
	li	 $v0, 1
	syscall
	
	.data
n1:	.word	0			# n1 starts at 0
n2:	.word	10, 20, 30	# n2 starts at 4
n3:	.space	2			# n3 starts at 16
	.align	2			# Moves current addres to next 2^2 = 4 divisible spot in memory
n4:	.space	3			# n4 starts at 20
n5: .space 	1			# n5 starts at 23