# Prova del programma: vorrei leggere dei valori in codice gray,
# convertirli in binario, e poi sommare i numeri tra di loro,
# infine confrontare i due valori e dire quale dei due `e maggiore,
# se uno dei due `e maggiore, e salvare se sono ci sono piú maggiori
# nella prima serie o nella seconda

    .data 0x10010000
    .word 0x4
numeri: .byte 43, 55, 23, 84, a5, ff, 78, 45


# per convertire da gray a binaro ricopio il primo bit e compio
# la xor tra il bit convertito precedentemente e quello in gray

    .text 0x400400
#s0 indirizzo dati, $s1 num elementi, $s2 valore1, $s3 valore2
#preimpostazione dati
addiu $s0, $0, 0x10010000
lw $s1, 0($s0)
addiu $s0, $s0, 4

#prelevamento dati effettivo
fetch: lbu $s2, 0($s0)
lbu $s3, 1($s0)
addi $s0, $s0, 2
subi $s1, $s1, 1

#conversione gray-binario, $s4 reg confronto bit, $s5 ctr
addi $s5, $0, 6
andi $s4, $s2, 10000000
shdx: 
