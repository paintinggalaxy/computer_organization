.data 
line: .space 800
visit: .space 32
path: .space 32
flag: .space 28
space: .asciiz" "
.text 

#input
# get the number of nodes and lines
 li $v0, 5
 syscall
 move $s0, $v0
 li $v0, 5
 syscall
 move $s1, $v0
 li $s5, 4
 la $s2, line
 la $s4, flag
 add $t6, $s4, 0
 mult $s1, $s5
 mflo $s3
 add $s3, $s3, $s2
# get lines ($t1 for loc of line $t0 for cycle)
 la $t1, line
 add $t2, $s1, $s1
forGetLines:
 li $v0, 5
 beq $t0, $t2, forGetLinesEnd
 syscall
 sw $v0, 0($t1)
 addi $t1, $t1, 4
 addi $t0, $t0, 1
 j forGetLines
forGetLinesEnd:
 li $t0, 0
 li $t1, 0
 

#output 
forOut:
 beq $t0, $t2, forOutEnd
 li $v0, 1
 lw $a0, line($t1)
 syscall
 li $v0, 4
 la $a0, space
 syscall
 addi $t1, $t1, 4
 addi $t0, $t0, 1
 j forOut
forOutEnd:
 li $v0, 1
 move $a0, $s0
 syscall
 li $v0, 4
 la $a0, space
 syscall
 li $v0, 1
 move $a0, $s1
 syscall
 
 li $t0, 0
 li $t1, 0
 
 li $v0, 10
 syscall
