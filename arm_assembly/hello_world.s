@ ARM assembly for hello_world program

.global _start

_start:
    mov r7, #4          @ setup write (4)
    mov r0, #1          @ 1 = stdout
    ldr r1, =hello      @ address of hello world string
    mov r2, #13         @ length = 13
    svc 0

    mov r7, #1          @ setup system call exit (1)
    mov r0, #0          @ param 1 - 0 = normal exit
    svc 0               @ ask Linux to terminate program

.data
hello:      .ascii      "Hello World!\n"

// To Assemble & Run:
// $ as -o hello_world.o hello_world.s
// $ chmod +x ./hello_world.o       (if Linux denies permission for linker step)
// $ ld -o hello_world hello_world.o
// $ ./hello_world
// => which will prints:    Hello World!å