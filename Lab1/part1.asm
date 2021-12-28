.data
      array: .space 80
      message1: .asciiz "Enter the size of array: "
      message2: .asciiz "Enter the number: "
      message3: .asciiz "The sum is: "
      comma: .asciiz ", "
      

.text
      #$t2 = array index
      addi $t2, $zero, 0   

      # Prompt user to declare size of array
      li $v0, 4
      la $a0, message1
      syscall
      
      # Take the size of array
      li $v0, 5
      syscall
      
      # Store the size of array in $t1
      move $t1, $v0
      
      # Loop for getting array inputs
      # $t0 = i, $t1 = n
      main:  add $t0, $zero, $zero # i = 0
      start: beq $t0, $t1, exit    # if i == n, exit
            
      li $v0, 4
      la $a0, message2 #display message
      syscall  
      li $v0, 5 #take user input
      syscall
      move $t3, $v0
      sw $t3, array ( $t2) #store user input in array
      addi $t2, $t2, 4 #increment array index     
      addi $t0, $t0, 1      # i++
      j start

     exit:   
     display:
     # Clear $t2 to 0
     addi $t2, $zero, 0
     # $t5 is sum
     addi $t5, $zero, 0
     
     main2: add $t0, $zero, $zero # i = 0
     start2: beq $t0, $t1, exit2  # if i == n, exit
     
     lw $t4, array($t2)
     addi $t2, $t2, 4 #increment array index  
     addi $t0, $t0, 1 # i++
     add $t5, $t5, $t4
     
     #Prints current number 
     li $v0, 1
     move $a0, $t4
     syscall
     
     #Prints a new line
     li $v0, 4
     la $a0, comma
     syscall
     
     j start2
     
     exit2:
     #Displays the sum of elements in array
     li $v0, 4
     la $a0, message3
     syscall
     li $v0, 1
     move $a0, $t5
     syscall
     

        


