; https://stackoverflow.com/questions/32469149/nasm-compiling-x86-64-asm-label-addresses-off-by-256-bytes-in-mach-o-when-using?rq=1
global _main

section .text
_main:
mov     rax, 0x2000004
mov     rdi, 1
lea     rsi, [rel msg]
mov     rdx, len
syscall

mov     rax, 0x2000001
mov     rdi, 0
syscall

section .data
msg:    db      "Hello, world!", 10
len:    equ     $ - msg


; nasm -f macho64 -o clangasm.o clangasm.s
; clang -o clangasm clangasm.o
; ./clangasm

; nasm -f macho64 clangasm.s && gcc -o clangasm clangasm.o && ./clangasm