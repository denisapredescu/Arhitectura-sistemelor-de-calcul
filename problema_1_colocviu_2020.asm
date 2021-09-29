.data
str:.asciiz "abcdefghi"
.text
main:
la $t0,str
li $t2,0
lungime:
lb $t1,0($t0)
beqz $t1, final
addi $t0,$t0,1
addi $t2,$t2,1
j lungime
final:
la $t0,str
subu $sp,$sp,8
sw $t0, 0($sp)
sw $t2, 4($sp)

#move $a0,$t2
#li $v0,1
#syscall

jal stiva

lw $t0, 0($sp)
addu $sp,$sp,8

la $a0,0($t0)
li $v0,4
syscall
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

lw $s0,4($fp) #adresa
#la $a0,0($s0)
#li $v0,4
#syscall
lw $s1,8($fp)  #lungime
#move $a0,$s1
#li $v0,1
#syscall  

addu $s1,$s0,$s1
sub $s1,$s1,1

diferit:
bgt $s0,$s1 mijloc
lb $s2,0($s0)
lb $s3,0($s1)

sb $s3,0($s0)
sb $s2,0($s1) 
addi $s0,$s0,1
sub $s1,$s1,1
j diferit

mijloc:
lw $s0,4($fp)
#la $a0,0($s0)
#li $v0,4
#syscall

lw $s3,-20($fp)
lw $s2,-16($fp)
lw $s1,-12($fp)
lw $s0,-8($fp)
lw $ra,-4($fp)
lw $fp,0($fp)
addu $sp,$sp,24
jr $ra

