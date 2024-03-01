; https://stackoverflow.com/questions/51324198/x86-assembly-error-in-mac-osx
section .text
   global _main     ;must be declared for linker (ld)

_main:              ;tells linker entry point
   mov  edx,len     ;message length
;    mov  ecx,msg     ;message to write
   lea     rsi, [rel msg]
   mov  ebx,1       ;file descriptor (stdout)
;    mov  eax,4       ;system call number (sys_write) (Linux)
   mov eax, 0x2000004
;    int  0x80        ;call kernel (Linux)
   syscall

;    mov  eax,1       ;system call number (sys_exit) (Linux)
   mov eax, 0x2000001
;    int  0x80        ;call kernel (Linux)
   syscall

section .data
msg db 'Hello, world!', 0xa  ;string to be printed
len equ $ - msg     ;length of the string

; nasm -f macho64 clangasm1.s && gcc -o clangasm1 clangasm1.o && ./clangasm1