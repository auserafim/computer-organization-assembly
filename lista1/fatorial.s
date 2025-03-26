.data
.text
    .globl _start

_start:
    li a0, 4          # Load n = 4
    jal factorial      # Call factorial function
    j exit            # Jump to exit

factorial:
    addi sp, sp, -16   # Allocate space on the stack (aligned)
    sw ra, 0(sp)       # Store the return address (ra) on the stack
    sw a0, 4(sp)       # Store the current value of a0 (n) on the stack

    li t0, 1           # t0 = 1 (base case comparison)
    ble a0, t0, base_case # If n <= 1, go to base case

    addi a0, a0, -1    # n = n - 1 (prepare for recursive call)
    jal factorial      # Recursive call: factorial(n - 1)

    lw t1, 4(sp)       # Restore the original value of n from the stack into t1
    lw ra, 0(sp)       # Restore the return address from the stack
    mul a0, t1, a0     # a0 = n * factorial(n - 1)
    addi sp, sp, 16    # Restore the stack pointer
    jr ra              # Return

base_case:
    li a0, 1           # Return 1 when n <= 1
    lw ra, 0(sp)       # Restore the return address
    addi sp, sp, 16    # Restore stack pointer (aligned)
    jr ra              # Return

exit: 
    li a7, 1
    ecall
    li a7, 93          # Exit system call
    li a0, 0           # Status 0
    ecall              # Exit
