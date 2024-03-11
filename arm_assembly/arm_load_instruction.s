// This program loads a value from a memory address into a register and then prints it out. Assume that the memory address contains the value we want to print.

.global start

start:
    LDR R1, =my_data      @ Load the memory address of my_data into R1
    LDR R0, [R1]          @ Load the value from the memory address in R1 into R0
    MOV R7, #4            @ Prepare to make a system call (print string)
    MOV R1, R0            @ Move the value we loaded into R0 to R1 (argument for printing)
    MOV R2, #1            @ Specify STDOUT file descriptor
    SVC 0                 @ Call kernel to perform system call
    MOV R7, #1            @ Prepare to make another system call (exit)
    MOV R0, #0            @ Specify exit status
    SVC 0                 @ Call kernel to perform system call

.data
my_data:
    .word 42               @ Define a word (32-bit) of memory containing the value 42


@ Note: the hexadecimal for 42(decimal) is 2A