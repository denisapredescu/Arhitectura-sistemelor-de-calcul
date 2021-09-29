.data
m:.word 21
n:.word 8
x:.space 5     #cat
y:.space 5    #restul  lui m la n
da:.asciiz "la fel"
nu:.asciiz "nu la fel"
.text
main:
lw $t0, m
lw $t1, n
la $t2, x
la $t3, y

subu $sp,$sp,16
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $t2, 8($sp)
sw $t3, 12($sp)

jal stiva

lw $t2, 8($sp)
lw $t3, 12($sp)
addu $sp, $sp, 16

sub $t2,$t2,$t3
andi $t2,$t2,1

beqz $t2, aceeasi_paritate

la $a0, nu
li $v0,4
syscall
j exit

aceeasi_paritate:
la $a0, da
li $v0,4
syscall

exit:
li $v0,10
syscall

stiva:

subu $sp,$sp,4
sw $fp, 0($sp)
addu $fp,$sp,0

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

lw $s0,4($fp)  #m
lw $s1,8($fp)   #n
lw $s2,12($fp)   #x  cat
lw $s3,16($fp)    #y  rest

divu $s0,$s1
mflo $s2
mfhi $s3

sw $s2, 12($fp)
sw $s3, 16($fp)

lw $s3, -20($fp)
lw $s2, -16($fp)
lw $s1, -12($fp)
lw $s0, -8($fp)
lw $ra, -4($fp)
lw $fp, 0($fp)
addu $sp,$sp,24
jr $ra


