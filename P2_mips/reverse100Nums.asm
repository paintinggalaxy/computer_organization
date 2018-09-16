.data
nums: .space 400
.text

 li $t1, 0
 li $t0, 1
forGetNums:
 beq $t0, 101, forGetNumsEnd
 sw $t0, nums($t1)
 addi $t0, $t0, 1
 addi $t1, $t1, 4
 j forGetNums
forGetNumsEnd:
 li $t0, 0
 li $t1, 396
forReverse:
 beq $t0, 200, End
 lw $t2, nums($t0)
 lw $t3, nums($t1)
 sw $t2, nums($t1)
 sw $t3, nums($t0)
 addi $t0, $t0, 4
 addi $t1, $t1, -4
 j forReverse
End:
 li $v0, 10
 syscall
 
