#programmi che potrei fare:
#- fibonacci
#- 

    .data 0x10010000
val: .byte 0x2e

#s2, s3 registri usati per salvare i valori
#s0 registro di quanti valori calcolare
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

loop: beq $s1, $0, fine


xor $t0, $s3, $0

addu $s3, $s2, $s3
xor $s2, $t0, $0

ble $s3, $s2, ovf

#ow: xor, and, bne

addiu $s1, $s1, -1

j loop

fine: j fine

ovf: j ovf
