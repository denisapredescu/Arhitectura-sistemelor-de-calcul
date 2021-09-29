
#12. Functie ce primeste ca parametri prin stiva un byte b, adresa unui
# vector de bytes v si lungimea sa n (intreg) si care intr-un ciclu pentru
# fiecare componenta v[i] efectueaza urmatoarele: daca v[i]>7 nu face
# nimic, altfel seteaza la 1 bitul de pe pozitia v[i] din b (indicatie:
# pentru a seta la 1 bitul de pe pozitia v[i] din b facem OR intre b si
# byte-ul obtinut prin shiftarea lui 0x1 la stanga cu v[i]); functia
# returneaza in $v0 valoarea finala obtinuta din b.
# Functia isi va accesa parametrii cu $fp iar apelurile vor respecta
# conventiile MIPS si C (privind cadrul de apel, $fp, registrii salvati de
# apelant si apelat, etc.); atentie la aliniera datelor !
# Program care apeleaza functia cu niste parametri fixati iar in final
# afisaza valoarea returnata ca pe un intreg (cu "syscall", functia
# "print int").
.data
bt:.byte 'a'
v:.ascii "A"
lung:.word 7
.text
main:
lb $t0, bt
la $t1, v
lw $t2,lung

subu $sp, $sp, 12
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $t2, 8($sp)

jal stiva

move $a0, $v0
li $v0, 1
syscall
li $v0, 10
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

lb $s0, 4($fp)  #byteul
lw $s1, 8($fp)   #vectorul de bytes
lw $s2, 12($fp)  #lungimea vectorului

li $t0, 7
li $t4, 1 #pentru shiftarea lui
while:
beqz $s2, parcurs_vector
lb $t1, 0($s1)
blt $t1, $t0, mai_mic
sllv $t3, $t4, $t1
or $s0,$s0,$t3
mai_mic:
addi $s1, $s1, 1
sub $s2, $s2,1
j while
parcurs_vector:

move $v0, $s0

lw $s2, -12($fp)
lw $s1, -8($fp)
lw $s0, -4($fp)
lw $fp, 0($fp)
addu $sp $sp, 16
jr $ra
