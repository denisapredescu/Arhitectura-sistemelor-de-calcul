.data
v:.word -2, -8, -7, -77
lung:.word 4
da:.asciiz "exista"
nu:.asciiz "nu exista"
.text
main:
la $t0, v
#li $t1, 0
#lw $t2, 0($t0)
lw $t3,lung

#loop:
#bge $t1, $t3 terminat

#move $a0,$t2
#li $v0,1
#syscall
#addi $t1,$t1,1
#addi $t0,$t0,4
#lw $t2, 0($t0)

#j loop
#terminat:

#la $t0,v

subu $sp,$sp,4
sw $t3,0($sp)

subu $sp,$sp,4
sw $t0,0($sp)

jal stiva 

move $t0,$v0 
li $t2,1
beq $t2,$t0 egale

la $a0, nu
li $v0, 4
syscall
j salt
egale:

la $a0, da
li $v0, 4
syscall
j sfarsit

salt:
sfarsit:
addu $sp,$sp,8
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

subu $sp,$sp,4
sw $s4,0($sp)

lw $s0,4($fp)

lw $s1,8($fp)
li $s2,0   #initiala 0 merge pana la $s1
lw $s3,0($s0)
li $s4,0 #ok-ul, se schimba doar daca gaseste un nr neg
ciclu:
beq $s2,$s1 gata

bgez $s3 mai_mare   #element mai mic
addi $s2,$s2,1
addi $s0,$s0,4
lw $s3,0($s0)
j ciclu

mai_mare:
addi $s4,$s4,1

gata:

move $v0,$s4

lw $s3,-24($fp)
lw $s3,-20($fp)
lw $s2,-16($fp)
lw $s1,-12($fp)
lw $s0,-8($fp)
lw $ra,-4($fp)
lw $fp,0($fp)
addu $sp,$sp,28

jr $ra