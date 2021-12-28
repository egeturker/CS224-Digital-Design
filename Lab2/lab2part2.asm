.data
message1: .asciiz "Enter the size of the array: "
space: .asciiz "   "
messageYes: .asciiz "Yes \n"
messageNo: .asciiz "No \n"

.text
main:
   jal initializeArray
   move $s0, $v0 #get array size
   move $s1, $v1 #get array adress
   move $a0, $s0 #pass array size into bubbleSort
   move $a1, $s1 #pass array adress into bubbleSort
   jal bubbleSort
   move $s0, $v0 #array size
   move $s1, $v1 #array adress
   move $a0, $s0 #pass array size into processArray
   move $a1, $s1 #pass array adress into processArray
   jal processArray
   li	$v0, 10
   syscall
   

   initializeArray:
      li $v0, 4
      la $a0, message1
      syscall
      
      li $v0, 5
      syscall
      move $s0, $v0 # number of elements
      
      sll $a0, $s0, 2 # $a0 = $s0 * 4
      li $v0, 9
      syscall
              
      move $s1, $v0 #address
      addi $sp, $sp, -8
      sw $s0, 4($sp)
      sw $s1, 0($sp)
      
      loop:
        beq $zero, $s0, endLoop
        li $a1, 100001
        li $v0, 42
        syscall
        sw $a0, 0($s1)
        addi $s0, $s0, -1
        addi $s1, $s1, 4
        j loop
        
        endLoop:
           lw $s1,0($sp)
           lw $s0,4($sp)
           addi $sp, $sp,8
           move $v0, $s0 #return size
           move $v1, $s1 #return array address
           jr $ra
            
   bubbleSort: 
      addi $sp, $sp, -8
      sw $s0, 4($sp)
      sw $s1, 0($sp)
      
      move $s0, $a0
      move $s1, $a1
      
      li $s2, 0        # Initialize beginning  
      start_loop_1:  
      beq $s2, $s0, end_loop_1  
      li $s3, 0        # Initialize beginning
      sub $s4, $s0, $s2  
      sub $s4, $s4, 1
      start_loop_2:  
      beq $s3, $s4, end_loop_2  
      
      sll $s5,$s3,2
      add $s5,$s5,$s1
      la $s6, 4($s5) 
      lw $a0, 0($s5)
      lw $a1, 0($s6)     
      bge $a0, $a1, swap
      continue:
      addi $s3, $s3, 1    # Increment counter  
      j start_loop_2  
      end_loop_2:    
      addi $s2, $s2, 1    # Increment counter  
      j start_loop_1  
      end_loop_1: 
      lw $s0, 4($sp)
      lw $s1, 0($sp)
      addi $sp, $sp, 8
      move $v0, $s0 #return size
      move $v1, $s1 #return array address
      
      jr $ra
   swap:
      sw $a0, 0($s6)
      sw $a1, 0($s5)
      j continue
   
   processArray:
      addi $sp, $sp, -8
      sw $s0, 4($sp)
      sw $s1, 0($sp)
      move $s0, $a0
      move $s1, $a1
      
      li $s2, 0
      arrayLoop:
      beq $s2, $s0, endArrayLoop
      
      li $v0, 1
      move $a0, $s2
      syscall
      li $v0, 4
      la $a0, space
      syscall

      sll $s3, $s2, 2
      add $s3, $s3, $s1 
      li $v0, 1
      lw $a0, 0($s3)
      syscall
      li $v0, 4
      la $a0, space
      syscall
    
      lw $a0, 0($s3)
      j sumDigits
      cont:
      move $a0, $v0
      li $v0, 1
      syscall
      li $v0, 4
      la $a0, space
      syscall
      
      lw $a0, 0($s3)
      j checkPrime
      cont2:      
      addi $s2,$s2,1
      
      j arrayLoop
      
   endArrayLoop:
      lw $s0, 4($sp)
      lw $s1, 0($sp)
      addi $sp, $sp, 8
      jr $ra
   
   sumDigits:
      li $s4, 10
      li $s5, 0
      calculate:
         div $a0,$s4
         mflo $a0
         mfhi $s6
         add $s5, $s5, $s6
         bne $a0, $zero,calculate
      endCalculate:
      move $v0, $s5
      j cont
    
    checkPrime:
       li $s4, 2
       primeLoop:
          div $a0, $s4
          mfhi $s5
          beq $s5, $zero, primeNo
          addi $s4, $s4, 1
          bge $s4, $a0, primeYes
          j primeLoop
          
    primeYes:
      li $v0, 4
      la $a0, messageYes
      syscall   
      j cont2
   primeNo:
      li $v0, 4
      la $a0, messageNo
      syscall       
      j cont2
   
       
    
      
      
      
      
      
      
      
      
      
      
   
      
      
          
      
         
      
      
   
   
       
   
      
      
      
      
      
      
      
    
    
   
