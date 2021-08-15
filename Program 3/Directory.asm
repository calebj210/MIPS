##
# Search and print employee records from a linked list based databank 
#
# By: Caleb Jacobs
# User ID: cajacobs
# Date Last Modified: 02/07/2021
# Course: CS1142 R01
##

# Main Program
.text
		la	$a0, prompt				# Get search string
		li	$v0, 4					# Prompt string printing
		syscall
		la	$a0, keyword			# Get key string
		syscall
		la	$a0, newline			# Get newline character
		syscall
		
		la	$t7, first				# Get first user entry
		
preCheckMatch:
		li		$t0, 0				# Key index
		addi 	$t1, $t7, 9			# Name index
checkMatch:
		lb		$t2, keyword($t0)	# Load key at index $t0
		beqz	$t2, printEntry		# Print current name if key is null/0
		blt		$t2, 97, contKey	# Check if current key is lowercase
		bgt		$t2, 122, contKey	
		addi	$t2, $t2, -32		# Convert key to uppercase
contKey:	
		lb		$t3, 0($t1)			# Load current letter
		beqz	$t3, next			# Move to next entry if name had no matches
		blt		$t3, 97, contLetter	# Check if current letter is lowercase
		bgt		$t3, 122, contLetter	
		addi	$t3, $t3, -32		# Convert letter to uppercase
contLetter:
		beq		$t2, $t3, contSearch# Check next key entry
		beqz	$t0, restartSearch	# Restart search at next text entry
		li		$t0, 0				# Set key index of first key
		b		checkMatch			# Compare first key value to text entry
contSearch:
		addi	$t0, $t0, 1			# Increment key index
restartSearch:
		addi	$t1, $t1, 1			# Increment text index
		b		checkMatch
		
printEntry:
		# Print name
		la	$a0, 9($t7)			# Get name
		syscall
		la	$a0, comma			# Print a comma
		syscall
		
		# Print user ID
		la	$a0, pound			# Prompt printing of the # symbol
		syscall
		li	$v0, 1				# Prompt integer printing
		lw	$a0, 4($t7)			# Get user id
		syscall
		li	$v0, 4				# Prompt string printing
		la	$a0, comma			# Prompt comma print
		syscall
		
		# Print age
		la	$a0, age			# Print "age "
		syscall
		li	$v0, 1				# Prompt integer printing
		lb	$a0, 8($t7)			# Get age
		syscall
		
		# Start a newline in the terminal
		li	$v0, 4				# Prompt string printing
		la	$a0, newline		# Get newline
		syscall
		
next:
		# Move to next entry in link list if it exists
		lw	$t6, 0($t7)			# Get address of next entry
		
		beq	$t6, -1, end		# End program if null entry is met
		lw	$t7, 0($t7)			# Move cursor($t7) to next entry
		b	preCheckMatch		# Jump back to pattern check routine
		
end:

# Terminal print helpers
.data
prompt:		.asciiz		"Searching for: "
newline:	.asciiz		"\n"
comma:		.asciiz		", "
pound:		.asciiz		"#"
age:		.asciiz		"age "





### START DATA ###
# You can (and should!) modify the linked list in order to test your program, but:
#  1) the keyword to search for should retain the label keyword
#  2) the first node should retain the label first
# You can (and should!) have a separate .data section containing other variables (e.g. string constants).
# NOTE: we will replace everything between the START DATA and END DATA tags during testing!
.data
keyword:    .asciiz     "Robert California a very long name does this thing match or not? I have a bad feeling that this name will not be match. But, I guess we will find out won't we, we will just need to wait an see. I'm going to keep going though, this is just so dang long"                   	# String to search for, NOTE: this may be empty (matches everyone)
node2:      .word       node6                   # Next pointer
            .word       20030422                # Employee ID
            .byte       27                      # Age
            .asciiz     "Jim D. Halpert"        # Name, NOTE: you can assume this will NOT be empty
first:      .word       node5
            .word       20030435
            .byte       26
            .asciiz     "Pam M. Beesly"
node3:      .word       node4
            .word       20010984
            .byte       41
            .asciiz     "Michael G. Scott"
            .space		200
node4:      .word       node8
            .word       20030580
            .byte       31
            .asciiz     "Dwight K. Schrute III"
node5:      .word       node2
            .word       20010321
            .byte       24
            .asciiz     "Ryan B. Howard"
node6:      .word       node3
            .word       20051229
            .byte       32
            .asciiz     "esteban paul"
node7:      .word       -1
            .word       20084724
            .byte       45
            .asciiz     "Robert California a very long name does this thing match or not? I have a bad feeling that this name will not be match. But, I guess we will find out won't we, we will just need to wait an see. I'm going to keep going though, this is just so dang long"
node8:		.word		node7
			.word       200
            .byte       15
            .asciiz     "A"
### END DATA ###
