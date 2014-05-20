#Chad Duffey 
#Program to halve single precision floating point number till it cannot be distinguised from 1

	.data
const1:	.float 1.0
output:	.asciiz "\n\nOutput of division is:\t\t"
result:	.asciiz "\nAdding output to 1 gives:\t"
equal:	.asciiz "\nCant Distinguish Numbers Anymore"
	.text
	.globl main
	
main:
	l.s	$f18, const1
loop:
	#move the number to be divided to parameter register then jump
	mov.s	$f0, $f18	
	jal	f1
	
	#move return result to $f12
	mov.s	$f12, $f0
	mov.s	$f16, $f0 #(save value for next loop)
	
	#Start new line and print 'Output is: '
	li	$v0, 4
	la      $a0, output
        syscall
	
	#Print the value of $f12 
	li	$v0, 2
	syscall

	#add division result to 1 
	l.s	$f20, const1
	add.s	$f12, $f12, $f20
	
	#Start new line and print 'Adding output to 1 gives: '
	li	$v0, 4
	la      $a0, result
        syscall	
	
	#print the result of $f12 + 1
	li	$v0, 2
	syscall
	
	#test if $f12 equals 1 and set a flag
	c.eq.s 	$f12, $f20
	
	#move the stored result value back into $f18 for the loop
	mov.s 	$f18, $f16 
	
	#branch if the flag was set to equal on line 50
	bc1t same
	bc1f loop
	
same:
	#print out cant distinguish message
	li	$v0, 4
	la      $a0, equal
        syscall

	###################
	# end the program #
	###################
	li	$v0, 10
	syscall
	
##########################################
#FUNCTION TO DIVIDE BY 2 AND RETURN RESULT
##########################################

	.data
const2:	.float 2.0
	.text
	
f1:
	l.s	$f16, const2
	div.s	$f0, $f0, $f16
	jr	$ra
	

		
