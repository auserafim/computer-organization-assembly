.data
.text 
	.globl _start
_start:

	li a0, -7  # possui 2 bits 1 
	li a1, 32 # qtd de vezes que vai interar
	jal verifica
	li a7, 1
	ecall
	j exit
	
verifica:
	andi t0, a0, 1    # faz and com 1 no bit menos significativo. se for 1, t0 vai guardar 1
	add t1, t1, t0    # acumulador de soma 
	srli a0, a0, 1    # deloca argumento um bit para direita 
	addi a1, a1, -1   # decrementa a quantidade de bits
	bnez a1, verifica # volta para o loop para ler os 32 bits 
	add a0, zero, t1  # acumulador de soma  
	jr ra  	
exit:
	li a7, 93
	li a0, 0
	ecall
	