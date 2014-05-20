		.data
msg1:		.asciiz "The square root of "
msg2:		.asciiz " is "
val:		.float 16.0
		.text
		.globl main
main:
	l.s $f0, val			# load the value into float register
	li.s $f20, 2.0       		# $f20 storing 2 for division
	li.s $f21, 0.0001    		# storing the allowed variance of 0.0001
	li.s $f4, 1.0			# initial value of 1
	
loop:	
	div.s $f5, $f0, $f4  		# n/x
	add.s $f5, $f5, $f4  		# n/x + x
	div.s $f5, $f5, $f20 		# x'=(n/x + x)/2
	sub.s $f6, $f5, $f4  		# x'-x
	abs.s $f6, $f6       		# x'-x
	c.lt.s $f6, $f21     		# set flag if (x'-x) < 0.0001
	bc1t done			# branch to done if flag is set  
	mov.s $f4, $f5			# otherwise copy $f5 to $f4 for next try
	j loop				# loop 

done:	
	li $v0,4			# load register with syscode 4 to print a string		
	la $a0,msg1			# put the address of msg1 in $a0 for syscall to use			
	syscall				# prompt 

	l.s 	$f12, val		# put square root into $f12 for printing
	li	$v0, 2			# load syscall with output float
	syscall				# output float value (square root)
	
	li $v0,4			# load register with syscode 4 to print a string		
	la $a0,msg2			# put the address of msg2 in $a0 for syscall to use			
	syscall				# prompt 

	mfc1 $a0, $f5			
	mtc1 $a0, $f12			#move to cpu from float
	
	li $v0,2			# syscall code for print float
	syscall				# print result

	li $v0,10			# load syscall code for quit
	syscall				# QUIT

	
