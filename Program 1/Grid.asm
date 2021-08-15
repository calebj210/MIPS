##
# Create a grid of 0s and 1s
# 
# Author: Caleb Jacobs
# MTU username: cajacobs
#
# Date last modified: 01/23/2021
# Spring 2021 CS1142 R01
##

li 		$t4, 2			# define the number 2 for division

# Get first and store first integer from user in $t0
li		$v0, 5
syscall
move	$t0, $v0
blez	$t0, end		# End program if first integer <= 0
addi	$t0, $t0, -1	# Offset row counter by -1

# Get and store second integer from user in $t1
li		$v0, 5
syscall
move	$t1, $v0
blez	$t1, end		# End program if second integer <= 0

li 		$t2, 0			# Set row counter to 0

# Begin printing grid
# Loop decider
deciderLoop:
	li 		$t3, 1					# Set column counter to 1
	beqz	$t2, preOuterLoop		# Create top row of 1s
	
	# Begin new line
	li		$a0, 10					# Store newline character
	li		$v0, 11					# Prompt syscall to return a character
	syscall
	
	blt		$t2, $t0, preInnerLoop	# Create alternating row of 1s and 0s
	beq		$t2, $t0, preOuterLoop	# Create bottom row of 1s
	bgt		$t2, $t0, end			# Grid is done, end program

# Outer loop for top and bottom borders
preOuterLoop:
	addi	$t2, $t2, 1				# Increment row counter
	li		$a0, 1					# Set printable number to 1
	li		$v0, 1					# Set syscall to print $a0
	
	outerLoop:
		bgt		$t3, $t1, deciderLoop	# Stop printing 1s once row is filled
		syscall
		addi	$t3, $t3, 1				# Increment column counter
		
		b outerLoop						# Jumpt to beginning of loop

# Inner loop for printing alternating 1s and 0s
preInnerLoop:
	addi	$t2, $t2, 1				# Increment row counter
	li		$a0, 1					# Set printable number to 1
	li		$v0, 1					# Set syscall to print an integer
	syscall							# Print 1 at beginning of row
	
	li		$t3, 2					# Set column counter to 2
	
	add		$t5, $0, $t2			# Store	current working row
	addi	$t5, $t5, 2				# Add the column number to the working row with a 1 increment

	innerLoop:
		bge		$t3, $t1, endInnerLoop
		
		div		$t5, $t4			# Get (row/column sum) mod 2
		mfhi	$a0					# Move remainder (mod 2) to be printed
		syscall
		
		addi 	$t3, $t3, 1			# Increment column counter
		addi	$t5, $t5, 1			# Increment column/row sum
		
		b 		innerLoop
	endInnerLoop:
	
	blt		$t1, $t4, deciderLoop	# Check if the row needs to end in another 1
	
	li		$a0, 1					# Set printable number to 1
	li		$v0, 1					# Set syscall to print $a0
	syscall
	
	b		deciderLoop				# See what kind of loop we need for the next row
	
# End program
end:
