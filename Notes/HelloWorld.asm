		.text
		la		$a0, str1
		li		$v0, 4
		syscall
		
		.data
str1:	.ascii	"Hello "
str2:	.asciiz	"world!"