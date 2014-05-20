## Chad Duffey 

	.data
	
	prompt1:	.asciiz "\nEnter your string: "
	prompt2:	.asciiz "\nEnter comparison string: "
	result1:	.asciiz "\nThe strings do not match\n"
	result2:	.asciiz "\nThe strings match\n"
	string1: 	.space 80
	string2: 	.space 80
	
	.text
	.globl main

main:
	
	##1
	li $v0,4			#Load syscode 4 to print string
	la $a0,prompt1			#put the address of prompt1 in $a0 for syscall to use
	syscall				#Display output - prompt1 "Enter your string"
	li $v0,8			#load syscode 8 to take input from user
	la $a0,string1			#put the address of string1 in $a0 for syscall to use - 80 char space
	addi $a1,$zero,80		#add 80 to our argument register		
	syscall   			#take input for string1

	##2
	li $v0,4			#load register with syscode 4 to print a string		
	la $a0,prompt2			#put the address of prompt2 in $a0 for syscall to use			
	syscall				#prompt user "Enter comparison string"
	li $v0,8			#load syscode 8 to take input with syscall
	la $a0,string2			#give the address of string 2 which has 80 bytes
	addi $a1,$zero,80		#add 80 to the argument register	
	syscall   			#take input for comparison string
 
	## Compare Strings
	la $a0,string1  		#Load address of string1 to argument register
	la $a1,string2  		#Load address of string2 to argument register
	jal strpfx  			#jump to strpfx procedure

	beq $v0,$zero,ok 		#if $v0 is zero, we have match jump to ok
	li $v0,4			#otherise prepare syscall for output
	la $a0,result1			#point to result 2 string
	syscall				#display "Strings dont match"
	j loopagain				#go to the exit code

	ok:
	li $v0,4			#load syscall 4 to print to screen
	la $a0,result2			#Load address of result2 
	syscall				#Display result2 - "The Strings Match"
	
	loopagain:
	beqz $a0, exit			#jump to exit if nothing entered for string
			
	j main				#exit from main loop when blank is entered by user

exit:
	li $v0,10			#load syscall 10 - which is exit
	syscall				## EXIT

strpfx:
	add $t0,$zero,$zero		#load temporary register with zero
	add $t1,$zero,$a0		#load temporary register with string1
	add $t2,$zero,$a1		#load temporary register with string2
	loop:
		lb $t3($t1)  		#load byte from string 1
		lb $t4($t2)		#load byte from string 2
		beqz $t3,comparet2 	#go to comparet2 if $t3 is zero
		beqz $t4,nomatch	#go to nomatch if $t4 is zero
		slt $t5,$t3,$t4  	#if t3 is less than t4 set t5 to one, otherwise zero
		bnez $t5,nomatch	#if t5 is now zero jump no nomatch
		addi $t1,$t1,1  	#add 1 to t1 to get to next byte in string
		addi $t2,$t2,1		#add 1 to t2 to get to next byte in string
	j loop

nomatch: 
	addi $v0,$zero,1
	j endproc

comparet2:
	bnez $t4,nomatch		#if t4 isnt zero go to nomatch
	add $v0,$zero,$zero		

endproc:
	jr $ra				#go back to the return address