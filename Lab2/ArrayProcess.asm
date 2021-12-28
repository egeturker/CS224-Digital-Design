.data
message1: .asciiz "Enter array size: "
message2: .asciiz "Input integer: "
messageMin: .asciiz "Minimum is: "
messageMax: .asciiz "Maximum is: "
messageSum: .asciiz "Sum is: "
message3: .asciiz "Array contents define a palindrome !"
message4: .asciiz "Array contents DO NOT define a palindrome !"
nextLine: .asciiz "\n"

.text
main:
   jal createArray
   
   move $a0, $v0 # pass array adress
   move $a1, $v1 # pass array size
   
   jal arrayOperations
   
   beq $v0, $zero, notPalindrome
   bne $v0, $zero, isPalindrome
   end:
   li	$v0, 10
   syscall
   
   
   
   
createArray:
   li $v0 4
   la $a0 message1
   syscall
   
   li $v0 5
   syscall
   move $s0 $v0 # number of elements
   
   sll $a0 $s0 2 # $a0 = $s0 * 4
   li $v0 9
   syscall
  
   move $s1 $v0 #address
   
   addi $sp, $sp, -8
   sw $s0, 4($sp)
   sw $s1, 0($sp)
   
   
  
   loop:
      beq $zero $s0 endLoop
   
      li $v0 4
      la $a0 message2
      syscall
   
      li $v0 5
      syscall
      sw $v0 0($s1)
   
      addi $s0 $s0 -1
      addi $s1 $s1 4
      j loop

      endLoop:
         lw $s1, 0($sp)
         lw $s0, 4($sp)
         addi $sp, $sp, 8
         move $v0, $s1 #return array beginning adress
         move $v1, $s0 #return array size
         jr $ra
 
arrayOperations:
   move $s0, $a0
   move $s1, $a1

   min:
      addi $sp, $sp, -8
      sw $s0, 4($sp)
      sw $s1, 0($sp)
   
      sll $s1,$s1,2 #$s1 = size*4
      add $s1,$s0,$s1
      lw $s2,0($s0) #$s2 = min
      minLoop:
         beq $s0, $s1, endMinLoop
   
         lw $s3,0($s0)
         addi $s0,$s0,4
         slt $s4,$s2,$s3 #is next value < min ?
         bne $s4,$zero,minLoop # if not, continue loop
         move $s2,$s3 #if yes set new min
         j minLoop #continue loop
   
      endMinLoop:
         li $v0,4
         la $a0,messageMin
         syscall
   
         li $v0,1
         move $a0, $s2
         syscall
   
         li $v0,4
         la $a0,nextLine
         syscall
   
         lw $s0, 4($sp)
         lw $s1, 0($sp)
         addi $sp, $sp, 8
   max:
      addi $sp, $sp, -8
      sw $s0, 4($sp)
      sw $s1, 0($sp)
   
      sll $s1,$s1,2 #$s1 = size*4
      add $s1,$s0,$s1
      lw $s2,0($s0) #$s2 = max
      maxLoop:
         beq $s0, $s1, endMaxLoop
   
         lw $s3,0($s0)
         addi $s0,$s0,4
         slt $s4,$s2,$s3 #is next value < min ?
         beq $s4,$zero,maxLoop # if yes, continue loop
         move $s2,$s3 #if not set new max
         j maxLoop #continue loop
   
      endMaxLoop:
         li $v0,4
         la $a0,messageMax
         syscall
   
         li $v0,1
         move $a0, $s2
         syscall
   
         li $v0,4
         la $a0,nextLine
         syscall
   
         lw $s0, 4($sp)
         lw $s1, 0($sp)
         addi $sp, $sp, 8
   
   sum:
      addi $sp, $sp, -8
      sw $s0, 4($sp)
      sw $s1, 0($sp)
   
      sll $s1,$s1,2 #$s1 = size*4
      add $s1,$s0,$s1
      add $s2,$zero,$zero #sum = 0
      sumLoop:
         beq $s0, $s1, endSumLoop
         lw $s3,0($s0)
         add $s2,$s2,$s3
         addi $s0,$s0,4
         j sumLoop
      
      endSumLoop:
         li $v0,4
         la $a0,messageSum
         syscall
   
         li $v0,1
         move $a0, $s2
         syscall
   
         li $v0,4
         la $a0,nextLine
         syscall
   
         lw $s0, 4($sp)
         lw $s1, 0($sp)
         addi $sp, $sp, 8

   palindrome:
      addi $sp, $sp, -8
      sw $s0, 4($sp)
      sw $s1, 0($sp)
      
      li $v0, 1 #starts as palindrome by default
      div $s2, $s1, 2 #size/2
      addi $s2, $s2,1 # +1 in case size/2 is even
      sll $s5, $s1, 2 #size*4
      add $s5, $s5, $s0 
      addi $s5, $s5, -4 # (size*4 + address) - 4 = address of last index 
      li $s3, 1 #counter = 1
      palindromeLoop:
         bge $s3, $s2, endPalindromeLoop
         lw $s4, 0($s0)
         lw $s6, 0($s5)
         beq $s4, $s6, continuePalindromeLoop
         li $v0, 0
         j endPalindromeLoop
         
      continuePalindromeLoop:
         add $s0,$s0,4
         add $s5,$s5, -4
         addi $s3, $s3, 1
         j palindromeLoop
      
      endPalindromeLoop:
         lw $s0, 4($sp)
         lw $s1, 0($sp)
         addi $sp, $sp, 8
         jr $ra

   notPalindrome:
   li $v0,4
   la $a0,message4
   syscall
   j end
   
   isPalindrome:
   li $v0,4
   la $a0,message3
   syscall
   j end
         
         
         
         

         
          
      
         
   
   
   
   
   
   
   
   
  
   
   
   
   

   
   
   
   
   
   
   
   
     
   


   
   