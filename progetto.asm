# Prova del programma: vorrei leggere dei valori in codice gray,
# convertirli in binario,
# infine confrontare i due valori e dire quale dei due `e maggiore,
# se uno dei due `e maggiore, e salvare se sono ci sono piú maggiori
# nella prima serie o nella seconda
    
	.data 0x10010000
nval: .word 0x4
.byte 43, 55, 23, 84, 64, 35, 78, 45 #valori



# per convertire da gray a binaro ricopio il primo bit e svolgo
# la xor tra il bit convertito precedentemente e quello in gray

    .text #0x400400
#s0 indirizzo dati, $s1 num elementi (coppie), $s2 valore1, $s3 valore2
#preimpostazione dati
.globl __start
__start: la $s0, nval
lw $s1, 0($s0)
addiu $s0, $s0, 0x4

xor $s6, $0, $0 #preimposto i registri dei contatori dei valori maggiori
xor $s7, $0, $0

#prelevamento dati effettivo
fetch: lbu $s2, 0($s0)
lbu $s3, 1($s0)

xor $a0, $s2, $0
jal conv
xor $s4, $v0, $0 #s4 primo valore convertito

xor $a0, $s3, $0
jal conv
xor $s5, $v0, $0 #s5 secondo valore convertito

#registri magg prima serie $s6 magg seconda serie $s7
bge $s4, $s5, maggiore
addi $s7, $s7, 1
j uguale

maggiore: beq $s4, $s5, uguale
addi $s6, $s6, 1

uguale: addi $s0, $s0, 2
addi $s1, $s1, -1
bne $s1, $0, fetch

j fine

#conversione gray-binario, $s4 reg confronto bit, $t0 ctr, $t1, $t2 ctr annullamento, $t3 risultato
conv: andi $t3, $a0, 0x80

addi $t0, $0, -7 #valore di cifre, breakpoint
#sposto un bit a destra per effettuare il confronto e in seguito
#riporto tutto il valore a destra
remv: addi $t1, $0, 8
xor $t4, $a0 $0 #$t4 copia mod di $s2

##aggiungere la xor tra il bit precedente di t3
srl $t3, $t3, 1
xor $t4, $t4, $t3
sll $t3, $t3, 1

xor $t2, $t1, $0 #altro contatore per pulizia
#modifico il valore di $t1 per avere il numero di cifre
add $t1, $t1, $t0

sx: sll $t4, $t4, 1
#tolgo 1 a t0 fino a fargli raggiungere t1
addi $t1, $t1, -1
bne $t1, $0, sx

andi $t4, $t4, 0x80 #maschero con 10000000

add $t2, $t2, $t0

dx: srl $t4, $t4 1
addi $t2, $t2, -1
bne $t2, $0, dx

addi $t1, $t0, 1

#terminata la pulizia del bit, faccio una or con $t3 e $t4,
#perche non ho altri bit
or $t3, $t3, $t4

addi $t0, $t0, 1
bne $t0, $0, remv

xor $v0, $t3, $0

jr $ra
#fine sottoprogr.

fine: j fine
