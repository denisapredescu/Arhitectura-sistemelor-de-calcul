.data
s:.space 1000
a:.byte 'a'
c:.byte 'w'
.text
main:
la $t0,s
lb $t1,a
lb $t2,c
subu $sp,$sp,12
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $t2, 8($sp)
 
jal stiva

la $a0,s
li $v0,4
syscall
 
addu $sp,$sp,12
li $v0,10
syscall

stiva:
subu $sp,$sp,4
sw $fp, 0($sp)
addu $fp,$sp,0   #$sp><$fp pointeaza aici>$fp(adresa lui s)(a)(c)

subu $sp,$sp,4
sw $ra, 0($sp)

subu $sp,$sp,4
sw $s2, 0($sp)

subu $sp,$sp,4
sw $s1, 0($sp)

subu $sp,$sp,4
sw $s0, 0($sp)

lw $s0, 4($fp)
lb $s1, 8($fp)
lb $s2, 12($fp)


completez:
beq $s1, $s2, terminat
sb $s1, 0($s0)
addu $s0,$s0,1
addi $s1,$s1,1

j completez
terminat:

sb $s1, 0($s0)
addu $s0,$s0,1
sb $zero, 0($s0)

lw $s0, -16($fp)
lw $s1, -12($fp)
lw $s2, -8($fp)
lw $ra, -4($fp)
lw $fp, 0($fp)

addu $sp, $sp,20 
 
jr $ra
