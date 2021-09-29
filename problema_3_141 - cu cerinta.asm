#3. Functie ce primeste ca parametru prin stiva adresa unui string
# ce contine o expresie (de 3 caractere plus un caracter nul) de forma "a+b",
# "a*b" (unde a si b sunt caractere cifra) si returneaza prin stiva
# un intreg reprezentand rezultatul evaluarii expresiei; numarul corespunzator
# unui caracter cifra c este codul lui c - 48.
 #Functia isi va accesa parametrul cu $fp iar apelurile vor respecta
 #conventiile MIPS si C (privind cadrul de apel, $fp, registrii salvati de
 #apelant si apelat, etc.).
 #Program care aplica functia unui string ".asciiz" declarat cu initializare
 #si afisaza (cu "syscall") rezultatul.
 
 .data
 str:.asciiz "2+3"
 .text
 main:
 la $t0, str
 subu $sp, $sp, 4
 sw $t0, 0($sp)
 jal stiva
 lw $t0, 0($sp)
 addu $sp, $sp,4
 la $a0, ($t0)
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
 
 lw $s0,4($fp) 
 lb $t0, 0($s0)
 subu $t0,$t0,48
 addi $s0, $s0, 1 
 lb $t1, 0($s0)
 addi $s0, $s0, 1
 lb $t2, 0($s0)
 subu $t2,$t2,48
 
 li $t3, '*'
 beq $t1, $t3 inmultesc
 
 addu $t0,$t0, $t2
 addu $t0, $t0 48
 j terminat
 
 inmultesc:
 mul $t0,$t0,$t2
 addu $t0, $t0, 48
 
 terminat:
 lw $s0, 4($fp)
 sb $t0, 0($s0)
 addu $s0, $s0, 1
 sb  $zero, 0($s0)
 
 lw $s0, -4($fp)
 lw $s0, 0($fp)
 addu $sp, $sp, 8
 jr $ra 
 
 
 
 
 
 
 