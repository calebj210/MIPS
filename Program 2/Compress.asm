##
#	Basic run length encoding algorithm for compressing strings
#
#	Author: Caleb Jacobs
#	User ID: cajacobs
#	Date Last Modified: 01/31/2021
##

# Initialization
.text
	li		$t0, 0					# Current input string index
	li		$t1, 0					# Current output string index / packed string length
	li		$t7, 255				# Max encoding length

# Begin a new letter count
startNewLetter:
	lb		$t2, str($t0)			# Load new letter from input string
	beqz	$t2, end				# End of string, terminate encoding
	li		$t3, 1					# Reinitialize letter count
	addi	$t0, $t0, 1				# Increment input index

# Count consecutive occerence of a letter
countLetter:
	lb		$t4, str($t0)			# Load next letter in string
	bne		$t2, $t4, encode 		# Encode if new letter is met
	addi	$t3, $t3, 1				# Increment letter count
	addi	$t0, $t0, 1				# Increment input index
	beq		$t3, $t7, encode		# Encode if max letter repetition is met
	b 		countLetter				

# Store letter-value pair
encode:
	sb		$t2, packed($t1)		# Store new letter in packed
	addi	$t1, $t1, 1				# Increment output string 
	sb		$t3, packed($t1)		# Store letter count in packed
	addi	$t1, $t1, 1				# Increment output string
	b		startNewLetter			# Begin counting a new letter

# End RLE and store length of packed string
end: 
	sw		$t1, packedLen			# Store packed length

##############################################################################
# DO NOT modify the following .text segment
# Your code should branch to this code once you have compressed str into
# packed and set the value of packedLen.
.text

finalOutput:
	li		$v0, 4					# Print out the input string str
	la		$a0, ORIG_TEXT
	syscall
	la		$a0, str
	syscall

	la		$a0, ORIG_LEN			# Print out the length of input string
	syscall

	li		$a0, 0					# Initialize index into str
finalLoop:							# Loop until null terminator to calculate length of str
	lbu		$t1, str($a0)			# Load character from str
	beqz	$t1, finalAfter			# Check for null terminator
	addi	$a0, $a0, 1				# Increment index
	b		finalLoop

finalAfter:
	li		$v0, 1					# Print the integer length
	syscall

	li		$v0, 4					# Print text representation of packed data
	la		$a0, PACKED_PAIRS
	syscall
	li		$t0, 0
	lw		$t1, packedLen


finalLoop2:							# Loop over all the pairs in the packed data
	beq		$t0, $t1, finalAfter2	# Stop when we reach end of packed
	lbu		$a0, packed($t0)		# Load a character from packed
	li		$v0, 11					# Print a character
	syscall
	addi	$t0, $t0, 1

	lbu		$a0, packed($t0)		# Print out the count for this character
	li		$v0, 1
	syscall

	li		$v0, 4					# Print a space
	la		$a0, SPACE
	syscall

	addi	$t0, $t0, 1
	b		finalLoop2

finalAfter2:
	li		$v0, 4					# Print out the length of the packed output
	la		$a0, PACKED_LEN
	syscall
	lw		$a0, packedLen
	li		$v0, 1
	syscall

	li		$v0, 10					# Terminate execution
	syscall

# DO NOT modify the following .data segment
# Your program should make use of the packed and packedLen labels to store the compressed data
.data
packedLen:		.word		0		# Length of packed data in bytes
packed:			.space		1024	# Enough memory for str to be of length 512 in the worst case

# Some string constants used by our code to print the final output
ORIG_TEXT:		.asciiz 	"Original text : "
ORIG_LEN:		.asciiz 	"\nOriginal len  : "
PACKED_PAIRS:	.asciiz 	"\nPacked pairs  : "
PACKED_LEN:		.asciiz 	"\nPacked len    : "
SPACE:			.asciiz 	" "

### START DATA ###
# This section will get replaced by the auto-grader.
# Do not place anything in this section required by your program.
# You can assume this section will always contain the label str.
# You can uncomment different lines to test your program.
# But you can (and should!) modify str to thoroughly test your program.
# We have provided 7 test strings with reference output on the assignment page.
.data
#str:	   		.asciiz		"AAAACCTGGGG"   									# test case 1
#str:	   		.asciiz		"AAABCDDDDDDEFGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG" 	# test case 2
#str:			.asciiz		"h" 												# test case 3
#str:			.asciiz		"ABCDEFGHIJKLMNOPQRSTUVWXYZ" 						# test case 4
#str:			.asciiz		"ABAABBAAACaA" 										# test case 5
str:			.asciiz		"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARGH!" # test case 6
#str:			.asciiz		"" 													# test case 7
### END DATA ###
