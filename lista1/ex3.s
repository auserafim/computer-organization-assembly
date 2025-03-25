.data
string: .asciz "! DLROW OLLEH"
stringCopiada: .space 100
.text 
	.globl _start
_start:
	 la a0, string # string a ser copiada  
	 jal strcpy
	 # printar resultado
	 la a1, stringCopiada  # argumento da write (retorno da funcao)
	 li a0, 1           # stdout
	 li a2, 100        # quantos bytes escrever    
	 li a7, 64          # sycall write  
	 ecall                
	 j exit
strcpy:
	 addi sp, sp, -4
	 sw s0, 0(sp)         # como vou usar s0, empilho ele antes 
         mv s0, zero          # contador de quantos bytes foram escritos 
         mv t5, a0    	      # endereço da string para copiar 
         la t4, stringCopiada # string a ser copiada  
         addi t4, t4, 99       # vai para a primeira ultima posição da string 
         sb zero, 0(t4)       # coloca primeiro byte terminador de string
	while:
		lb t0, 0(t5)          # primeiro byte da string 
		beq t0, zero, retorno # se encontrou final da string original, para a execução
		addi t5, t5, 1        # avança com byte 
		addi t4, t4, -1       # regride um byte da string a ser copiada 
		sb t0, 0(t4)          # adiciona byte da string original na string a ser copiada
		addi s0, s0, 1        # soma de quantos bytes foram copiados 
 	 	j while 
	retorno: # retorna quantos bytes foram copiados
		mv a0, s0 # quantidade de bytes que foram copiados	
		# desempilha 
		lw s0, 0(sp)    # como vou usar s0, empilho ele antes 	
		addi sp, sp, 4  # separo espaço para um registrador
		jr ra 		# retorno
                                                     
exit:
	li a7, 93
	li a0, 0
	ecall