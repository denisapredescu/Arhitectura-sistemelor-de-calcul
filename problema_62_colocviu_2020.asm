.data
v:.word 10, 20, 1, 2
lung:.word 4
mesaj:.asciiz "pliat"
.text
main:
la $t0, v
lw $t1, lung

subu $sp, $sp, 8
sw $t0, 0($sp)
sw $t1, 4($sp)

jal stiva

move $t2, $v0   #lungimea finala
#move $a0, $v0
#li $v0, 1
#syscall

la $a0, mesaj
li $v0, 4
syscall

#la $t0, v
#sar:
#beqz $t2, stop
#lw $t1, 0($t0)
#move $a0, $t1
#li $v0, 1
#syscall
#addu $t0, $t0, 4
#subu $t2, $t2,1
#j sar
#stop:

li $v0,10
syscall

stiva:
subu $sp, $sp, 4
sw $fp, 0($sp)
addu $fp, $sp,0

subu $sp, $sp, 4
sw $s0, 0($sp)
lw $s0, 4($fp)     #adresa de inceput a vectorului

subu $sp, $sp, 4
sw $s1, 0($sp)    
lw $s1, 8($fp)

subu $sp, $sp, 4
sw $s2, 0($sp)
subu $sp, $sp, 4
sw $s3, 0($sp)

move $s2, $s1
addi $s2, $s2, 1
li $s3, 2
divu $s2, $s3
mflo $s2
move $v0, $s2

subu $s1, $s1, 1
li $t1, 4
mul $s1, $s1, $t1
addu $s1, $s0, $s1
   # adresa de final a vectorului

while:

bge $s0, $s1, exit
lw $s2, 0($s0)
lw $s3, 0($s1)
addu $s2, $s2, $s3
sw $s2, 0($s0)
addu $s0, $s0, 4
subu $s1, $s1, 4 
j while

exit:
lw $s3, -16($fp)
lw $s2, -12($fp)
lw $s1, -8($fp)
lw $s0, -4($fp)
lw $fp, 0($fp)

addu $sp, $sp, 10
jr $ra













