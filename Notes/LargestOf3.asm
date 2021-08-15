# Output the largest of 3 numbers stored in memory
		.text
# Load number num1, num2, and num3 into registers $t1 - $t3
		lw		$t1, num1
		lw		$t2, num2
		lw		$t3, num3
# Goal: put the largest number into $a0
		move 	$a0, $t1			# assume $t1 is the largest
		blt		$t2, $a0, small2	# check if $t2 is larger than current largest
		move	$a0, $t2			# Store if $t2 is larger
small2:
		blt		$t3, $a0, small3	# check if $t3 is the largest
		move 	$a0, $t3			# Store if $t3 is larger
small3:

# Print largerst value
		addi	$v0, $0, 1			
		syscall
							
		.data
num1:	.word 14
num2:	.word 35
num3:	.word 17