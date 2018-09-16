.data
nums:.space 128
.text
li $t4, 5
loop:
beq $t0, $t4, end
addiu $t0, $t0, 1
j loop
end:
 li $v0, 10
 blez $t6, loop

