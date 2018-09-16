.text 
li $v0, 5
syscall
move $s0, $v0

move $a0, $s0
jal func
move $a0, $v0
li $v0, 1
syscall
li $v0, 10
syscall

func:
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 move $t0, $a0
 beq $t0, 1, then
 addi $a0, $t0, -1
 sw $t0, 0($sp)
 addi $sp, $sp, -4
 jal func
 addi $sp, $sp, 4
 lw $t0, 0($sp)
 mult $v0, $t0
 mflo $v0
 j return1
 then:
 li $v0, 1
 j return1
 return1:
 addi $sp, $sp, 4
 lw $ra, 0($sp)
 jr $ra