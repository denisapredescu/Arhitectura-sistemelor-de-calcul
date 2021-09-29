#22. Functie ce primeste ca parametru prin stiva adresa unui string ce
# contine 8 caractere '0' sau '1' (si la sfarsit un caracter nul)
# si returneaza in $v0 byte-ul format din bitii 0/1 in aceeasi ordine ca si
# careterele '0'/'1' din string; de exemplu daca stringul dat ca parametru
# este "01000011", functia va returna $v0 = 01000011 binar = 67; byte-ul va
# fi construit folosind operatii logice si de shiftare.
# Functia isi va accesa parametrul cu $fp iar apelurile vor respecta
# conventiile MIPS si C (privind cadrul de apel, $fp, registrii salvati de
# apelant si apelat, etc.).
# Program care aplica functia cu un parametru fixat
# si afisaza byte-ul returnat, ca un intreg (cu "syscall").
# Indicatie: dintr-un string s ca mai sus se poate obtine un byte b astfel:
# b=0; for(i=0;i<8;++i) {b=b<<1; if(s[i]=='1')b=b | 0x01;}

.data
str:.asciiz "01000111"
.text
main:
la $t0, str
subu $sp, $sp, 4
sw $t0, 0($sp)

jal stiva 

move $t0, $v0
move $a0, $t0
li $v0, 1
syscall 
li $v0,10
syscall

stiva:
subu $sp, $sp, 4
sw $fp, 0($sp)
addu $fp, $sp, 0

subu $sp, $sp, 4
sw $s0, 0($sp)

lw $s0, 4($fp)
li $t0, 0
li $t3, '1'
while:
lb $t1, 0($s0)
beqz $t1, exit
sll $t0, $t0, 1
bne $t1, $t3, zero
ori $t0, $t0,1
zero:
addu $s0, $s0, 1
j while
exit:
move $v0,$t0
lw $s0, -4($fp)
lw $fp, 0($fp)
addu $sp, $sp, 8
jr $ra