.data
v:.word 2,1,4,3,4,10,35,38
n:.word 8
w:.space 20 
mesaj:.asciiz "generat"
.text
main:
la $t0,v
lw $t1, n
la $t2, w

subu $sp, $sp, 12
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $t2, 8($sp)

jal stiva

move $t3, $v0

#move $a0, $t3
#li $v0, 1
#syscall
#la $t2, w
#loop:
#beqz $t3, stop
#lw $t4, 0($t2)
#move $a0, $t4
#li $v0,1
#syscall
#addi $t2, $t2, 4
#subu $t3, $t3,1
#j loop
#stop:

la $a0, mesaj
li $v0, 4
syscall
li $v0, 10
syscall

stiva:
subu $sp, $sp, 4
sw $fp, 0($sp)
addu $fp, $sp, 0

subu $sp, $sp, 4
sw $s0, 0($sp)

subu $sp, $sp, 4
sw $s1, 0($sp)

subu $sp, $sp, 4
sw $s2, 0($sp)

subu $sp, $sp, 4
sw $s3, 0($sp)

lw $s0, 4($fp)
lw $s1, 8($fp)
lw $s2, 12($fp)
li $s3,0

li $t0,2

while:
beqz $s1, exit_while
lw $t1, 0($s0)
rem $t2, $t1, $t0

bnez $t2, impar
sw $t1, 0($s2)
addi $s3, $s3,1
addu $s2, $s2,4
impar:

sub $s1, $s1,1
addu $s0,$s0,4
j while

exit_while:
move $v0, $s3

lw $s3, -16($fp)
lw $s2, -12($fp)
lw $s1, -8($fp)
lw $s0, -4($fp)
lw $fp, 0($fp)
addu $sp, $sp, 20
jr $ra













