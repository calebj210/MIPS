		.text
		la	$t0, numA
		lw	$t1, ptrA
		lw	$t1, 0($t1)
		add	$a0, $t0, $t1
		li	$v0, 1
		syscall
		
		.data
numA:	.word 10
ptrA:	.word numA
