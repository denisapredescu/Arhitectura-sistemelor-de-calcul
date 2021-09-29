.data
c:.asciiz "eee"
p:.asciiz "Rezultat par"
i:.asciiz "Rezultat impar"
.text
main:
la $t0,c
move $a0,$t0
#li $v0, 1
#syscall
#li $t1, 2
#rem $t2,$t0,$t1

subu $sp,$sp,4
sw $t0,0($sp)

jal stiva

move $t0,$v0
addu $sp,$sp,4
li $t1, 2
rem $t2,$t0,$t1

beqz $t2, par
la $a0, i
li $v0,4
syscall
j a_fost_impar
par:
la $a0, p
li $v0,4
syscall
a_fost_impar:

li $v0,10
syscall

stiva:
subu $sp,$sp,4

sw $fp,0($sp)
addu $fp, $sp,0

subu $sp,$sp,4
sw $ra,0($sp)
subu $sp,$sp,4
sw $s0,0($sp)
subu $sp,$sp,4
sw $s1,0($sp)
subu $sp,$sp,4
sw $s2,0($sp)

lw $s0, 4($fp)
lb $s1, 0($s0)
li $s2,0
ciclu:
beqz $s1, terminat

addu $s2,$s2,$s1
addu $s0,$s0,1
lb $s1, 0($s0)
j ciclu 

terminat:
move $v0,$s2
lw $s2, -16($fp)
lw $s1, -12($fp)
lw $s0, -8($fp)
lw $ra, -4($fp)
lw $fp, 0($fp)
addu $sp,$sp,20
jr $ra





