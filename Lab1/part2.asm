.data
   message1: .asciiz "Enter a: "
   message2: .asciiz "Enter b: "
   message3: .asciiz "Enter c: "
   message4: .asciiz "Enter d: "
   result: .asciiz "a * (b - c) % d = "
   

   
.text
main:
   li $v0, 4 
   la $a0, message1
   syscall
   
   li $v0, 5
   syscall
   move $t0, $v0 
   
   li $v0, 4 
   la $a0, message2
   syscall
   
   li $v0, 5
   syscall
   move $t1, $v0
   
   li $v0, 4 
   la $a0, message3
   syscall
   
   li $v0, 5
   syscall
   move $t2, $v0
   
   li $v0, 4 
   la $a0, message4
   syscall
   
   li $v0, 5
   syscall
   move $t3, $v0
  
   move $a0, $t0
   move $a1, $t1
   move $a2, $t2
   move $a3, $t3
   
   jal calculate
   
   move $t1, $v0
   
   li $v0, 4 
   la $a0, result
   syscall
   
   li $v0, 1
   move $a0, $t1
   syscall
   
   li	$v0, 10
	syscall
   
   

calculate:
   sub $t0, $a1, $a2
   mult $t0, $a0
   mflo $t0
   div $t0, $a3
   mflo $t0
   move $v0, $t0
   jr $ra



   
