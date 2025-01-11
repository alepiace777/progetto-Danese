#ordinamento decrescente
#ora come ora non funziona/ish

    .data 0x10010000
dati: .word 0x5, 0x1, 0x34, 0x39, 0x22, 0x7
area: .space 200

    .text 0x400400
.globl __start
__start: la $s0, dati
lw $s1, 0($s0)

addi $s0, $s0, 4
la $s7, area


xor $a0, $s0, $0
xor $a1, $s1, $0

jal copia

xor $a0, $s0, $0
#a1 numero dati
xor $a1, $s1, $0

jal ordina

fine: j fine

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

ordina: sll $t0, $a1, 2
add $t0, $s7, $t0 #$s7 usato solo in lettura (non salvo)
#in $t0 salvo l'indirizzo di dove inserire
#(l'ultimo valore) mentre a0 tiene la base corrente

lw $t1, 0($a0)
#t2 indirizzo fetch
xor $t2, a0, $0
fetch: lw $t2, 4($t2)
#confronto
bgt $t1, $t2, poi
add $t1, $t2, $0
poi: addi $a1, $a1, -1 #decremento del contatore
addi $a0, $a0, 4 #incremento per il fetch

bne $a1, $0, fetch

sw $t1, 0($t0)

addi $t0, $t0, -4

jr $ra
