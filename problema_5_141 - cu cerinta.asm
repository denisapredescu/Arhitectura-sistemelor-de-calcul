
#5. Functie ce primeste ca parametru prin stiva un numar natural (word) si
 #returneaza $v0=1 sau $v0=0 dupa cum numarul respectiv este sau nu perfect
 #(adica este egal cu suma divizorilor sai, printre divizori incluzand 1 si
 #excluzand numarul insusi); de exemplu 6 este perfect (= 1 + 2 + 3).
 #Functia isi va accesa parametrul cu $fp iar apelurile vor respecta
 #conventiile MIPS si C (privind cadrul de apel, $fp, registrii salvati
 #de apelant si apelat, etc.).
 #Program care intr-un ciclu, la fiecare iteratie citeste (cu "syscall",
 #functia "read int") cate un intreg, ii aplica functia si afisaza (cu
 #"syscall", functia "print string") mesajul "perfect" sau "imperfect"
 #dupa cum valoarea returnata este 1 sau 0; ciclul se incheie la citirea
 #lui 0.
 
.data
perfect:.asciiz "perfect"
imperfect:.asciiz "imperfect"
.text
main:
loop:
li $v0, 5
syscall
move $t0, $v0
beqz $t0, terminat
subu $sp, $sp,4
sw $t0, 0($sp)
jal stiva
move $t1, $v0
beqz $t1, perf

la $a0, imperfect
li $v0, 4
syscall
j ales
perf:
la $a0, perfect
li $v0, 4
syscall

ales:
j loop
terminat:
li $v0,10
syscall

stiva:
subu $sp, $sp, 4
sw $fp,0($sp)
addu $fp, $sp, 0

subu $sp, $sp, 4
sw $s0,0($sp)

lw $s0, 4($fp)
li $t2, 1
li $t4, 0 #suma
divizori:

bge $t2,$s0, mai_mare
rem $t3, $s0, $t2
bnez $t3, nu_div
addu $t4, $t4, $t2
nu_div:
addi $t2, $t2, 1
j divizori

mai_mare:
beq $s0, $t4, egale
li $t2, 1   #nu sunt egale
move $v0,$t2
j exit

egale:
li $t2, 0   #sunt egale
move $v0,$t2
exit:
lw $s0, -4($fp)
lw $fp, 0($fp)
addu $sp, $sp, 8
jr $ra
