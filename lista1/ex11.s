.data 
# RESULTADO ESTA DO REGISTRADOr S0
.text
	.globl _start
_start:
	li a0, 4
	blt a0, zero, exitComErro # se for menor que zero, retorna zero
	jal funcaoFibonacci
	mv s0, a0
	li a7, 1 # printar inteiro
	ecall
	j exit		
funcaoFibonacci:
        addi sp, sp, -12       # aloca 12 bytes na pilha
        sw ra, 0(sp)          # guarda ra
        sw a0, 4(sp)          # guarda n
        sw t0, 8(sp)          # guarda t0

        blez a0, retornoZero  # se n <= 0, retorna 0
        li t0, 1
        beq a0, t0, retornoUm   # se n == 1, retorna 1

        addi a0, a0, -1        # n = n - 1
        jal funcaoFibonacci    # fib(n-1)
        mv t0, a0              # salva fib(n-1) em t0

        lw a0, 4(sp)          # restaura n
        addi a0, a0, -2        # n = n - 2
        jal funcaoFibonacci    # fib(n-2)

        add a0, a0, t0         # fib(n-2) + fib(n-1)

        lw ra, 0(sp)          # restaura ra
        lw t0, 8(sp)          # restaura t0
        addi sp, sp, 12        # desaloca pilha
        jr ra

retornoZero:
        mv a0, zero
        lw ra, 0(sp)
        lw t0, 8(sp)
        addi sp, sp, 12
        jr ra

retornoUm:
        li a0, 1
        lw ra, 0(sp)
        lw t0, 8(sp)
        addi sp, sp, 12
        jr ra

exit:
        li a7, 93
        li a0, 0
        ecall

exitComErro:
        li a7, 93
        li a0, 1
        ecall
	
