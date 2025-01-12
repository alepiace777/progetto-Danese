#ordinamento decrescente
#ora come ora funziona/ish

    .data 0x10010000
dati: .word 0x8, 0x2, 0x1, 0x39, 0x22, 0x7, 0x45, 0x3, 0x21
area: .space 200

    .text 0x400000
.globl __start
__start: la $s0, dati
lw $s1, 0($s0)

addi $s0, $s0, 4
la $s7, area


xor $a0, $s0, $0
xor $a1, $s1, $0

jal copia

#a1 numero dati
xor $a1, $s1, $0#bp
addi $a0, $s1, -1

jal ordina

j fine

################
copia:
xor $t0, $a0 , $0
xor $t1, $s7, $0
xor $t2, $a1, $0

loop: lw $t3, 0($t0)
sw $t3, 0($t1)

addi $t0, $t0, 4
addi $t1, $t1, 4

addi $t2, $t2, -1
bne $t2, $0, loop

jr $ra
#fine copiatura dati
################

################
ordina:
#$t0 indirizzo salvataggio dati
sll $t0, $a1, 2
addiu $t0, $t0, -4
add $t0, $s7, $t0

#t3 contatore complessivo
xor $t3, $a1, $0

loop_fetch:
#t1 indirizzo caricamento dati
xor $t1, $s7, $0

# contatore per il confronto su t2
xor $t2, $a0, $0


# t4, t5 valori da confrontare

#carico i due valori e li confronto, tengo il maggiore e mi segno che numero ha facendo a1 - ctrftc
#carico un altro valore e continuo così
lw $t4, 0($s7)
li $t6, 0
cnfr: lw $t5, 4($t1)
#confronto
bgt $t4, $t5, poi
xor $t4, $t5, $0
#t6 contatore rimpiazzo
subu $t6, $t3, $t2
#aggiorno contatore e posizione memoria
poi: addiu $t2, $t2, -1
addiu $t1, $t1, 4

bne $t2, $0, cnfr

#salvataggio valori (ultimo e rimpiazzo)
subu $t2, $a1, $t3
sll $t2, $t2, 2
#t2 valore aggiornato della quantità da sottrarre
subu $t7, $t0, $t2

sw $t4, 0($t7)

#t7 altro valore di memoria
sll $t6, $t6, 2
addu $t7, $s7, $t6
sw $t5, 0($t7)

addiu $t3, $t3, -1
addiu $a0, $a0, -1

bne $a0, $0, loop_fetch

jr $ra
################

fine: j fine
