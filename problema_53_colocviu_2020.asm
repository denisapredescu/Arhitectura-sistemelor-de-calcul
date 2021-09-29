.data
v:.word 10001100
str:.asciiz ""
.text
main:
lw $t0, v
la $t1, str

move $a0, $t0
li $v0, 1
syscall

subu $sp, $sp,8
sw $t0,0($sp)
sw $t1, 4($sp)

jal stiva

lw $t0,4($sp)
la $a0,0($t0)
li $v0,4
syscall
addu $sp, $sp, 8

li $v0,10
syscall

stiva:
subu $sp, $sp, 4
sw $fp, 0($sp)
addu $fp,$sp,0

subu $sp, $sp, 4
sw $ra, 0($sp)

subu $sp, $sp, 4
sw $s0, 0($sp)
subu $sp, $sp, 4
sw $s1, 0($sp)

lw $s0, 4($fp)  #word
lw $s1, 8($fp)


li $t9, 10 
li $t8,65
while:
li $t0, 4
li $t1, 1
li $t2, 0  #suma
beqz $s0, terminat_word

suma:
beqz $t0, zero
divu $s0, $t9
mflo $s0
mfhi $t3

mul $t3,$t3,$t1
addu $t2, $t2,$t3
mul $t1,$t1,2
subu $t0,$t0,1
j suma
zero:
addu $t2, $t2,$t8
sb $t2, 0($s1)
addu $s1,$s1,1
j while

terminat_word:

sb $zero, 0($s1)
lw $s1, 8($fp)

ordine_inversa:
lb $t0, 0($s1)
beqz $t0, gata
subu $sp,$sp,1
sb $t0, 0($sp)
addi $s1, $s1,1
j ordine_inversa

gata:
lw $s1, 8($fp)
ordine:
lb $t0, 0($s1)

beqz $t0, final

lb $t0, 0($sp)
sb $t0, 0($s1)
addi $s1, $s1,1
addi $sp, $sp,1
j ordine

final:
#lw $s1, 8($fp)
#la $a0,0($s1)
#li $v0,4
#syscall

lw $s1, -12($fp)
lw $s0, -8($fp)
lw $ra, -4($fp)
lw $fp, 0($fp)

addu $sp, $sp, 16
jr $ra









