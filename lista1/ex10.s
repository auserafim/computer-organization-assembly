.data 
# RESULTADO ESTA DO REGISTRADOr S0
.text
	.globl _start
_start:
	li a0, 10
	blt a0, zero, exitComErro # se for menor que zero, retorna zero
	jal funcaoFibonacci
	mv s0, t3 # resultado
	j exit
	
funcaoFibonacci:
	li t0, 1 # sentinela do laço 
	
	li t1, 0 # primeiro numero da sequencia de fibonacci
	li t2, 1 # segundo elemento da sequencia de fibonacci
	
	beq a0, t2, retorno1 # se for um, retorna um
	beq a0, zero, retorno1 # se for 0, retorna zero
	loop:
	beq t0, a0, retorno # se chegou no n-ésimo termo para de iterar
	add t3, t1, t2      # soma primeiros termos 
	add t1, zero, t2    # faz o primeiro virar o segundo
	add t2, zero, t3    # faz o segundo virar o atual 
	addi t0, t0, 1      # i += 1
	j loop
	
	retorno:
	jr ra
	retorno1:
	add t3, a0, zero # adiciona ao valor da soma o valor de a0, no caso 1 ou zero
	jr ra 
exit: 
	li a7, 93
	li a0, 0
	ecall
	
exitComErro:
	li a7, 93
	li a0, 1
	ecall
	