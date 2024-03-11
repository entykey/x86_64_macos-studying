.global main

main:
    MOV R0, #0       @ Initialize the counter register R0 to 0

loop:
    ADD R0, R0, #1   @ Increment the counter by 1

    @ Add a condition to exit the loop if the counter reaches a certain value
    CMP R0, #10      @ Compare the counter with 10
    BEQ end_loop     @ Branch to end_loop if they are equal

    @ Add some delay or other operations here if needed

    B loop           @ Branch back to the beginning of the loop

end_loop:
    @ Loop ends here

    MOV R7, #1       @ Prepare to make a system call (exit)
    MOV R0, #0       @ Specify exit status
    SVC 0            @ Call kernel to perform system call
