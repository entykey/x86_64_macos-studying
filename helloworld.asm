; https://onecompiler.com/assembly/422uwv5uu


section .data
; 	hello:     db 'Hello world!',10    ; 'Hello world!' plus a linefeed character
; 	helloLen:  equ $-hello             ; Length of the 'Hello world!' string

hello db  'Hello, world!',0xa   ;our dear string
helloLen equ $ - hello          ;length of our dear string

section .text
	global _start         ;must be declared for using gcc

; Tell the linker to put the entry point here:
_start:
; 	mov eax,4            ; The system call for write (sys_write)
; 	mov ebx,1            ; File descriptor 1 - standard output
; 	mov ecx,hello        ; Put the offset of hello in ecx
; 	mov edx,helloLen     ; helloLen is a constant, so we don't need to say
  
  
	
; 	int 0x80             ; Call the kernel
; 	mov eax,1            ; The system call for exit (sys_exit)
; 	mov ebx,0            ; Exit with return "code" of 0 (no error)
; 	int 80h;

; Write the string to stdout:
    mov edx,helloLen    ; message length
    mov ecx,hello       ; message to write
    mov ebx,1           ; file descriptor (stdout)
    mov eax,4           ; system call number (sys_write)
    int 0x80            ; call kernel

; Exit via the kernel:
    mov ebx,0   ;process' exit code
    mov eax,1   ;system call number (sys_exit)
    int 0x80    ;call kernel - this interrupt won't return

