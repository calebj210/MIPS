# Add the first two elements of an array , store in third element
# Uses immediate values to change element being loaded or stored
		.text
		lw	$t1, nums			# $t1 <- nums[0]
		
		lw	$t2, nums+4			# $t2 <- nums[1]
		
		add	$t3, $t1, $t2		# $t3 <- $t1 + $t2
		sw 	$t3, nums+8			# nums[2] <- $t3 = nums[0] + nums[1]
		
		.data
nums: 	.word 123, 456, 0