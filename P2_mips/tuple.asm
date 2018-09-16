.data 
array: .space 30000
space: .asciiz  " "
nextline: .asciiz "\n"
.text
#at most 10000 = 50*50*4*3
 la $s7, array
 move $s7, $t4
#get two paras about the mat
 li $v0, 5
 syscall
 move $s0, $v0
 li $v0, 5
 syscall
 move $s1, $v0
#initiallize

li $t0, 1
li $t1, 1
addi $s0, $s0, 1
addi $s1, $s1, 1
#get elem
for_elem_row:
 beq $t0, $s0, for_elem_row_end
 for_elem_col:
 beq $t1, $s1 for_elem_col_end
 li $v0, 5
 syscall
 beq $v0, $zero, botom
 sw $v0 0($t4)
 sw $t1 4($t4)
 sw $t0 8($t4)
 
 addi $t4, $t4, 12
 botom:
 addi $t1, $t1, 1
 j for_elem_col
for_elem_col_end:
 li $t1, 1
 addi $t0, $t0, 1
 j for_elem_row
for_elem_row_end:
 #output
 addi $t4, $t4, -4
for_output:
 slt $t2, $t4, $s7
 bne $t2, $zero, for_output_end
 lw $a0, 0($t4)
 li $v0, 1
 syscall
 addi $t4, $t4, -4
 la $a0, space
 li $v0, 4
 syscall
 lw $a0, 0($t4)
 li $v0, 1
 syscall
 addi $t4, $t4, -4
 la $a0, space
 li $v0, 4
 syscall
 lw $a0, 0($t4)
 li $v0, 1
 syscall
 addi $t4, $t4, -4
 la $a0, nextline
 li $v0, 4
 syscall
 j for_output
for_output_end:
 li $v0, 10
 syscall
 
 
