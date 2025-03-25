.data
msg: .asciz "Esse Programa suporta strings de até 999 bytes (não nulos)"
valorFinal: .space 3
.text 
	.globl _start
_start:

 la s0, msg   # endenreço base da string
 li t0, 0     # acumulador da soma
 lb t1, 0(s0) # primeiro byte da string

while:
 	beq t1, zero, converte # se encontrou o zero da string, sai do loop
 	addi s0, s0, 1 	       # offset para o proximo byte 
 	addi t0, t0, 1         # adiciona um na soma 
 	lb t1, 0(s0)           # proximo byte 
 	j while
 	
converte:
	li t4, 10	   # 10 que será para dividir
	la t5, valorFinal  # string onde iremos escrever
	addi t5, t5, 3   # vai para o final da string
	sb zero, 0(t5)     # adiciona terminador nulo
whileConverte:
 	beq  t0, zero, print  # se quociente zero, para a divisão
	div  t1, t0, t4       # quociente da divisão
	rem  t2, t0, t4       # resto da divisão
	addi t2, t2, 48       # transfere para correspondente em ascii 
	addi  t5, t5, -1      # adiciona novo offset, voltando pra frente da palavra sempre
	sb t2, 0(t5)	      # guarda na posição livre
	add t0, zero, t1      # quociente passa a ser o novo numero a ser divido 
	j whileConverte	
	
print:
    	li t2, 0
	la a1, valorFinal  # argumento da write  
	li a0, 1           # stdout
	li a2, 4           # quantos bytes escrever    
	li a7, 64          # sycall write  
	ecall 
	                                                                                  
exit:
	li a7, 93
	li a0, 0
	ecall