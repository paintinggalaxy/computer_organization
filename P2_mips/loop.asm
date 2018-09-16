loop:
beq $t1, 5, end
addi $t1, $t1, 1
j loop
end:
li $v0, 10
syscall