.data
array: .space 40
.text
main:
 li $s4, 4 #set a 4 easy to get the location
 li $v0, 5  #get the num
 syscall  #$s1 permenantly hold the value of num
 move $s1, $v0
 move $a0, $s1
 jal setArray
 li $v0, 10
 syscall
 
setArray:
 # save the variables
 sw $ra, 0($sp)
 addi $sp, $sp, -4
forSetArray:
 beq $s0, 10, forSetArrayEnd
 move $a1, $s0
 jal compare
 move $t0, $v0
 addi $t1, $s0, 0
 mult $t1, $s4
 mflo $t1
 sw $t0, array($t1)
 addi $s0, $s0, 1 
 j forSetArray
forSetArrayEnd:
 # reset the variables
 addi $sp, $sp, 4
 lw $ra, 0($sp)
 jr $ra


compare:
 #save the varibles
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 jal subfunc
 move $t0, $v0
 bgez $t0, re1
 li $v0, 0
 j then
re1:
 li $v0, 1
then: 
 addi $sp, $sp, 4
 lw $ra 0($sp)
 jr $ra

subfunc:
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 sub $t0, $a0, $a1
 move $v0, $t0
 addi $sp, $sp, 4
 lw $ra, 0($sp)
 jr $ra
