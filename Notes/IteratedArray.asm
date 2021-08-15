# Add the first two elements of an array, store in third element
# Uses register value to change element loaded or stored
		.text
		li	$t0, 0			# $t0 <- 0
		lw	$t1, nums($t0)	# $t1 <- nums[0]
		
		add	$t0, $t0, 4		# $t0 <- $t0 + 4
		lw	$t2, nums($t0)	# t2 <- nums[1]
		
		add $t3, $t1, $t2	# $t3 <- $t1 + $t2
		add $t0, $t0, 4		# $t0 <0 $t0 + 4
		sw	$t3, nums($t0)	# nums[2] <- $t3
		
		.data
nums:	.word 123, 456, 0