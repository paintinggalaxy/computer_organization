.data 
mat1:.space 256
mat2:.space 256
resu:.space 256
space:.asciiz " "
line: .asciiz "\n"
.text
li $v0, 5
syscall
move $s0, $v0  #$s0 holds the number of colums and rows
forGetMat1:
# $t0 row counter
# $t1 colum counter
# $t2 total num
 mult $t0, $s0
 mflo $t2
 add $t2, $t2, $t1
 sll $t2, $t2, 2  #*4 for loc
 li $v0, 5
 syscall
 sw $v0, mat1($t2)
 addi $t1, $t1, 1
 bne $t1, $s0, forGetMat1
 move $t1, $zero
 addi $t0, $t0, 1
 bne $t0, $s0, forGetMat1
 move $t0, $zero


 forGetMat2:
# $t0 row counter
# $t1 colum counter
# $t2 total num
 mult $t0, $s0
 mflo $t2
 add $t2, $t2, $t1
 sll $t2, $t2, 2  #*4 for loc
 li $v0, 5
 syscall
 sw $v0, mat2($t2)
 addi $t1, $t1, 1
 bne $t1, $s0, forGetMat2
 move $t1, $zero
 addi $t0, $t0, 1
 bne $t0, $s0, forGetMat2
 li $t0, 0

#calculation
 # $s1 holds the sum
 # $t0 holds the temp mult
 # $t1 for loc
 # $t2 $t3 $t4 loop variable row col sum
 # $t5 mat1 elem
 # $t6 mat2 elem
 # $t7 resu loc
 li $t1, 0
 li $t2, 0
 li $t3, 0
 li $t4, 0
forRow:
 beq $t2, $s0, forRowEnd
forCol:
 beq $t3, $s0, forColEnd
forSum:
 beq $t4, $s0, forSumEnd
 # get mat1 elem
 mult $t2, $s0
 mflo $t1
 add $t1, $t1, $t4
 sll $t1, $t1, 2
 lw $t5, mat1($t1)
 # get mat2 elem
 mult $t4, $s0
 mflo $t1
 add $t1, $t1, $t3
 sll $t1, $t1, 2
 lw $t6, mat2($t1)
 #mult
 mult $t5, $t6
 mflo $t0
 add $s1, $s1, $t0
 addi $t4, $t4, 1
 j forSum
forSumEnd:
 move $t4, $0
 #write in resu
 mult $t2, $s0
 mflo $t7
 add $t7, $t7, $t3
 sll $t7, $t7, 2
 sw $s1, resu($t7)
 move $s1, $0
 addi $t3, $t3, 1
 j forCol
forColEnd:
 move $t3, $0
 addi $t2, $t2, 1
 j forRow
forRowEnd:
 move $t2, $0
 move $t7, $0
 move $t1, $0
 move $t5, $0
 move $t6, $0
 
 #output
forOutRow:
 beq $t2, $s0, forOutRowEnd
forOutCol:
 beq $t3, $s0, forOutColEnd
 mult $t2, $s0
 mflo $t1
 add $t1, $t1, $t3
 sll $t1, $t1, 2
 lw $a0, resu($t1)
 li $v0,1
 syscall 
 la $a0, space
 li $v0, 4
 syscall
 addi $t3, $t3, 1
 j forOutCol
forOutColEnd:
 move $t3, $0
 addi $t2, $t2, 1
 la $a0, line
 li $v0, 4
 syscall
 j forOutRow
forOutRowEnd:
 li $v0, 10
 syscall
 

