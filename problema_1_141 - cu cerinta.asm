#1. Functie ce primeste ca parametri prin stiva adresa unui vector de
#intregi si lungimea sa n (intreg) si: daca n este impar, returneaza in
#$v0 elementul de pe pozitia (n-1)/2, iar daca n este par, returneaza in
#$v0 suma elementelor aflate pe pozitiile (n-2)/2 si n/2; presupunem ca
#pozitiile sunt de la 0 la n-1 iar n>=1.
#Functia isi va accesa parametrii cu $fp iar apelurile vor respecta conventiile
#MIPS si C (privind cadrul de apel, $fp, registrii salvati de apelant si apelat,
#etc.).
#Program care apeleaza functia cu niste parametri fixati si afisaza mesajul (cu
#"syscall") "mai mare" sau "mai mic" dupa cum valoarea returnata este >10 sau nu."

.data
v:.word 1,2,3,4,5,6,7,8,9
lung:.word 9
mare:.asciiz "mai mare"
mic:.asciiz "mai mic"
.text
main:
la $t0, v
lw $t1, lung
subu $sp, $sp, 8
sw $t0, 0($sp)
sw $t1, 4($sp)

jal stiva 

addu $sp, $sp, 8
move $t0,$v0

#move $a0, $t0
#li $v0,1
#syscall

li $t1,10
bgt $t0, $t1 mai_mare
la $a0, mic
li $v0, 4
syscall
j sfarsit
mai_mare:
la $a0, mare
li $v0, 4
syscall
sfarsit:
li $v0, 10
syscall

stiva:
subu $sp, $sp 4
sw $fp, 0($sp)
addu $fp, $sp,0

subu $sp, $sp 4
sw $s0, 0($sp)
subu $sp, $sp 4
sw $s1, 0($sp)

lw $s0, 4($fp)
lw $s1, 8($fp)

li $t0, 2
rem $t0, $s1, $t0

beqz $t0, par

subu $t0, $s1, 1
div $t0, $t0,2
ciclu_impar:
beqz $t0, stop_impar
subu $t0,$t0,1
addu $s0, $s0,4
j ciclu_impar
stop_impar:
lw $t1, 0($s0)
move $v0, $t1
j exit

par:
subu $t0, $s1,2
div $t0, $t0, 2
ciclu_par:
beqz $t0, stop_par
subu $t0,$t0,1
addu $s0, $s0,4
j ciclu_par
stop_par:
 #suma
lw $t1, 0($s0)
addu $s0, $s0,4
lw $t2, 0($s0)
addu $t1, $t1, $t2
move $v0, $t1
exit:
lw $s1, -8($fp)
lw $s0, -4($fp)
lw $fp, 0($fp)
addu $sp, $sp,12
jr $ra










