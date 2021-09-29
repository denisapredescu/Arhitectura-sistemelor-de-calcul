##Predescu Denisa, grupa 142
#am respectat cerinta si problema ruleaza indiferent de stringul ales

#35. Functie ce primeste ca parametru prin stiva adresa unui string ce
# contine caractere '(', ')' (si un caracter nul la sfarsit) si returneaza
# $v0=1 sau $v0=0 dupa cum  parantezele sunt corect imperechiate sau nu
# (exemplu: "()(()))()" e gresit, "()(()())()" e corect);
# indicatie: un contor primeste initial valoarea 0, apoi la fiecare '(' se
# incrementeaza cu 1 si la fiecare ')' se decrementeaza cu 1; sirul e corect
# daca niciodata contorul nu ajunge negativ
# iar la intalnirea caracterului nul contorul ajunge 0.
# Functia isi va accesa parametrul cu $fp iar apelurile vor respecta
# conventiile MIPS si C (privind cadrul de apel, $fp, registrii salvati de
# apelant si apelat, etc.).
# Program care apeleaza functia cu un parametru fixat si afisaza (pe
# aceeasi linie) stringul analizat urmat de mesajul " corect" sau " gresit"
# dupa cum valoarea returnata este 1 sau 0; afisarea se va face cu "syscall".

.data
str:.asciiz "()(()))()"
da:.asciiz " corect"
nu:.asciiz " gresit"
.text
main:
la $t0, str      	#adresa
subu $sp, $sp, 4
sw $t0, 0($sp)

jal stiva
move $t0, $v0     #mut in $t0 valoarea returnata
addu $sp, $sp, 4    
la $a0, str     #afisez stringul analizat
li $v0, 4
syscall

beqz $t0, gresit    #daca valoarea returnata este 0 inseamna ca stringul este gresit
la $a0, da             #intra aici daca e corect
li $v0, 4
syscall
j final     #sar peste afisarea gresita

gresit:
la $a0, nu
li $v0, 4
syscall
final:
li $v0, 10
syscall

stiva:
subu $sp, $sp, 4
sw $fp, 0($sp)
addu $fp, $sp, 0

subu $sp, $sp, 4
sw $s0, 0($fp)

lw $s0, 4($fp)        #$s0 preia adresa stringului

li $t0, 0           #contorul
li $t1, '('         
li $t2, ')'

while: 
lb $t3, 0($s0)             #$t3 ia valorile din string                   
beqz $t3, terminat          #merg la eticheta "terminat" daca ajung la null
beq $t1, $t3, deschisa  
subi $t0, $t0, 1     		#scad contorul 
bltz $t0, stop      	  #verific daca devine negativ pt a pune capat ciclului
j continua

deschisa:
addi $t0, $t0, 1       #cresc contorul
continua:
addi $s0, $s0, 1    #continui sa ma plimb prin string chiar daca contorul creste/scade(exceptie: contorul devine negativ)
j while

stop:                  #ajunge aici in 2 cazuri: am ajuns la null sau contorul e negativ
terminat:                 
beqz $t0, sir_corect    #verific valoarea din contor, daca e 0 inseamna ca sirul este corect, returnez 1
li $t0, 0                                            # daca nu e 0, returnez 0 (sir gresit)
move $v0, $t0
j sir_verificat
sir_corect:
li $t0, 1
move $v0, $t0

sir_verificat:
lw $s0, -4($fp)      # restauram
lw $fp, 0($fp)
addu $sp, $sp, 8
jr $ra


















