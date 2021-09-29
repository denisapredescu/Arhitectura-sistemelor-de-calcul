.data
str:.space 10000
c:.byte 'c'
n:.word 10
k:.byte '\0'
.text
la $t0, str
lb $t1, c
lw $t2, n
lb $t3, k
subu $sp,$sp,16
sw $t0, 0($sp)
sb $t1, 4($sp)
sw $t2, 8($sp) 
sb $t3, 12($sp)

jal stiva

lw $t0, 0($sp)
la $a0, 0($t0)
li $v0, 4
syscall
addu $sp, $sp,16
li $v0, 10
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

lw $s0, 4($fp)  #adresa
lb $s1, 8($fp)    #c
lw $s2, 12($fp)   #n
lb $s3, 16($fp)   #k


lungime:
beqz $s2 gata
sb $s1, 0($s0)
subu $s2, $s2, 1
addu $s0,$s0,1
j lungime

gata:
sb $s3, 0($s0)

lw $s3, -20($fp)
lw $s2, -16($fp)
lw $s1, -12($fp)
lw $s0, -8($fp)
lw $ra, -4($fp)
lw $fp, 0($fp)
addu $sp, $sp, 24
jr $ra
