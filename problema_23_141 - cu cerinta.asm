#23. Functie ce primeste ca parametru prin stiva un caracter si returneaza
 #prin stiva upcase-ul sau; upcase-ul unei litere mici este litera mare
 #corespunzatoare, iar upcase-ul unui caracter ce nu este litera mica este
 #chiar caracterul respectiv; functia isi va accesa parametrul cu $fp
 #iar apelurile vor respecta conventiile MIPS si C (privind cadrul de apel,
 #$fp, registrii salvati de apelant si apelat, etc.); atentie la alinierea datelor !

# Program care contine o variabila globala ".asciiz" initializata cu un
# string iar intr-un ciclu inlocuieste fiecare caracter al sau (pana la
 #caracterul nul exclusiv) cu upcase-ul acestuia (folosind functia) si in
#final afisaza strimgul obtinut (cu "syscall"). De exemplu daca stringul
#este "aB1,ce" va afisa "AB1,CE".
.data
str:.asciiz "AB1,,.ce"
.text
main:
la $t0, str
subu $sp, $sp, 4
sw $t0, 0($sp)

jal stiva

la $a0, str
li $v0, 4
syscall
li $v0, 10
syscall


stiva:
subu $sp, $sp, 4
sw $fp, 0($sp)
addu $fp, $sp, 0

subu $sp, $sp, 4
sw $s0, 0($sp)

lw $s0, 4($fp)

#122 -z
#97 -a

li $t2,97
li $t3,122

while:
lb $t0,0($s0)
beqz $t0, exit
blt $t0, $t2, inainte_de_a
bgt $t0, $t3, dupa_z
subu $t0, $t0, 32   #diferenta dintre A si a
sb $t0, 0($s0)
inainte_de_a:
dupa_z:
addu $s0, $s0,1
j while

exit:
lw $s0, -4($fp)
lw $fp, 0($fp)
addu $sp, $sp, 8
jr $ra






