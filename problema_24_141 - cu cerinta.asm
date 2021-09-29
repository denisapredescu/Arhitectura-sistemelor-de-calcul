
#24. Program care citeste un intreg (cu "syscall") si afisaza (cu "syscall")
 #cel mai mare intreg ce se poate obtine din el prin rotirea bitilor in el
 #cu cate 1 la dreapta. Afisarea se va face cu o procedura ce primeste
 #intregul ca parametru prin stiva; procedura isi va accesa parametrul cu $fp
 #iar apelurile vor respecta conventiile MIPS si C (privind cadrul de apel,
 #$fp, registrii salvati de apelant si apelat, etc.).
 .data
 spat:.byte ' '
 .text
 main:
 li $v0,5
 syscall
 #li $t5, 0
 move $t0, $v0
 move $t2,$t0  #maxim
 move $t1,$t0
 while:
 move $a0, $t1
 li $v0,1
 syscall
 lb $a0, spat
 li $v0,11
 syscall
 ror $t1,$t1,1
 addi $t5, $t5,1
 beq $t1, $t0, intors
 bge $t2, $t1, mic
 move $t2,$t1
 mic:
 j while
 intors:

 move $a0, $t2
 li $v0,1
 syscall
 
 li $v0,10
 syscall
