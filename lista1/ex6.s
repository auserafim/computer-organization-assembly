.data

.text 
	.globl _start
_start:
	li a0, 2147483647
	jal verifica
	li a7, 1
	ecall 
	j exit
verifica:
	li t2, -2147483648 # se for o menor negativo
	bne a0, t2, go
	li a0, 1 # retorna par 
	jr ra
	go:
	bgt a0, zero, positivo
	li t2, -1 
	mul a0, a0, t2 # se for negativo, converte para positivo e opera 
	positivo:
	andi a0, a0, 1 # andi bit a bit para averiguar bit de menos significativo eh zero ou um 
	xori a0, a0, 1 # se for par, retorna 1. Impar retorna zero 
	jr ra 
exit:
	li a7, 93
	li a0, 0 #retorna zero
	ecall