; ----------------------------------------------------------------------------------------
; TcpListener using only system calls with NASM. Runs on 64-bit macOS only. 
; Target: x86_64-apple-darwin21.6.0
; To assemble and run:
;
;     Assemble&Run(macOS 11+):  $ nasm -fmacho64 tcplistener.asm
;                               $ ld tcplistener.o -o tcplistener -no_pie -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem 
;
; Learn more about macOS syscall: https://opensource.apple.com/source/xnu/xnu-792/bsd/sys/syscall.h.auto.html
; ----------------------------------------------------------------------------------------

section .bss
    server_address resb 16  ; Assuming a typical size for sockaddr_in structure
    client_address resb 16  ; Assuming client address is the same size

section .text
    global _main

_main:
    ; Print "Listening on localhost:xxxx"
    ; mov rax, 1           ; syscall number for write
    mov rax, 0x02000004 ; syscall number for write() on macOS
    mov rdi, 1           ; File descriptor (stdout)
    lea rsi, [rel listen_msg] ; Pointer to the message to output
    mov rdx, listen_msg_len  ; Length of the message
    syscall

    ; Create socket
    ; mov rax, 1          ; syscall number for socket()
    mov rax, 0x02000002  ; syscall number for socket() on macOS
    mov rdi, 2          ; AF_INET (IPv4)
    mov rsi, 1          ; SOCK_STREAM (TCP)
    mov rdx, 0          ; Protocol (0 for default protocol)
    syscall

    ; Bind to an address and port
    mov rdi, rax        ; Socket file descriptor
    lea rsi, [rel server_address]  ; Pointer to sockaddr_in structure (RIP-relative since 64bit does not support 32-bit absolute addresses)
    mov rdx, 16         ; Size of sockaddr_in structure
    ; mov rax, 49         ; syscall number for bind()
    mov rax, 0x0200000D  ; syscall number for bind() on macOS
    syscall

    ; Listen for incoming connections
    mov rdi, 1          ; Socket file descriptor
    mov rsi, 10         ; Backlog for pending connections
    ; mov rax, 50         ; syscall number for listen()
    mov rax, 0x0200000C  ; syscall number for listen() on macOS
    syscall

    ; Accept incoming connections
    lea rdi, [rel client_address]  ; Pointer to sockaddr_in structure (RIP-relative since 64bit does not support 32-bit absolute addresses)
    mov rsi, 16         ; Size of sockaddr_in structure
    ; mov rax, 43         ; syscall number for accept()
    mov rax, 0x0200000E  ; syscall number for accept() on macOS
    syscall

    ; Now you can send and receive data on rax (client socket)

    ; Clean up
    mov rdi, rax        ; Socket file descriptor
    ; mov rax, 3          ; syscall number for close()
    mov rax, 0x02000002  ; syscall number for close() on macOS
    syscall

    ; Exit
    ; mov rax, 60         ; syscall number for exit()
    mov rax, 0x02000001  ; syscall number for exit() on macOS
    xor rdi, rdi        ; Exit code 0
    syscall

section .data
    listen_msg db "Listening on localhost:8080", 10
    listen_msg_len equ $ - listen_msg

; nasm -fmacho64 tcplistener.asm
; ld tcplistener.o -o tcplistener -no_pie -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem 