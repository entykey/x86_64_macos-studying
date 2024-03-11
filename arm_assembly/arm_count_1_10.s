; .global main

; main:
;     MOV R0, #1       @ Initialize the counter register R0 to 1 (0x1)

; loop:
;     @ Add a condition to exit the loop if the counter reaches a certain value
;     CMP R0, #10      @ Compare the counter with 10 (0xA)
;     BEQ end_loop     @ Branch to end_loop if they are equal

;     @ Increment the counter by 1 (0x1)
;     ADD R0, R0, #1   

;     @ Add some delay or other operations here if needed...

;     B loop           @ Branch back to the beginning of the loop

; end_loop:
;     @ Loop ends here

;     MOV R7, #1       @ Prepare to make a system call (exit)
;     MOV R0, #0       @ Specify exit status
;     SVC 0            @ Call kernel to perform system call




// from r0 = 1, loop til r0 = 4
.global main

main:
    MOV R0, #1       @ Initialize the counter register R0 to 1

loop:
    @ Print the counter value (You can replace this with any operation needed)
    @MOV R7, #4       @ Prepare to make a system call (print)
    @MOV R1, R0       @ Move the value of the counter to R1 (argument for printing)
    @MOV R2, #1       @ Specify STDOUT file descriptor
    @MOV R3, #1       @ Specify the length of the string (1 character)
    @MOV R0, #1       @ Specify the system call number for write
    @SVC 0            @ Call kernel to perform system call

    @ Increment the counter by 1
    ADD R0, R0, #1

    @ Check if the counter has reached 4
    MOV R1, #4      @ Load the value 4 into R1
    SUBS R2, R0, R1  @ Subtract R1 from R0 and update condition flags
    BNE loop         @ Branch back to loop if the result is not zero

    @ If the counter has reached 4, exit the program
    MOV R7, #1       @ Prepare to make a system call (exit)
    MOV R0, #0       @ Specify exit status
    SVC 0            @ Call kernel to perform system call

