.data
end: .space 800
last: .space 32 
next: .space 800
flag: .space 32
.text
#input
# get the number of nodes and lines
 li $v0, 5
 syscall
 move $s0, $v0  #$s0 number of points****
 li $v0, 5  
 syscall
 move $s1, $v0   # $s1 number of lines***
 
#********set the first point
 li $s6, 5
 div $s0, $s6
 mfhi $s7
#*************************
 li $s4, 4  # $s4 used for loc***
 add $s2, $s1, $s1  #total line number
#create three array during the input
 li $t8, 1   # $s3 used for double
forArry:
 beq $t9, $s1, forArryEnd
 #get the begin and put into the last and put the former last into next
 #$t1, $t2 is the two point 
 # $t3 is the media for swap $t4 is used for loc
 li $v0,5
 syscall
 move $t1, $v0
 li $v0,5
 syscall
 move $t2, $v0
 #now $t1, $t2 holds the line's two points
 move $t0, $t1
 mult $t0, $s4
 mflo $t0
 lw $t3, last($t0)
 addi $t0, $t8, 0
 mult $t0, $s4
 mflo $t0
 sw $t3, next($t0)
 addi $t0, $t1, 0
 mult $t0, $s4
 mflo $t0
 sw $t8, last($t0)
 # put the end point into the end
 addi $t0, $t8, 0
 mult $t0, $s4
 mflo $t0
 sw $t2, end($t0)
 addi $t8, $t8, 1
 #reverse and save again
 move $t3, $t1
 move $t1, $t2
 move $t2, $t3
 #save again excactly the same as above
 addi $t0, $t1, 0
 mult $t0, $s4
 mflo $t0
 lw $t3, last($t0)
 addi $t0, $t8, 0
 mult $t0, $s4
 mflo $t0
 sw $t3, next($t0)
 addi $t0, $t1, 0
 mult $t0, $s4
 mflo $t0
 sw $t8, last($t0)
 addi $t0, $t8, 0
 mult $t0, $s4
 mflo $t0
 sw $t2, end($t0)
 addi $t8, $t8, 1
 addi $t9, $t9, 1
 j forArry
forArryEnd:
 
 li $t8, 0
 li $t9, 0
 li $t0, 0
 li $t1, 0
 li $t2, 0
 li $t3, 0
 li $t4, 0

#calculation about the hamiton 
#initialize
li $s5, 1  #easy to set
move $t0, $s7
jal dfs
j no
# $s0 number of points 
# $s1 number of lines 
# $s2 number of real lines 
# $s4 4 
#$s5 is 1

# $t0, present point
# $t1, present line
# $t2, length of path
# $t3, present end point
# $t4, for loc
# $t5, for the flag media
# ****************now is the core***************
dfs:
 addi $t4, $t0, 0
 mult $t4, $s4
 mflo $t4
 lw $t1, last($t4)
forCal:
# find the last line by the piont
 beq $t1, 0, jumpra  
# find the end point
 addi $t4, $t1, 0 
 mult $t4, $s4
 mflo $t4
 lw $t3, end($t4)
# find the flag
 addi $t4, $t3, 0
 mult $t4 $s4
 mflo $t4
 lw $t5, flag($t4)  #till now $t5 holds the flag $t3 holds the end of the line
 #if it reached the begin
 bne $t3, $s7, notback
 addi $t2, $t2, 1  # the path can plus 1
 beq $t2, $s0, yes  # if it cover all points
 addi $t2, $t2, -1
 j botom
notback:
 bne $t5, 0, botom #if it has been accessed
 sw $s5, flag($t4) # set the flag
 addi $t2, $t2, 1  #the path can plus 1
 # update the present point
 addi $t0, $t3, 0
 #press stack
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 sw $t1, 0($sp) 
 addi $sp, $sp, -4
 jal dfs
 # move back set 0 and path -1
 addi $t2, $t2, -1
 addi $t4, $t0, 0
 mult $t4, $s4
 mflo $t4
 sw $zero, flag($t4)
 # pop stack
 addi $sp, $sp, 4
 lw $t1, 0($sp) 
 addi $sp, $sp, 4
 lw $ra, 0($sp)
botom:
 addi $t4, $t1, 0
 mult $t4, $s4
 mflo $t4
 lw $t1, next($t4)
 j forCal
jumpra:
 jr $ra
 
# *************************end fo the core*********************

# output 
no:
 li $v0, 1
 li $a0, 0
 syscall
 j terminal
yes:
 li $v0, 1
 li $a0, 1
 syscall
 j terminal
terminal:
 li $v0, 10
 syscall
