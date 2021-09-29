#21. Functie ce primeste ca parametri prin stiva patru bytes (parametri
# distincti) si returneaza in $v0 word-ul format din cei patru bytes
# (pentru compunerea lui se vor folosi operatii logice si de shiftare).
# Functia isi va accesa parametrii cu $fp iar apelurile vor respecta
#conventiile MIPS si C (privind cadrul de apel, $fp, registrii salvati
#de apelant si apelat, etc.); atentie la aliniera datelor !
#In program se va scrie un ciclu in care functia se va aplica pentru
# sistemele de patru componente succesive ale unui vector de bytes declarat
# cu initializare si avand un numar de componente multiplu de patru
# (functia se aplica componentelor de pe pozitiile 0,1,2,3, apoi 4,5,6,7,
# etc.); valorile returnate se aduna intr-o alta variabila x. La sfarsit se
# afisaza (cu "syscall") mesajul "nul" sau "nenul" dupa cum x este
# in final 0 sau nu.

.data
x:.word 0
vb:.asciiz "0000"
nul:.asciiz "nul" 
nenul:.asciiz "nenul"
spa:.byte '\n'
.text
main:
lw $t0, x
la $t1, vb

while:
lb $t2, 0($t1)
move $a0, $t2
li $v0, 11
syscall
beqz $t2, terminat
subu $sp, $sp, 4
sb $t2, 0($sp)
addi $t1, $t1, 1
lb $t2, 0($t1)
sb $t2, 0($sp)
addi $t1, $t1, 1
lb $t2, 0($t1)
sb $t2, 0($sp)
addi $t1, $t1, 1
lb $t2, 0($t1)
sb $t2, 0($sp)
addi $t1, $t1, 1


jal stiva

move $t3, $v0
move $a0, $t3
li $v0, 35
syscall 
addu $t0, $t0, $t3
j while

terminat:
beqz $t0, gol
la $a0, nenul
li $v0, 4
syscall
j final
gol: 
la $a0, nul
li $v0, 4
syscall
final:
li $v0, 10
syscall

stiva:

subu $sp, $sp, 4
sw $fp, 0($sp) 
addu $fp, $sp, 0

subu $sp, $sp, 1
sb $s0, 0($sp) 
subu $sp, $sp, 1
sb $s1, 0($sp) 
subu $sp, $sp, 1
sb $s2, 0($sp) 
subu $sp, $sp, 1
sb $s3, 0($sp) 

lb $s0,4($fp)
lb $s1,5($fp)
lb $s2,6($fp)
lb $s3,7($fp)

li $t7, 0


or $t7,$t7, $s0
sll $t7, $t7, 8




or $t7,$t7, $s1
sll $t7, $t7, 8
or $t7,$t7, $s2
sll $t7, $t7, 8
or $t7,$t7, $s3


move $v0, $t7



lb $s3,-7($fp)
lb $s2,-6($fp)
lb $s1,-5($fp)
lb $s0,-4($fp)
lw $fp,0($fp)
addu $sp, $sp, 8
jr $ra

















