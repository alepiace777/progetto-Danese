# descrizione programma: calcolatore della
# sequenza di Fibonacci a partire da un numero
# verifica l'overflow

    .data 0x10010000
val: .byte 0x4

data: .float 1.0
inf: .word 0x7f800000
#s2, s3 registri usati per salvare i valori
#s1 registro di quanti valori calcolare
#t0 salvo il valore di s3 di partenza, che poi
#andra` inserito in s2

#modificato in v.m.

    .text 0x400000
.globl __start
__start: la $s0, val
lbu $s1, 0($s0)
la $s4, data
beq $s1, $0, fine

li $s2, 1
l.s $f0, 0($s4)

la $s5, inf
lw $s6, 0($s5)
mtc1 $s6, $f3

beq $s1, $s2, fine
#li $s3, 1
l.s $f1, 0($s4)

addiu $s1, $s1 -2

#ciclo principale
loop: #beq $s1, $0, fine

    #xor $t0, $s3, $0
    mov.s $f2, $f1
    
    #addu $s3, $s2, $s3
    add.s $f1, $f0, $f1

    #nor $t2, $s3, $0
   
    ##bltu $t2, $s2, carry
    mov.s $f0, $f2
    
    c.eq.s $f1, $f3
    bc1t ovf

    addiu $s1, $s1, -1

j loop

fine: j fine

ovf: j ovf
