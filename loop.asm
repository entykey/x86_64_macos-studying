; ----------------------------------------------------------------------------------------
; Loop using only system calls with NASM. Runs on 64-bit macOS only. 
; Target: x86_64-apple-darwin21.6.0
; To assemble and run:
;
;     Assemble&Run(macOS 11+):  $ nasm -fmacho64 loop.asm
;                               $ ld loop.o -o loop -no_pie -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem 
;
; ----------------------------------------------------------------------------------------

; section .data
;     newline db 10          ; Newline character

; section .text
;     global _main

; _main:
;     mov ecx, 10            ; Set the loop count to 10

;     ; Loop to print "Count: 1", "Count: 2", ..., "Count: 10"
;     ; The loop counter is in the ecx register
;     loop_start:
;         ; Print "Count: "
;         mov rax, 0x02000004         ; System call number for write
;         mov rdi, 1                  ; File descriptor 1 is stdout
;         lea rsi, [rel count_str]    ; Pointer to the string
;         mov rdx, count_str_len      ; Length of the message
;         syscall                     ; Invoke system call

;         ; Print the current count (value in ecx) and a newline
;         mov rax, 0x02000004         ; System call number for write
;         mov rdi, 1                  ; File descriptor 1 is stdout
;         lea rsi, [rel count]        ; Pointer to the count variable
;         mov rdx, 1                  ; Length of the character
;         syscall                     ; Invoke system call

;         ; Print a newline character
;         mov rax, 0x02000004     ; System call number for write
;         mov rdi, 1              ; File descriptor 1 is stdout
;         lea rsi, [rel newline]  ; Pointer to the character
;         mov rdx, 1              ; Length of the character
;         syscall                 ; Invoke system call

;         ; Increment the loop counter and check for the end of the loop
;         inc dword [rel count]
;         cmp dword [rel count], 11
;         jge loop_end

;         ; Jump back to the start of the loop
;         jmp loop_start

;     loop_end:
;         ; Exit the program
;         mov rax, 0x02000001     ; System call number for exit
;         xor rdi, rdi            ; Exit code 0
;         syscall                 ; Invoke system call

; section .bss
;     count resd 1                ; Reserve space for the loop counter

; section .data
;     count_str db 'Count: ', 0
;     ; newline db 10               ; Newline character
;     count_str_len equ $ - count_str






;---------------------
; This asm code print '11111...' forever
;---------------------

; section	.text
;    global _main         ;must be declared for using gcc
	
; _main:	                ;tell linker entry point
;    mov ecx,10
;    mov rax, '1'
	
; l1:
;    mov [rel num], rax
;    mov rax, 0x02000004
;    mov ebx, 1
;    push rbx             ; must be used against 64-bit registers (like rbx)
	
;    lea rsi, [rel num]        
;    mov rdx, 1        
; ;    int 0x80
;    syscall
	
;    mov eax, [rel num]
; ;    sub eax, '0'
; ;    inc eax
; ;    add eax, '0'
;    cmp ecx, eax     ; if (ecx < eax) -> goto done
;    jb .done

;    pop rbx
;    loop l1

	
; .done:
;     mov rax, 0x02000001  ;system call number (sys_exit)
;     syscall              ; call kernel
; section	.bss
; num resb 1




;---------------------
; This asm code print '22222...' forever
;---------------------
section	.text
   global _main         ; must be declared for using gcc
	
_main:	                ; tell linker entry point
   mov ecx, 10
   mov rax, '2'
	
l1:
   mov [rel num], rax
   mov rax, 0x02000004
   mov ebx, 1
   push rbx             ; must be used against 64-bit registers (like rbx)
	
   lea rsi, [rel num]        
   mov rdx, 1        
;    int 0x80
   syscall
	
   mov eax, [rel num]
;    sub eax, '0'
;    inc eax
;    add eax, '0'
   cmp ecx, eax     ; if (ecx < eax) -> goto done
   jb .done

   pop rbx
   loop l1

	
.done:
    mov rax, 0x02000001  ;system call number (sys_exit)
    syscall              ; call kernel
section	.bss
num resb 1


; nasm -fmacho64 loop.asm
; ld loop.o -o loop -no_pie -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem 
;