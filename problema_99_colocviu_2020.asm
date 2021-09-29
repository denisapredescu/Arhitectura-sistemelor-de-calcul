.data
n:.word 6868067
k:.word 0
apare:.asciiz "apare"
nu_apare:.asciiz "nu apare"
.text
main:

lw $t0,n
lw $t1,k
subu $sp,$sp,4
sw $t1,0($sp)
subu $sp,$sp,4
sw $t0,0($sp)

jal stiva

addu $sp,$sp,8
beqz $v0, nu
la $a0, apare
li $v0,4
syscall
j final
nu:
la $a0,nu_apare
li $v0,4
syscall
final:
li $v0,10
syscall


stiva:
subu $sp,$sp,4
sw $fp,0($sp)
addu $fp,$sp,0

subu $sp,$sp,4
sw $ra,0($sp)

subu $sp,$sp,4
sw $s0,0($sp)

subu $sp,$sp,4
sw $s1,0($sp)

subu $sp,$sp,4
sw $s2,0($sp)

subu $sp,$sp,4
sw $s3,0($sp)

#   li $t0, 14
#   li $t1, 4
#   divu $t0, $t1  # impartire fara semn si fara depasire
#    # efectueaza: LO <- $t0 div $t1 (adica 3), HI <- $t0 mod $t1 (adica 2)
#   mfhi $t2       # $t2 = 2 = restul impartirii

lw $s0,4($fp)  #n
lw $s1,8($fp)  #k

li $s3,0
li $t0,10
diferit_zero:
beqz $s0, zero
divu $s0,$t0
mflo $s0
mfhi $s2
beq $s2,$s1, egalitate
j diferit_zero

egalitate:
addi $s3,$s3,1

zero:
move $v0,$s3

lw $s3,-20($fp)
lw $s2,-16($fp)
lw $s1,-12($fp)
lw $s0,-8($fp)
lw $ra,-4($fp)
lw $fp,0($fp)
addu $sp,$sp,24
jr $ra

