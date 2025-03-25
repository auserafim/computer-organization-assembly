.data 
msg: .asciz "Digite Algo:\n"
buffer: .word 0, 0, 0, 0
.text
	.globl _start
_start:
	# Escreve primeira mensagem 
	li a7, 64 
	li a0, 1
	la a1, msg
	li a2, 13
	ecall
 	# Lê do teclado 
 	li a7, 63     # read
 	li a0, 0      # descritor de arquivo
 	la a1, buffer # endereço do buffer
 	li a2, 11   # máximo de bytes para ler 
 	ecall 
 	
 	#li a7, 64 # write
	#li a0, 1
	#la a1, buffer
	#li a2, 13
	#ecall
	
	la a0, buffer # argumento para a função 
	jal converte 
	la a0, buffer
	lb t1, 0(a0) # se primeiro byte for negativo, adiciona
	li t0, 45
	li t2, -1
	bne t1, t0, exit
	mul s0, s0, t2
	j exit
	
converte:
	addi sp, sp, -8
	sw s0, 0(sp)
	sw ra, 4(sp)
	mv s0, a0 # s0 recebe valor base da string
	li t6, 0 # acumulador para ver quantos bytes há na string 
	lb t3, 0(s0) # primeiro byte da string
	li t0, 45 # sinal de negativo 
	li t5, 10 # line feed 
	bne t3, t0, quantosBytesLeu
	addi s0, s0, 1 # avança para o segundo byte, que eh o numero, pulando o sinal " - " 
	
	quantosBytesLeu:
		lb t3, 0(s0) # byte lido 
		beq t3, t5, potencia # se achou o line feed, para de capturar  
		addi s0, s0, 1  # avança byte a byte 
		addi t6, t6, 1 # quantidade de bytes lidos 
		j quantosBytesLeu
	potencia: 
		la s0, buffer
		li s1, 0
		li t2, 10

	loopByteAByte:
		lb t5, 0(s0)         # primeiro byte
		bne t5, t0, seForPositivo
		addi s0, s0, 1 # avança para o segundo byte, que eh o numero, pulando o sinal " - " 
		seForPositivo:
		beq t5 ,t2,doneLoop  # se achar o lineFeed de novo, realiza potencia 
		addi s0, s0, 1       # avaça para o proximo byte 
		addi t5, t5, -48     # transforma para inteiro
		mv a0, t5            # passo como base o primeiro byte transformado
		addi t6, t6, -1      # subtraio para formar a potencia 
		mv a1, t6            # segundo argumento - quantidade de bytes lidos
		jal funcao_potencia  # pula para função de soma 
		add s1, s1, a0       # acumulando a soma. no ultimo digito, somamos o ultimo digito com o resto da soma 
		j loopByteAByte
	doneLoop:
		lw s0, 0(sp)
		lw ra, 4(sp)
		addi sp, sp, 8
		jr ra
	
funcao_potencia:
	li t3, 10
	beq a1, zero, doneFuncaoPotencia 
	mul a0, a0, t3
	addi a1, a1, -1 # decrementa o expoente da potência a cada iteração
	j funcao_potencia
	doneFuncaoPotencia:
	jr ra
	
exit:
	li a7, 93
	li a0, 0
	ecall	
