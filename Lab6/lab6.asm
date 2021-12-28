.data
newline: .asciiz "\n"
line: .asciiz "------------------------------------------------------------------- \n"
message1: .asciiz "1.Determine the matrix size. \n"
message2: .asciiz "2.Allocate the array for the matrix. \n"
message3: .asciiz "3.Show matrix elements. \n"
message4: .asciiz "4.Row-major summmation. \n"
message5: .asciiz "5.Column-major summation. \n"
message6: .asciiz "6.Display element by specifying row and column number. \n"
message7: .asciiz "7.Exit program. \n"
message8: .asciiz "Enter the integer for the action you choose:"
message9: .asciiz "Integer for the action can only be between 1-7."
message10: .asciiz "Enter N for NxN matrix:"
message11: .asciiz "Array allocated and initialized succesfully.\n"
message12: .asciiz "Input i:"
message13: .asciiz "Input j:"
message14: .asciiz "Input the value:"
sum: .asciiz "Sum is = "
m1: .asciiz "("
m2: .asciiz ","
m3: .asciiz ") = "
m4: .asciiz "Value is stored in ("
m5: .asciiz ")"


.text
menu:
	li $v0, 4
	la $a0, line
	syscall
	li $v0, 4
	la $a0, message1
	syscall
	li $v0, 4
	la $a0, message2
	syscall
	li $v0, 4
	la $a0, message3
	syscall
	li $v0, 4
	la $a0, message4
	syscall
	li $v0, 4
   	la $a0, message5
   	syscall
   	li $v0, 4
   	la $a0, message6
   	syscall
   	li $v0, 4
   	la $a0, message7
   	syscall
   	
   	li $v0, 4
   	la $a0, message8
   	syscall
  	li $v0, 5
 	syscall
 	
 	move $t7, $v0

choice:
c1:  bne $t7, 1, c2
	li $v0, 4
	la $a0, message10
	syscall
	
	li $v0, 5
 	syscall
 	
 	move $s1, $v0 # store N in $s1
 	
 	
 	j menu
	

c2: bne $t7, 2, c3
	li $v0,9
	mul $a0, $s1, $s1
	sll $a0, $a0, 2
	syscall
	
	move $s0, $v0 #store adress of array in $s0
	
	addi $t0, $s1, 1 # size+1 for loop boundary
	li $t1, 1 #i
	li $t2, 1 #j
	li $t5, 1 #value stored
	
	
	for: beq  $t1, $t0, for2

		#calculation of displacement formula
		subi $t3, $t2, 1
		mul $t3, $t3, $s1
		sll $t3, $t3, 2
		subi $t4, $t1, 1
		sll $t4, $t4, 2
		add $t3, $t3, $t4 # $t3 is the displacement(j - 1) x N x 4 + (i - 1) x 4
		
		add $t4, $t3, $s0 # $t4 is the adress where the value will be stored
		sw $t5, 0($t4)
		
		addi $t1, $t1, 1
		addi $t5, $t5, 1
		
		j for
		
	for2: addi $t2, $t2, 1 
		beq $t2, $t0, forExit
		li $t1, 1
		j for
	forExit: 
		li $v0, 4
		la $a0, message11
		syscall
		j menu
	
	
	
	
	
	
	
	
	
	   	
   	
	

c3: bne $t7, 3, c4
	addi $t0, $s1, 1 # size+1 for loop boundary
	li $t1, 1 #i
	li $t2, 1 #j
	
	for3: beq  $t1, $t0, for4

		#calculation of displacement formula
		subi $t3, $t2, 1
		mul $t3, $t3, $s1
		sll $t3, $t3, 2
		subi $t4, $t1, 1
		sll $t4, $t4, 2
		add $t3, $t3, $t4 # $t3 is the displacement(j - 1) x N x 4 + (i - 1) x 4
		
		add $t4, $t3, $s0 # $t4 is the adress where the value will be stored
		lw $t5, 0($t4)
		
		li $v0, 4
		la $a0, m1
		syscall
	
		li $v0, 1
		move $a0, $t1
		syscall
	
		li $v0, 4
		la $a0, m2
		syscall
	
		li $v0, 1
		move $a0, $t2
		syscall
	
		li $v0, 4
		la $a0, m3
		syscall
	
		li $v0, 1
		move $a0, $t5
		syscall
	
		li $v0, 4
		la $a0, newline
		syscall
	
		
		
		addi $t1, $t1, 1
		
		j for3
		
	for4: addi $t2, $t2, 1 
		beq $t2, $t0, menu
		li $t1, 1
		j for3

	
	


c4: bne $t7, 4, c5
	addi $t0, $s1, 1 # size+1 for loop boundary
	li $t1, 1 #i
	li $t2, 1 #j	
	li $t6, 0 #column summation so far
	for5: beq  $t2, $t0, for6

		#calculation of displacement formula
		subi $t3, $t2, 1
		mul $t3, $t3, $s1
		sll $t3, $t3, 2
		subi $t4, $t1, 1
		sll $t4, $t4, 2
		add $t3, $t3, $t4 # $t3 is the displacement(j - 1) x N x 4 + (i - 1) x 4
		
		add $t4, $t3, $s0 # $t4 is the adress where the value will be taken from
		lw $t5, 0($t4)
		
		add $t6, $t5, $t6
		
		addi $t2, $t2, 1

		j for5
		
	for6: addi $t1, $t1, 1 
		beq $t1, $t0, forExit2
		li $t2, 1
		j for5
		
	forExit2:
		li $v0, 4
		la $a0, sum
		syscall
		
		li $v0, 1
		move $a0, $t6
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		j menu
			
c5: bne $t7, 5, c6
	addi $t0, $s1, 1 # size+1 for loop boundary
	li $t1, 1 #i
	li $t2, 1 #j	
	li $t6, 0 #column summation so far
	for7: beq  $t1, $t0, for8

		#calculation of displacement formula
		subi $t3, $t2, 1
		mul $t3, $t3, $s1
		sll $t3, $t3, 2
		subi $t4, $t1, 1
		sll $t4, $t4, 2
		add $t3, $t3, $t4 # $t3 is the displacement(j - 1) x N x 4 + (i - 1) x 4
		
		add $t4, $t3, $s0 # $t4 is the adress where the value will be taken from
		lw $t5, 0($t4)
		
		add $t6, $t5, $t6
		
		addi $t1, $t1, 1

		j for7
		
	for8: addi $t2, $t2, 1 
		beq $t2, $t0, forExit2
		li $t1, 1
		j for7

c6: bne $t7, 6, c7
	li $v0, 4
	la $a0, message12
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 4
	la $a0, message13
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	
	#calculation of displacement formula
	subi $t3, $t2, 1
	mul $t3, $t3, $s1
	sll $t3, $t3, 2
	subi $t4, $t1, 1
	sll $t4, $t4, 2
	add $t3, $t3, $t4 # $t3 is the displacement(j - 1) x N x 4 + (i - 1) x 4
		
	add $t4, $t3, $s0 # $t4 is the adress where the value will be taken from
	lw $t5, 0($t4)
	
	li $v0, 4
	la $a0, m1
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, m2
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, m3
	syscall
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	j menu
	
	
	
	
	
	
	
	
	
	
	
c7: bne $t7, 7, c8
	li $v0, 10
	syscall

	

c8: la $a0, message9
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	j choice



