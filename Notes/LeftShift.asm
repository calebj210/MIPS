# Example that shifts a single 1 bit through a 32-bit word
		.text
		li		$t0, 1		# start with $t0 = 0...01
loop:
		beqz	$t0, done	# exit once word filled with 0's
		
		sll		$t0, $t0, 1	# shift left by one bit
		
		li		$v0, 1		# print integer currently in $t0
		move	$a0, $t0	
		syscall
		
		li		$v0, 4		# print a line return
		la		$a0, lf
		syscall
		
		b		loop
done:
		.data
lf:		.asciiz "\n"