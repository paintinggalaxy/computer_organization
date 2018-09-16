.data
symbol: .space 28
arry: .space 28
space: .asciiz" "
line: .asciiz "\n"
.text 
li $v0, 5
syscall
move $s0, $v0
li $a0, 0
jal FullArray
li $v0, 10
syscall

FullArray:
 sw $ra, 0($gp)
 addi $gp, $gp, -4
 li $t1, 0
 move $t7, $a0
 bge $t7, $s0, forOut
forCal:
 beq $t1, $s0, return
 sll $t2, $t1, 2
 lw $t3, symbol($t2)
 bne $t3 , $0, then
 #if (symbol[i]==0)
 sll $t2, $t7, 2
 addi $t3, $t1, 1
 sw $t3, arry($t2)
 sll $t2, $t1, 2
 li $t3, 1
 sw $t3, symbol($t2)
 sw $t7, 0($gp)
 addi $gp, $gp, -4
 sw $t1, 0($gp)
 addi $gp, $gp, -4
 addi $t7, $t7, 1
 move $a0, $t7
 jal FullArray
 addi $gp, $gp, 4
 lw $t1, 0($gp)
 addi $gp, $gp, 4
 lw $t7, 0($gp)
 sll $t2, $t1, 2
 sw $0, symbol($t2)
then:
 addi $t1, $t1, 1
 j forCal
forOut:
 beq $t1, $s0, forOutEnd
 sll $t2, $t1, 2
 lw $a0, arry($t2)
 li $v0, 1
 syscall
 li $v0, 4
 la $a0, space
 syscall
 addi $t1, $t1, 1  
 j forOut
forOutEnd:
 li $v0, 4
 la $a0, line
 syscall
return:
 addi $gp, $gp, 4
 lw $ra, 0($gp)
 jr $ra
