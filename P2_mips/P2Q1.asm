.data 
nums: .space 400
space: .asciiz" "

.text
li $v0, 5
syscall
move $s0, $v0

forGetNums:
 beq $t0, $s0, forGetNumsEnd
 li $v0, 5
 syscall
 sll $t1, $t0, 2
 sw $v0, nums($t1)
 addi $t0, $t0, 1
 j forGetNums
forGetNumsEnd:
 li $t0, 0
 li $t1, 0

# $t0, $t1,loop
# $t2, $t3 loc
# $t4, $t5 value
# $t6, exchange
forSort1:
 beq $t0, $s0, forSort1End
 addi $t1, $t0, 1
 sll $t2, $t0, 2
 lw $t4, nums($t2)
forSort2:
 beq $t1, $s0, forSort2End
 sll $t3, $t1, 2
 lw $t5, nums($t3)
 bge $t5, $t4, then
 sw $t5, nums($t2)
 sw $t4, nums($t3)
 lw $t4, nums($t2)
 lw $t5, nums($t3)
then:
 addi $t1, $t1, 1
 j forSort2
forSort2End:
 addi $t0, $t0, 1
 j forSort1
forSort1End:
 li $t0, 0
 li $t1, 0
 li $t2, 0
#output
forOut:
 beq $t0, $s0, forOutEnd
 sll $t1 $t0, 2
 lw $t2, nums($t1)
 li $v0, 1
 move $a0, $t2
 syscall
 la $a0, space
 li $v0, 4
 syscall
 addi $t0, $t0, 1
 j forOut
forOutEnd:
 li $v0, 10
 syscall
