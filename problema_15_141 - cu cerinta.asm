#15. Procedura ce primeste ca parametri prin stiva adresa unui string
 #(presupus a fi terminat cu caracterul nul) si un caracter c si returneaza in $v0
 #pozitia pe care apare caracterul c in string (numarand de la 0); daca c nu apare
 #in string va returna 0xffffffff; procedura isi va accesa parametrii cu $fp iar
 #apelurile vor respecta conventiile MIPS si C (privind cadrul de apel, $fp,
 #registrii salvati de apelant si apelat, etc.); atentie la alinierea datelor !
 #Program care apeleaza procedura cu niste parametri dati prin program si afisaza
 #mesajul "apare" sau "nu apare" dupa cum valoarea returnata este, respectiv nu este,
 #diferita de 0xffffffff.
 .data
 str:.asciiz "acolo ar aparea a" 
 c:.byte 's'
 da:.asciiz "apare"
 nu:.asciiz "nu apare"
 .text
 main:
 la $t0, str
 lb $t1, c
 
 subu $sp,$sp, 8
 sw $t0, 0($sp)
 sb $t1, 4($sp)
 
 jal stiva
 
 move $t0, $v0
 addu $sp, $sp, 8
 li $t1, 0xffffffff
 beq $t0, $t1, egale
 
 la $a0, da
 li $v0, 4
 syscall
 j final
 
 egale:
 la $a0, nu
 li $v0, 4
 syscall
 final:
 li $v0,10
 syscall
 
 stiva:
 subu $sp, $sp, 4
 sw $fp, 0($sp)
 addu $fp, $sp, 0
 
 subu $sp, $sp, 4
 sw $s0, 0($sp)
 subu $sp, $sp, 1
 sb $s1, 0($sp)
 
 lw $s0, 4($fp)  #adresa stringului
 lb $s1, 8($fp)   #caracter
 li $t3, 0
 while:
 lb $t0, 0($s0)
 beqz $t0, exit
 bne $t0,$s1, nu_egale
 move $v0, $t3
 j gasit
 nu_egale:
 addi $t3, $t3,1
 addi $s0, $s0,1 
 j while
 exit:
 li $t3, 0xffffffff
 move $v0, $t3
 gasit:
 lw $s1, -8($fp)
 lw $s0, -4($fp)
 lw $fp, 0($fp)
 subu $sp, $sp, 9
 jr $ra