.data
data1:.asciiz "01000111"
data2:.asciiz "11000011"
data3:.asciiz "11000001"
a:.word data1, data2,data3
lung:.word 3
d:.byte 'd'  #diferita
e:.byte 'e'  #egala
ca:.space 8
.text
main:
la $t8, a
lw $t7, lung
inca_nu:
lw $t9,0($t8)
#la $a0, 0($t9)
#li $v0,4
#syscall
beqz $t7,  vector_terminat
move $t0,$t9

addi $t8,$t8,4
subu $t7,$t7,1
la $t5, ca
lb $t1, 0($t0)
li $t2,8
inca_aici:
beqz $t2, zero
sb $t1, 0($t5)
addi $t0,$t0,1
addi $t5,$t5,1
lb $t1, 0($t0)
subu $t2,$t2,1
j inca_aici
zero:
sb $zero, 0($t5)
la $t5 ,ca
move $t0, $t9
subu $sp,$sp,4
sw $t0, 0($sp)

jal stiva

move $t4,$v0
#la $a0,0($t4)
#li $v0,4
#syscall
#la $a0,0($t5)
#li $v0,4
#syscall
lb $t2,0($t5)
loop:
beqz $t2, sfarsit
lb $t3,0($t4)
bne $t2, $t3 diferite

addi $t5,$t5,1
addi $t4,$t4,1
lb $t2,0($t5)
j loop

diferite:
lb $a0,d
li $v0,11
syscall
j am_afisat

sfarsit:
lb $a0,e
li $v0,11
syscall

am_afisat:
j inca_nu
vector_terminat:
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

subu $sp,$sp,4
sw $s4, 0($sp)



lw $s0, 4($fp)
lb $s1, 0($s0)
continua:
beqz $s1, terminat
addi $s0,$s0,1

lb $s2, 0($s0)
sb $s1, 0($s0)
subu $s0,$s0,1
sb $s2, 0($s0)


addi $s0,$s0,2
lb $s1, 0($s0)

j continua

terminat:

lw $v0, 4($fp)
lw $s4,-20($fp)
lw $s3,-16($fp)
lw $s2,-12($fp)
lw $s1,-8($fp)
lw $s0,-4($fp)
lw $ra,-4($fp)
lw $fp,0($fp)
addu $sp,$sp,24
jr $ra
