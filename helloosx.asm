; ----------------------------------------------------------------------------------------
; Source: https://cs.lmu.edu/~ray/notes/nasmtutorial/
; Writes "Hello, OSX" to the console using only system calls with NASM. Runs on 64-bit macOS only. 
; Target: x86_64-apple-darwin21.6.0
; To assemble and run:
;
;     Not working:          $ nasm -fmacho64 helloosx.asm && ld helloosx.o && ./a.out
;     Working(macOS 11+):   $ nasm -fmacho64 helloosx.asm
;                           $ ld helloosx.o -o helloosx -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem
;     Fix ERROR: ld: warning: PIE disabled. Absolute addressing (perhaps -mdynamic-no-pic) not allowed in code signed PIE, but used in _main from helloosx.o. To fix this warning, don't compile with -mdynamic-no-pic or link with -Wl,-no_pie:
;                           $ ld helloosx.o -o helloosx -no_pie -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem 
;
;     Learn more: https://stackoverflow.com/questions/52830484/nasm-cant-link-object-file-with-ld-on-macos-mojave
; ----------------------------------------------------------------------------------------

    global    _main

    section   .text
_main:    
    mov       rax, 0x02000004         ; system call for write
;   mov       rax, 1      => (It's Linux instruction) Compiled, but give "Bad system call: 12"
    mov       rdi, 1                  ; file handle 1 is stdout
    mov       rsi, message            ; address of string to output
    mov       rdx, message_len        ; number of bytes
    syscall                           ; invoke operating system to do the write
    mov       rax, 0x02000001         ; system call for exit
    xor       rdi, rdi                ; exit code 0
    syscall                           ; invoke operating system to exit

    section   .data
message:  
    db        "Hello Tứng hay ho, from OSX", 10, 10      ; note the newline at the end
message_len:
    equ $ - message
;   NOTE: insert `0ah` or `10` where you want the line to break.   (https://www.daniweb.com/programming/software-development/threads/396826/how-to-break-line-in-assembly-using-nasm)
;   Keep in mind that the `0ah` or `10` for newline is also considered 1 byte !