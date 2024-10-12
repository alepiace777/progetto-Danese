# Prova del programma: vorrei leggere dei valori in codice gray,
# convertirli in binario, e poi sommare i numeri tra di loro,
# infine confrontare i due valori e dire quale dei due `e maggiore,
# se uno dei due `e maggiore

    .data 0x10010000
numeri: .integer 4 43 55 23 84 a5 ff 78 45


# per convertire da gray a binaro ricopio il primo bit e compio
# la xor tra il bit convertito precedentemente e quello in gray

    .text 0x400400
lbu $s0, numeri
addi $s1, $0, 8
lettura_val: lbu $s2, (numeri + $s1)

