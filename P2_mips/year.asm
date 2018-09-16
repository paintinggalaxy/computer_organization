.text
#input
li $v0, 5
syscall 
move $s0, $v0
li $s1, 100
li $s2, 4
li $s3, 400
#%100
div $s0, $s1
mfhi $t0
#%4
div $s0, $s2
mfhi $t1
#%400
div $s0, $s3
mfhi $t2
# if year%100==0 %4!=0
beqz $t0 if4
beqz $t1 yes
j no


if4:
beqz $t2, yes
j no

yes:
li $a0, 1
li $v0, 1
syscall
li $v0 ,10
syscall

no:
li $a0, 0
li $v0, 1
syscall
li $v0,10
syscall
 


 

