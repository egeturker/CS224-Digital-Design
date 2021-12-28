.data
   message1: .asciiz "Enter the integer to be shifted: "
   message2: .asciiz "(For right shift, input 1. For left shift input 2.) \nEnter shift direction: "
   message3: .asciiz "Enter the shift amount: "
   message4: .asciiz "The result is: "
   message5: .asciiz "Number to be shifted is: "
   message6: .asciiz "Shift amount is: "
   message7: .asciiz "Shift direction is: "
   nextLine: .asciiz "\n"
   

.text
   main:
   li $v0, 4
   la $a0, message1
   syscall
   
   li $v0, 5
   syscall
   move $s0, $v0
   
   li $v0, 4
   la $a0, message2
   syscall
   
   li $v0, 5
   syscall
   move $s1, $v0 
   
   li $v0, 4
   la $a0, message3
   syscall
   
   li, $v0, 5
   syscall
   move $s2, $v0
   
   move $a0, $s0 #integer to be shifted
   move $a1, $s2 #shift amount
   
   beq $s1,1, shiftRightCircular
   beq $s1,2, shiftLeftCircular
   
   output:
   
   move $s3, $v0
   
   li $v0, 4 
   la $a0, message5
   syscall
   li $v0, 34
   move $a0, $s0
   syscall
   li $v0, 4 
   la $a0, nextLine
   syscall
   
   li $v0, 4 
   la $a0, message6
   syscall
   li $v0, 1 
   move $a0, $s2
   syscall
   li $v0, 4 
   la $a0, nextLine
   syscall
   
   li $v0, 4 
   la $a0, message7
   syscall
   li $v0, 1
   move $a0, $s1
   syscall
   li $v0, 4 
   la $a0, nextLine
   syscall
   
   li $v0, 4 
   la $a0, message4
   syscall
   li $v0, 34
   move $a0, $s3
   syscall
   
   
   
   li	$v0, 10
   syscall
   
   shiftRightCircular:
   addi $sp, $sp, -12
   sw $s0, 8($sp)
   sw $s1, 4($sp)
   sw $s2, 0($sp)

   move $s0, $a0   
   move $s1, $a1
   subiu $s2, $s1, 32
   abs $s2, $s2

   srlv $s3, $s0, $s1
   sllv $s0, $s0, $s2
   or $s0, $s0, $s3
   move $v0, $s0
   
   lw $s2, 0($sp)
   lw $s1, 4($sp)
   lw $s0, 8($sp)
   addi $sp, $sp, 12
   j output
   
   shiftLeftCircular:
   addi $sp, $sp, -12
   sw $s0, 8($sp)
   sw $s1, 4($sp)
   sw $s2, 0($sp)

   move $s0, $a0   
   move $s1, $a1
   subiu $s2, $s1, 32
   abs $s2, $s2

   sllv $s3, $s0, $s1
   srlv $s0, $s0, $s2
   or $s0, $s3, $s0
   move $v0, $s0
   
   lw $s2, 0($sp)
   lw $s1, 4($sp)
   lw $s0, 8($sp)
   addi $sp, $sp, 12
   
   j output
   
   
   
   
   
   
   
   
   
   
   