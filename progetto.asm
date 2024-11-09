# Prova del programma: vorrei leggere dei valori in codice gray,
# convertirli in binario, e poi sommare i numeri tra di loro,
# infine confrontare i due valori e dire quale dei due `e maggiore,
# se uno dei due `e maggiore, e salvare se sono ci sono piú maggiori
# nella prima serie o nella seconda
    .text    
.globl __start
la $t7, __start
jr $t7

    .data 0x10010000
.word 0x4
numeri: .byte 43, 55, 23, 84, a5, ff, 78, 45
    


# per convertire da gray a binaro ricopio il primo bit e compio
# la xor tra il bit convertito precedentemente e quello in gray

    .text 0x400400
#s0 indirizzo dati, $s1 num elementi, $s2 valore1, $s3 valore2
#preimpostazione dati
__start: la $s0, 0x10010000
lw $s1, 0($s0)
addiu $s0, $s0, 0x4

#prelevamento dati effettivo
fetch: lbu $s2, 0($s0)
lbu $s3, 1($s0)
addi $s0, $s0, 2
addi $s1, $s1, -1

#conversione gray-binario, $s4 reg confronto bit, $t0 ctr, $t1, $t2 ctr annullamento, $t3 risultato

addi $t0, $0, 7
andi $s4, $s2, 0x80   #10000000
#sposto un bit a destra per effettuare il confronto e in seguito
#riporto tutto il valore a destra
remv: srl $s4, $s4, 1
addi $t1, $0, 9
#$t3 usato momentaneamente per mantenere il complemento di $t0
xori $t3, $t0, 0xff
addi $t1, $t3, 1
xori $t2, $t1, 0x0
sx: sll $s4, $s4, 1
addi $t1, $t1, -1
bne $t1, $0, sx

dx: srl $s4, $s4 1
addi $t2, $t2, -1
bne $t2, $0, dx

#terminata la pulizia del bit, faccio una or con $t3 e $s4
or $t3, $t3, $s4

addi $t0, $t0, -1
bne $t0, $0, remv

j fine

fine: j fine
