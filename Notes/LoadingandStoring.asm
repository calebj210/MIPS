		.text				# .text = starts a section of code
		lw $t1, num1		# Load i $t1 the word located at label num1
		lw $t2, num1		# Load i $t2 the word located at label num2
		
		add $t3, $t1, $t2 	# $ t3 <- $t1 + $t2
		sw	$t3, sum		# Store $t3 at memory located at label sum
	
		.data				# .data = starts a section of data
num1:	.word 123			# .word = allocate 4 bytes, init to 123
num2:	.word 456			# another 4 bytes, init to 456
sum:	.word 0				# another 4 bytes, init to 0