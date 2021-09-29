#4. Procedura ce primeste ca parametri prin stiva adresa unui vector de
#intregi v si un intreg n (>=0) si genereaza in v tabla inmultirii cu n
#liniarizata - mai exact v[0], v[1], v[2], ... vor fi respectiv
#0*0, 0*1, ..., 0*n, 1*0, 1*1, ..., 1*n, 2*0, 2*1, ..., 2*n, ..., n*0, n*1,
#..., n*n.
#Procedura isi va accesa parametrii cu $fp iar apelurile vor respecta
#conventiile MIPS si C (privind cadrul de apel, $fp, registrii salvati de
#apelant si apelat, etc.).
#Program care apeleaza procedura cu niste parametri fixati si afisaza
#(cu "syscall") mesajul "tabla generata".
#Indicatie: putem folosi algoritmul:
#k=0; for(i=0;i<=n;++i)for(j=0;j<=n;++j) {v[k]=i*j; ++k;}
#in loc de i,j,k putem folosi registri callee-saved.
.data
v:.space 1000000
n:.word 7
spatiu:.byte '\n'
mesaj:.asciiz "tabla generata"
.text
main:
la $t0, v
lw $t1, n

subu $sp, $sp, 8
sw $t0,0($sp)
sw $t1,4($sp)

jal stiva

la $a0, mesaj
li $v0, 4
syscall

lb $a0, spatiu
li $v0, 11
syscall

la $t0, v
lw $t1, n

li $t2, 0
linie:
bgt $t2,$t1 final_linii
li $t3, 0
coloana:
bgt $t3, $t1 final_coloana
lw $t4, 0($t0)
move $a0, $t4
li $v0, 1
syscall
addu $t0, $t0, 4
addu $t3, $t3, 1
j coloana
final_coloana:
lb $a0, spatiu
li $v0, 11
syscall
addu $t2, $t2, 1
j linie

final_linii:

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
lw $s0, 4($fp)
lw $s1, 8($fp)

li $t0, 0
linie_afis:
bgt $t0, $s1 final_linii_afis
li $t1, 0
coloana_afis:
bgt $t1, $s1 final_coloana_afis
mul $t3, $t0, $t1
sw $t3, 0($s0)
addu $s0, $s0, 4
addu $t1, $t1, 1
j coloana_afis
final_coloana_afis:
addu $t0, $t0, 1
j linie_afis

final_linii_afis:

lw $s1, -8($fp)
lw $s0, -4($fp)
lw $fp, 0($fp)
addu $sp, $sp, 12
jr $ra







