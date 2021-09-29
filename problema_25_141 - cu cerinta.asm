#25. Procedura ce primeste ca parametri prin stiva un word n si adresele a
#patru variabile byte (in total cinci parametri) si pune in variabilele
#respective octetii word-ului n; acesti octeti se vor obtine folosind
#operatii logice si de shiftare.
#Procedura isi va accesa parametrii cu $fp iar apelurile vor respecta
#conventiile MIPS si C (privind cadrul de apel, $fp, registrii salvati de
#apelant si apelat, etc.).
#In program citim (cu "syscall", functia "read int") un intreg word, apoi
#apelam procedura dand ca parametri word-ul respectiv si adresele primelor
#patru componente ale unui vector de cinci bytes declarat fara initializare
#(cu ".space"), apoi punem in a cincia componenta caracterul nul si afisam
#stringul rezultat (cu "syscall" functia "print string").
.data
.align  2
v:.space 32
.text
main:
li $v0,5
syscall
la $t0,v
lb $t1, 0($t0)
addu $t0, $t0,1
lb $t2, 0($t0)
addu $t0, $t0,1
lb $t3, 0($t0)
addu $t0, $t0,1
lb $t4, 0($t0)
addu $t0, $t0,1 
sb $zero, 0($t0)

subu $sp, $sp, 20
sw $v0, 0($sp)
sb $t1, 4($sp)
sb $t2, 8($sp)
sb $t3, 12($sp)
sb $t4, 16($sp)

jal stiva

la $t0, 0($sp)
#lw $t1, 0($t0)
la $a0, 0($t0)
li $v0, 4
syscall
#addu $t0, $t0,4

#lw $t1, 0($t0)
#move $a0, $t1
#li $v0, 11
#syscall
#addu $t0, $t0,4

#lw $t1, 0($t0)
#move $a0, $t1
#li $v0, 11
#syscall
#addu $t0, $t0,4

#lw $t1, 0($t0)
#move $a0, $t1
#li $v0, 11
#syscall


li $v0,10
syscall

stiva:

subu $sp, $sp, 4
sw $fp, 0($sp)
addu $fp, $sp, 0

subu $sp, $sp, 4
sw $s0, 0($sp)

subu $sp, $sp, 4
sw $s1, 0($sp)
subu $sp, $sp, 4
sw $s2, 0($sp)
subu $sp, $sp, 4
sw $s3, 0($sp)
subu $sp, $sp, 4
sw $s4, 0($sp)

lw $s0, 4($fp)
#move $a0, $s0
#li $v0, 1
#syscall

lb $s1, 8($fp)
lb $s2, 12($fp)
lb $s3, 16($fp)
lb $s4, 20($fp)

rol
#andi $s4, $s0, 255
#sll $s0,$s0,3



#andi $s3, $s0, 255
#sll $s0,$s0,3

#move $a0, $s3
#li $v0, 1
#syscall

#andi $s2, $s0, 255
#sll $s0,$s0,3


#move $a0, $s2
#li $v0, 1
#syscall

#andi $s1, $s0, 255
#sll $s0,$s0,3


#move $a0, $s1
#li $v0, 1
#syscall


#sll $s0,$s0,3


#move $a0, $s0
#li $v0, 1
#syscall

move $a0, $s0
li $v0, 1
syscall

#move $a0, $s0
#li $v0, 1
#syscall

lw $s4, -20($fp)
lw $s3, -16($fp)
lw $s2, -12($fp)
lw $s1, -8($fp)
lw $s0, -4($fp)
lw $fp, 0($fp)
addu $sp, $sp, 24
jr $ra








