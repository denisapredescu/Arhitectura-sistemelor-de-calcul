.data
str:.asciiz "abcdfe"
creat:.space 3
.text
la $t0,str
subu $sp,$sp,4
sw $t0, 0($sp)

jal stiva
li $t0,0
sb $v0, creat($t0)
addi $t0,$t0,1
sb $v1, creat($t0)
addi $t0,$t0,1
sb $zero, creat($t0) 

la $a0,creat
li $v0,4
syscall
li $v0,10
syscall

stiva:
subu $sp,$sp,4
sw $fp, 0($sp)
addu $fp, $sp, 0
subu $sp,$sp,4
sw $ra, 0($sp)
subu $sp,$sp,4
sw $s0, 0($sp)
subu $sp,$sp,4
sw $s1, 0($sp)
subu $sp,$sp,4
sw $s2, 0($sp)

lw $s0,4($fp)
li $s1,0
lungime:
lb $s2, 0($s0)
beqz $s2, terminat
addi $s1,$s1,1
addi $s0,$s0,1
j lungime

terminat:

lw $s0, 4($fp)
li $t0,2
divu $s1,$t0
mflo $s1    #cat
mfhi $t1    #rest

beqz $t1, par
#move $s2,$s1
#addu $s2,$s2,$t1
#while_impar:
#beqz $s1, exit_impar
#sub $s1,$s1,1
#addi $s0,$s0,1
#j while_impar
#exit_impar:

addu $s0,$s0,$s1
lb $s2,0($s0)
move $v0, $s2
#addu $s0,$s0,$s2
addu $s0,$s0,$s1
addu $s0,$s0,$t0
lb $s2,0($s0)
move $v1, $s2
j puse

par:
sub $s1,$s1,1
#while:
#beqz $s1, exit
#sub $s1,$s1,1
#addi $s0,$s0,1
#j while
#exit:
addu $s0,$s0,$s1
lb $s1,0($s0)
move $v0,$s1
addi $s0,$s0,1
lb $s1,0($s0)
move $v1, $s1

puse:
lw $s2,-16($fp)
lw $s1,-12($fp)
lw $s0,-8($fp)
lw $ra,-4($fp)
lw $fp,0($fp)
addu $sp,$sp,10
jr $ra



