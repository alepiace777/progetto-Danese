# descrizione programma: calcolatore della
# sequenza di Fibonacci a partire da un numero
# verifica l'overflow

    .data 0x10010000
val: .byte 0x2e

#s2, s3 registri usati per salvare i valori
#s1 registro di quanti valori calcolare
#t0 salvo il valore di s3 di partenza, che poi
#andra` inserito in s2

    .text 0x400000
.globl __start
__start: la $s0, val
lbu $s1, 0($s0)
beq $s1, $0, fine

li $s2, 1

beq $s1, $s2, fine
li $s3, 1

addiu $s1, $s1 -2

#ciclo principale
loop: beq $s1, $0, fine

    xor $t0, $s3, $0

    addu $s3, $s2, $s3

    ble $s3, $s2, ovf

    xor $s2, $t0, $0


    addiu $s1, $s1, -1

j loop

fine: j fine

ovf: j ovf
