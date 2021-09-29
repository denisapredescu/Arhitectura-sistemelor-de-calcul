.data
str:.asciiz "abcdef"
n:.word 0
c:.byte 'x'
.text
main:
la $t0,str
lw $t1,n
lb $t2,c
subu $sp,$sp,12
sw $t0, 0($sp)
sw $t1, 4($sp)
sb $t2, 8($sp)

jal stiva

lw $t0, 0($sp)
la $a0, 0($t0)
li $v0,4
syscall
li $v0,10
syscall

stiva:

subu $sp,$sp,4
sw $fp, 0($sp)
addu $fp, $sp,0

subu $sp,$sp,4
sw $ra, 0($sp)
subu $sp,$sp,4
sw $s0, 0($sp)
subu $sp,$sp,4
sw $s1, 0($sp)
subu $sp,$sp,4
sw $s2, 0($sp)
subu $sp,$sp,4
sw $s3, 0($sp)

lb $s0, 12($fp)
lw $s1, 8($fp)
lw $s2, 4($fp)
sub $s1,$s1,1
while:
lb $s3, 0($s2)
beqz $s3, terminat_string
bnez $s1, nu_poz
sb $s0,0($s2)
j inlocuit
nu_poz:
addi $s2,$s2,1
sub $s1,$s1,1
j while
terminat_string:
inlocuit:

lw $s3,-20($fp)
lw $s2,-16($fp)
lw $s1,-12($fp)
lw $s0,-8($fp)
lw $ra,-4($fp)
lw $fp,0($fp)

addu $sp,$sp,24
jr $ra


