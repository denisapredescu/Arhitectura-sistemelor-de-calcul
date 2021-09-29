.data
v:.word 10, -10, -10
lung:.word 3
x:.space 5
y:.space 5
da:.asciiz "la fel"     #determinat minimul(x),suma(y) si verifica daca cele 2 sunt egale
nu:.asciiz "nu la fel"
.text
main:
la $t0, v
lw $t1, lung
la $t2, x
la $t3, y
la $a0, 0($t0)
li $v0,4
syscall
subu $sp, $sp, 16 
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $t2, 8($sp)
sw $t3, 12($sp)

jal stiva

lw $t2, 8($sp)
lw $t3, 12($sp)
addu $sp,$sp,16

#move $a0,$t2
#li $v0,1
#syscall

#move $a0,$t3
#li $v0,1
#syscall

beq $t2, $t3, egale

la $a0, nu 
li $v0,4
syscall
j exit

egale:
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

lw $s0,4($fp)  #adresa vectorului
lw $s1, 8($fp)  #lungimea vectorului
lw $s2, 12($fp)   #x   elem minim
lw $s3, 16($fp)   #y    suma elem

lw $t0, 0($s0)  #primul elem
move $s2, $t0
move $s3, $t0

sub $s1, $s1, 1
addi $s0,$s0,4

while:
lw $t0, 0($s0)
beqz $s1, terminat_vector

bge $t0, $s2 mai_mare

move $s2,$t0

mai_mare:
addu $s3,$s3,$t0
addi $s0, $s0,4
subu $s1,$s1,1

j while

terminat_vector:

sw $s2, 12($fp)    #trebuie neaparat sa le pun inapoi in $fp
sw $s3, 16($fp)

lw $s3,-20($fp)
lw $s2,-16($fp)
lw $s1,-12($fp)
lw $s0,-8($fp)
lw $ra,-4($fp)
lw $fp,0($fp)
addu $sp, $sp,24
jr $ra













