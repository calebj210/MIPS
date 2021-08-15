##
# Print ascending and descending range of numbers from user input
# 
# Author: Caleb Jacobs
# MTU username: cajacobs
#
# Date last modified: 01/23/2021
# Spring 2021 CS1142 R01
##

# Read two integers from user
li 	$v0, 5
syscall
move	$t0, $v0				# Store first user value in $t0
move	$a0, $t0				# Set counter ($a0) to $t0

li		$v0, 5					# Prompt syscall to take second input
syscall							# Get second user input
move 	$t1, $v0				# Store second user value in $t1

# Begin increment print loop
incLoop:
	bgt		$a0, $t1, newLine	# Begin newline routine
	
	li 		$v0,	1			# Prompt syscall to print current number in range
	syscall						# Print current counter value
	li		$v0, 11				# Prompt syscal to print a character
	move 	$t2, $a0			# Temporarily store current number in range
	li		$a0, 32				# Store the space character for printing
	syscall						# Print space
	addi	$a0, $t2, 1			# Increment counter
	
	
	b	incLoop					# Restart loop

# Begin new line
newLine:
	li		$v0, 11				# Prompt syscall to print character
	move 	$t2, $a0			# Store current counter
	li		$a0, 10				# Set newline character
	syscall						# Print newline
	addi 	$a0, $t2, -1		# Store counter - 1 to begin counting down

# Begin decrement print loop
decLoop:
	blt		$a0, $t0, end		# Done counting down, so end the program
	
	li 		$v0,	1			# Prompt syscall to print counter
	syscall						# Print current counter value
	li		$v0, 11				# Prompt syscall to print a character
	move 	$t2, $a0			# Store current counter
	li		$a0, 32				# Set character to space
	syscall						# Print the space
	addi	$a0, $t2, -1		# Decrement counter
	
	b	decLoop					# Restart loop

# End program
end:
