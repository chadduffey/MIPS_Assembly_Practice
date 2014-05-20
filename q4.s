# UNTITLED PROGRAM

	.data	# Data declaration section
part1:	.float 555.5
part2:	.float 3.4375
part3:	.float 0.4
part4:	.float 111.1
	.text

main:		# Start of code section
	l.s	$f12, part1
	l.s	$f14, part2
	l.s	$f16, part3
	l.s	$f18, part4
	
	#end program
	li	$v0, 10
	syscall

# END OF PROGRAM