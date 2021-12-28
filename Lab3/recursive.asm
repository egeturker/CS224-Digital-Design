.data
	prompt1: .asciiz "Choose operation: \n1.Multiplication\n2.Addition(1 to N)\n"
	prompt2: .asciiz "Enter N: "
	prompt3: .asciiz "Enter two positive integers: \n"
	result: .asciiz "Result: "
.text
	main:
	la $a0, prompt1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	bne $t0, 2, multiplication
	la $a0, prompt2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0

	jal recursiveSummation	
	
	move $t0, $v0
	
	la $a0, result
	li $v0,4
	syscall
	
	move $a0, $t0
	li $v0,1
	syscall
	
	li $v0, 10
	syscall
			
	recursiveMultiplication:
		#Base 
		bne $a1, 1, else
		move $v0, $a0
		jr $ra						
		else:
			addi $sp, $sp, -4
			sw $ra, 0($sp)
			
			addi $a1, $a1, -1
			jal recursiveMultiplication
			add $v0, $v0, $a0
			
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			jr $ra
	recursiveSummation:	
		#Base 
		bne $a0, 1, else2
		li $v0, 1
		jr $ra						
		else2:
			addi $sp, $sp, -8
			sw $a0, 4($sp)
			sw $ra, 0($sp)
			
			addi $a0, $a0, -1
			jal recursiveSummation
			lw $t0, 4($sp)
			add $v0, $v0, $t0
			
			lw $ra, 0($sp)
			addi $sp, $sp, 8
			jr $ra

	multiplication:
	
	la $a0, prompt3
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	move $a0, $s0
	move $a1, $s1
	jal recursiveMultiplication
	
	move $t0, $v0
	
	la $a0, result
	li $v0,4
	syscall
	
	move $a0, $t0
	li $v0,1
	syscall
	
	li $v0, 10
	syscall
	
