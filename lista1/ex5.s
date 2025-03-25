.data 
msg: .asciz "Digite Algo:\n"
buffer: .word 0, 0, 0, 0
.text
	.globl _start
_start:
	li a7, 64 # write
	li a0, 1
	la a1, msg
	li a2, 13
	ecall
 
 	li a7, 63 # read
 	li a0, 0  # descritor de arquivo
 	la a1, buffer # 
 	li a2, 1000 # maximo de bytes para ler 
 	ecall 
 	
 	li a7, 64 # write
	li a0, 1
	la a1, buffer
	li a2, 13
	ecall
	