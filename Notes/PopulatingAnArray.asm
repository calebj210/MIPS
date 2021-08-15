# Java code to populate an array with 0 to 10
#	int[] nums = new int[10];
#	int val = 123;
#
#	for (int i = 0; i < 10; i++) {
#		nums[i] = val;
#	}

# Fill array of 10 elements value
		.text
		li		$t0, 123			# val <- 123
		li		$t1, 0				# i <- 0
		li		$t2, 10				# loop bound

loop:
		bge		$t1, $t2, done		# exit if i >= 10
		
# Convert i to byte offset, multiply by 4
		add 	$t3, $t1, $t1		# $t3 <- i + i
		add		$t3, $t3, $t3		# $t3 <- 2i + 2i
		
		sw		$t0, nums($t3)		# nums[i] <- val
		
		addi $t1, $t1, 1			# i++
		b	 loop					# goto top of loop
done:

		.data
		.align 2	# 2^2 = 4 word alignment
nums:	
		.space 40	# Array of 10 (bytes/word)