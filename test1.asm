
; section .data
;     helloMessage db 'Hello, World!', 0xa

; section .text
;     global _main

; ; On macOS, the default entry point should be `_main`, not `_start`
; _main:
;     ; Write the helloMessage to STDOUT
;     ; mov eax, 4                ;   -> Bad system call: 12
;     ; mov rax, 0xfffff000       ;   -> Bad system call: 12
;     ; mov eax, 0xfffff000       ;   -> Bad system call: 12
;     ; mov eax, 0x02000004       ; works (32bit register works even in 64bit)
;     mov rax, 0x02000004         ; works (64bit)
;     mov ebx, 1
;     ; lea ecx, helloMessage
;     mov rsi, helloMessage
;     mov edx, 14
;     ; int 0x80
;     syscall

;     ; Exit the program
;     ; mov eax, 1                ; linux, `Bad system call: 12` on OSX
;     mov eax, 0x02000001         ; works (32bit register works even in 64bit)
;     xor ebx, ebx
;     ; int 0x80
;     syscall




; Rust helloworld: https://www.codeconvert.ai/rust-to-assembly-converter
; section .data
;     hello_msg db 'Hello, Rust on Macbook', 10, 0

; section .text
;     global _main

; _main:
;     mov rax, 0x02000004         ; syscall number for sys_write
;     mov rdi, 1                  ; file descriptor 1 is stdout
;     mov rsi, hello_msg          ; address of string to output
;     mov rdx, 23                 ; number of bytes
;     syscall                     ; call kernel

;     mov rax, 0x02000001         ; syscall number for sys_exit
;     xor rdi, rdi                ; status 0
;     syscall                     ; call kernel




section .data
    sys_write equ 0x02000004
	sys_read equ 0x02000003
	sys_exit equ 0x02000001
	stdin equ 0
	stdout equ 1
    hello_msg db 'Hello, Tứng hay ho', 10, 0
    hello_msg_len equ $ - hello_msg
    count_msg db 'Count: %d', 10, 0
    count_msg_len equ $ - count_msg

section .bss
    counter resb 1
    buffer resb 16 ; Buffer for formatting numbers

section .text
global _main

_main:
    ; Print initial message
    mov rdi, hello_msg
    call print_string

    ; Sleep for 100 milliseconds
    mov edi, 100
    call custom_sleep

    ; Initialize counter to 0
    mov byte [rel counter], 0

print_loop:
    ; Check if counter is greater than 10
    cmp byte [rel counter], 10
    jg end_loop

    ; Print count message
    mov rdi, count_msg
    mov rsi, [rel counter]
    call print_formatted

    ; Sleep for 100 milliseconds (does nothing, since not implemented)
    mov edi, 100
    call custom_sleep

    ; Increment counter
    inc byte [rel counter]

    ; Loop back
    jmp print_loop

end_loop:
    ; Exit the program
    mov eax, sys_exit   ; syscall number for sys_exit
    xor edi, edi    ; exit code 0 (set edi register to zero)
    syscall

print_string:
    ; Print a null-terminated string
    ; ; mov eax, 1      ; syscall number for write
    ; mov ebx, 1      ; file descriptor 1 is stdout
    ; mov edx, 100    ; length of the string
    ; mov eax, 0x02000004      ; syscall number for sys_write
    ; ; int 0x80
    ; syscall
    ; ret
    mov rax, sys_write          ; syscall number for sys_write
    mov rdi, 1                  ; file descriptor 1 is stdout
    mov rsi, hello_msg          ; address of string to output
    mov rdx, hello_msg_len      ; number of bytes
    syscall                     ; call kernel

print_formatted:
    ; Print formatted string with a single integer argument
    ; mov eax, 1      ; syscall number for write
    mov ebx, 1      ; file descriptor 1 is stdout
    mov edx, 100    ; length of the string
    mov eax, 0x02000004      ; syscall number for sys_write
    ; int 0x80
    syscall
    ; ret

custom_sleep:
    ; Implement your own sleep function
    ; This is just a placeholder and might not be accurate
    ret




; nasm -fmacho64 test1.asm
; ld test1.o -o test1 -no_pie -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem 


; 32-bit
; nasm -felf32 test1.asm
; gcc -o test1 -m32 test1.o
