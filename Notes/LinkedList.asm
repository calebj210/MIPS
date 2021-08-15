		.text
		la		$t0, first		# Get pointer to first node
loop:
		lw		$a0, 0($t0)		# De-reference to get the value
		
		li		$v0, 1			# Print the integer
		syscall
		
		lw		$t0, 4($t0)		# Get pointer to next node
		bne		$t0, -1, loop 	# Loop if not end of list
		
		.data
first:	.word 111				# Vlaue stored at the first node
		.word node2				# Pointer to node after this one
		.space 54				# Causes a gap in memory
		
node2:	.word 	222				# Value stored aat the second node
		.word 	node3			# Pointer to node after this one
		.space 	54				# Causes a gap in memory
		
node3:	.word 	333				# Value stored at the third node
		.word	-1				# Denotes end of linked list