.data
str:.asciiz "999782"
#zero:.byte '0'
.text
main:
#lb $t0,zero
#li $t1,48
#beq $t0,$t1, continua
#continua: 

la $t0,str
lb $t1,0($t0)

subu $sp,$sp,4
sw $t0, 0($sp)

jal stiva 


#la $t0,0($sp)
la $a0,str
li $v0,4
syscall

addu $sp,$sp,4
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

lw $s0,4($fp)

lb $s1,0($s0)

li $t2, 48
addi $t3,$t2,9
#lb $t2, zero       #'0'
#li $t3, 9
#addu $t3,$t3,$t2   #'9'

loop:
beqz $s1, final
	bne $s1,$t3 nu_9
	sb $t2, 0($s0)
	addi $s0, $s0,1
	lb $s1,0($s0)

j loop

nu_9:
	addi $s1,$s1,1
	sb $s1,0($s0)

final:

lw $s1,-12($fp)
lw $s0,-8($fp)
lw $ra,-4($fp)
lw $fp,0($fp)
addu $sp,$sp,16

jr $ra


