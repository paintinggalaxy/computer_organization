.data
nums: .space 400
space:.asciiz" "
.text
#get the number of nums
# $s0 holds the num
li $v0, 5
syscall
move $s0, $v0

# get the nums
 li $t0, 0
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

#select sort
# $t0, $t1 for cycle
# t2, for rec
# $t3, $t6 for loc 
# $t4 $t5 for value
addi $s1, $s0, -1
for1:
 # judge
 beq $t0, $s1, for1End
 # max = k
 move $t2, $t0
 sll $t3, $t0, 2
 lw $t4, nums($t3)
 addi $t1, $t0, 1
for2:
 beq $t1, $s0, for2End
 sll $t6, $t1, 2
 lw $t5, nums($t6)
 # if a[i]>a[j]
 bge $t5, $t4, then
 move $t2, $t1
 sw $t4, nums($t6)
 sw $t5, nums($t3)
 then:
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
#output
forOut:
 beq $t0, $s0, end
 li $v0, 1
 sll $t2, $t0, 2
 lw $a0, nums($t2)
 syscall
 li $v0, 4
 la $a0, space
 syscall
 addi $t0, $t0, 1
 j forOut
end:
 li $v0, 10
 syscall
