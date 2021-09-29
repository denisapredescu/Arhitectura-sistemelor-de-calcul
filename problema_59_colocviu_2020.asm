.data
v:.word 1,2,3,4,5,6,7,8,9,10
lung:.word 10
msj:.asciiz "permutat"
.text
main:
la $t0,v
lw $t1, lung

subu $sp,$sp,8
sw $t0, 0($sp)
sw $t1, 4($sp)

jal stiva

#lw $t0, 0($sp)
addu $sp, $sp,8

#afis:
#beqz $t1, term
#lw $t2,0($t0)
#move $a0, $t2
#li $v0,1
#syscall
#addu $t0,$t0,4
#sub $t1, $t1,1
#j afis

#term:
la $a0, msj 
li $v0, 4
syscall
li $v0,10
syscall

stiva:

subu $sp, $sp,4
sw $fp, 0($sp)
addu $fp, $sp, 0

subu $sp, $sp,4
sw $s0, 0($sp)

subu $sp, $sp,4
sw $s1, 0($sp)

subu $sp, $sp,4
sw $s2, 0($sp)

lw $s0, 4($fp)  #vectorul
lw $s1, 8($fp)  #lungimea
lw $s2, 0($s0)  #primul element

addu $s0, $s0, 4
subu $s1, $s1, 1

while:

beqz $s1, exit
lw $t0, 0($s0)
subu $s0, $s0, 4   #scade cu 4 pt a pune pe pozitia precedenta
sw $t0, 0($s0)
addu $s0, $s0, 8
subu $s1,$s1,1
j while

exit:
subu $s0, $s0, 4 
sw $s2, 0($s0)

lw $s2, -12($fp)
lw $s1, -8($fp)
lw $s0, -4($fp)
lw $fp, 0($fp)
addu $sp, $sp, 16
jr $ra

