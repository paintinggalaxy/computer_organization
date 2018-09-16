#mat mult with different col and row
.data
matA: .space 100
matB: .space 100
matC: .space 100
space: .asciiz" "
line: .asciiz "\n"

.text
# s0 Arow
# s1 Acol Brow
# s2 Bcol
li $v0, 5
syscall
move $s0, $v0
li $v0, 5
syscall
move $s1, $v0
li $v0, 5
syscall
move $s2, $v0

mult $s0, $s1
mflo $s3
mult $s1, $s2
mflo $s4
# s3 s4 hold the num of the elem

# inputA
 li $t0, 0
forGetA:
 beq $t0, $s3, forGetAEnd
 li $v0, 5
 syscall
 sll $t1, $t0, 2
 sw $v0, matA($t1)
 addi $t0, $t0, 1
 j forGetA
forGetAEnd:
 li $t0, 0
 li $t1, 0 

#input B
 li $t0, 0
forGetB:
 beq $t0, $s4, forGetBEnd
 li $v0, 5
 syscall
 sll $t1, $t0, 2
 sw $v0, matB($t1)
 addi $t0, $t0, 1
 j forGetB
forGetBEnd:
 li $t0, 0
 li $t1, 0 
#caluculate
#$t0, $t1, $t2 for cycle
# $t3 temp sum
# $t4 for loc
# $t5, trans value

 
for1:
 beq $t0, $s0, for1End
 
 li $t1, 0
for2:
 beq $t1, $s2, for2End
 li $t2, 0
 li $t3, 0
for3:
 beq $t2, $s1, for3End
 mult $t0, $s1
 mflo $t4
 add $t4, $t4, $t2
 sll $t4, $t4, 2
 lw $t6, matA($t4)  # $t6 == matA[i][k]
 mult $t2, $s2
 mflo $t4
 add $t4, $t4, $t1
 sll $t4, $t4, 2
 lw $t7, matB($t4) # $t7 == matB[k][j]
 mult $t6, $t7
 mflo $t5
 add $t3, $t3, $t5
 addi $t2, $t2, 1
 j for3
for3End:
 mult $t0, $s2
 mflo $t4
 add $t4, $t4, $t1
 sll $t4, $t4, 2
 sw $t3, matC($t4)
 addi $t1, $t1, 1
 j for2
for2End:
 addi $t0, $t0, 1
 j for1
for1End:
 li $t0, 0
 li $t1, 0
 li $t2, 0
 li $t3, 0
 li $t4, 0
 li $t5, 0
 li $t6, 0
 li $t7, 0
 
forOut1:
 beq $t0, $s0, forOut1End
 li $t1, 0
 forOut2:
 beq $t1, $s2, forOut2End
 mult $t0, $s2
 mflo $t4
 add $t4, $t4, $t1
 sll $t4, $t4, 2
 lw $a0 matC($t4)
 li $v0, 1
 syscall
 la $a0, space
 li $v0, 4
 syscall
 addi $t1, $t1, 1
 j forOut2
 forOut2End: 
 la $a0, line
 li $v0, 4
 syscall
 addi $t0, $t0, 1
 j forOut1
 forOut1End: 
 li $v0, 10
 syscall
