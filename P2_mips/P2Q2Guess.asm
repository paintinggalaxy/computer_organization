.data
chars: .space 20
.text
li $s1, 2
li $v0, 5
syscall
move $s0, $v0
# $s0, number of chars

forGetChars:
beq $t0, $s0, forGetCharsEnd
li $v0, 12
syscall
sb $v0, chars($t0)
addi $t0, $t0, 1
j forGetChars
forGetCharsEnd:
 li $t0, 0
 
forJudge1:
 beq $t0, $s0, forJudge1End
 addi $t1, $t0, 1
 forJudge2:
 beq $t1, $s0, forJudge2End
 sub $t2, $t1, $t0
 addi $t2, $t2, 1
 div $t2, $s2
 mfhi $t3
 srl $t2, $t2, 1
 beq $t3,0, ou
 addi $t3, $t2, -1
 addi $t2, $t2, 1
 j next
 ou:
 addi $t3, $t2, -1
next:
 add $t6, $t0, $t3
 add $t7, $t1, $t2
 forJudge3:
 
 blt $t6, $0, forJudge3End
 bgt $t7, $s0, forJudge3End
  
 lb $t4, chars($t6)
 lb $t5, chars($t7)
 bne $t4, $t5, forJudge3End
 addi $t7, $t7, 1
 addi $t6, $t6, -1
 
 j forJudge3
 forJudge3End:
 sub $s4, $t7, $t6
 addi $s4, $s4, -1
 bgt $s5, $s4, then2
 move $s5, $s4
then2:
 addi $t1, $t1, 1
 j forJudge2
 forJudge2End:
 addi $t0, $t0, 1
 j forJudge1
forJudge1End:
 li $v0,1
 move $a0, $s5
 syscall