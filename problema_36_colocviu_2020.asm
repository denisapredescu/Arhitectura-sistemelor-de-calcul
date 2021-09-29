.data
v:.word 2, 3, 4, 5
lung:.word 4
msj:.asciiz "ok"
.text
main:
la $t0,v
lw $t1,lung

subu $sp,$sp,8
sw $t0, 0($sp)
sw $t1, 4($sp)

jal stiva

#la $t0,v
addu $sp, $sp,8

#ciclu:
#beqz $t1, exit
#lw $t2, 0($t0)
#move $a0, $t2
#li $v0,1
#syscall
#addu $t0,$t0,4
#sub $t1, $t1,1
#j ciclu
#exit:

la $a0,msj
li $v0,4
syscall

li $v0,10
syscall


stiva:
subu $sp, $sp, 4
sw $fp, 0($sp)
addu $fp,$sp,0

subu $sp, $sp, 4
sw $s0, 0($sp)

subu $sp, $sp, 4
sw $s1, 0($sp)

subu $sp, $sp, 4
sw $s2, 0($sp)

lw $s0, 4($fp)   #vector
lw $s1, 8($fp)   #lung
lw $s2, 0($s0)  #primul elem

while:

addu $s0,$s0,4
subu $s1,$s1,1
beqz $s1, terminat
sw $s2, 0($s0)

j while

terminat:
lw $s2, -12($fp)
lw $s1, -8($fp)
lw $s0, -4($fp)
lw $fp, 0($fp)

addu $sp,$sp,16
jr $ra
