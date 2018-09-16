.data
chars: .space 40
.text
# $s0 total 
# s1 half
# s2 half + 1
# s3 half - 1
# s4 end
li $s5, 2
li $v0, 5
syscall
move $s0, $v0
# get the half
srl $s1, $s0, 1
#jishu or oushu
div $s0, $s5
mfhi $s5
beq $s5, 0, ou
addi $s2, $s1, 1
addi $s3, $s1, -1
j forGetChars
ou:
addi $s2, $s1, 0
addi $s3, $s1, -1

#getchars
forGetChars:
 beq $t0, $s0, forGetCharsEnd
 li $v0, 12
 syscall
 sb $v0, chars($t0)
 addi $t0, $t0, 1
 j forGetChars
forGetCharsEnd:
 li $t0, 0
#judge
# $t0, loop later
# $t1, loop former
# $t2, loc
# $t3, value
# $t4, value
move $t0, $s2
move $t1, $s3

forJudge:
 beq $t0, $s0, yes
 lb $t2, chars($t0)
 lb $t3, chars($t1)
 bne $t2, $t3, no
 addi $t0, $t0, 1
 addi $t1, $t1, -1
 j forJudge

yes:
 li $v0, 1
 li $a0, 1
 syscall
 j end

no:
 li $v0, 1
 li $a0, 0
 syscall
 j end

end:
 li $v0, 10
 syscall
 
