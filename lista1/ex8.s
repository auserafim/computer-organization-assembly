.data
	array: .word -12310, -76, 12511, 12, 0, 25
	tamanhoArray: .word 6 # 6 palavras
	string: .space 13 
.text 
	.globl _start
_start:
	la a0, array
	lw a1, tamanhoArray
	jal somaDeElementos
	
	la a1, string
	li a2, 13 # quantos bytes escrever 
	li a0, 1  # stdout
	li a7, 64 # sycall a ser chamada 
	ecall
	j exit 

	
somaDeElementos:	
	addi sp, sp, -8
	sw ra, 4(sp) # empilha ponto de retorno
	li t0, 0 	    # sentinela do loop
	li t1, 0            # acumulador de soma 
	loopSoma:
	beq a1, zero, chamaConverteInt # se varreu todo o array, para de somar
	slli t3, t0, 2        # multiplica i por 4 e adiciona como offset
	add t3, a0, t3 	      # base + offset
	lw t2, 0(t3) 	      # pego elemento do array
	add t1, t1, t2        # acumulo valor da soma
	addi a1, a1, -1	      # tamanhoArray -= 1
	addi t0, t0, 1	      # i += 1 
	j loopSoma
	
	chamaConverteInt:
		mv a0, t1 # passa como argumento o valor da soma 
		jal converteInteiroEmString
		lw ra, 4(sp)
		addi sp, sp, 8 # desemplilha a pilha usada 
		jr ra
	
	
converteInteiroEmString:
	
	li t0, 10 # número a ser dividido
	la t1, string # string para copiar
	addi t1, t1, 12 # vai para ultima posicao da string
	sb zero, 0(t1)  # adiciona o terminador nulo na string
	# se for menor que zero, colocamos o valor de negativo
	bgez a0, while # se for positivo ja vai para o while
	# se for negativo
	# addi sp, sp, -4
	sw a0,0(sp)# guarda valor original de a0 (usado quando for negativo)
	li t6, -2147483648 # maior negativo possivel 
	beq a0, t6, tratamentoEspecial # se for menor inteiro negativo
	converteNegativo:
		li t5, -1 
		mul a0, a0, t5 # converte numero para positivo e daí opera normal  
	while:
		div t2, a0, t0  # quociente do numero
		rem t3, a0, t0  # resto do numero
		addi t1, t1, -1 # regride com a string para trás
		addi t3, t3, 48
		sb t3, 0(t1)    # guarda resto de tras para frente na string 
		mv a0, t2       # quociente agora que sera dividido
		beq a0, zero, retorno
		j while
	retorno: 
	lw a0,0(sp)
	# addi sp, sp, 4
	bgez a0, go
	addi t1, t1, -1 # regride com a string para trás
	addi t3, zero, 45
	sb t3, 0(t1)    # guarda resto de tras para frente na string 
	go:
		la a0, string
		jr ra 
 	tratamentoEspecial:	  
		li t2, 56 # 8
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)
		
		li t2, 52 # 4
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)
		
		li t2, 54 # 6
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)

		li t2, 51 # 3
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)
		
		li t2, 56 # 8
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)
				
		li t2, 52 # 4
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)
		
		li t2, 55 # 7
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)
		
		li t2, 52 # 4
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)
		
		li t2, 49 # 1
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)
		
		li t2, 50 # 2
		addi t1, t1, -1 # regride com a string para trás
		sb t2, 0(t1)
	       
	        j retorno
exit:
	li a7, 93
	li a0, 0
	ecall	

