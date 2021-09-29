.data
str:.asciiz "abcdefg"
.text
main:
la $t0,str
subu $sp,$sp,4
sw $t0,0($sp)

jal stiva

lw $t0, 0($sp)
la $a0, 0($t0)
li $v0,4
syscall
li $v0,10
syscall

stiva:
subu $sp,$sp,4
sw $fp,0($sp)
addi $fp,$sp,0

lw $t0,4($fp)
while:
lb $s0,0($t0)
beqz $s0,null
subu $sp,$sp,1
sb $s0,0($sp)
addi $t0,$t0,1
j while

null:
lw $t0,4($fp)

creare_string:
lb $s0,0($t0)
beqz $s0,null_final
lb $s0,0($sp)
addu $sp,$sp,1
sb $s0,0($t0)
addu $t0,$t0,1
j creare_string

null_final:
lw $fp,0($fp)
addu $sp,$sp,4
jr $ra


