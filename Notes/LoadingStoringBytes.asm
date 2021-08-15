	.text
	
	li		$t0, 100
	sb		$t0, positive
	
	li		$t0, -100
	sb		$t0, negative
	
	lb		$t1, positive
	lbu		$t2, positive
	
	lb		$t3, negative
	lbu		$t4, negative
	
	.data
positive:	.space 1
negative:	.space 1