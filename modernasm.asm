; https://bryceautomation.com/index.php/2022/12/26/hello-world-in-modern-assembly/
; https://docs.huihoo.com/redhat/rhel-4-docs/rhel-as-en-4/index.html
; global _main
; _main:
; 		mov	$1, %eax	# System Call to Write
; 		mov	$1, %edi	# Write to screen (stdout)
; 					# Sends output to Terminal
; 		mov	$mystring, %esi # Address of String to send
; 		mov	$13, %edx  	# String Length (bytes)
; 		syscall

;     		#Exit
;                 mov $0, %rdi
; 		mov $60, %rax
; 		syscall

; this asm code use AT&T or GAS syntax: https://stackoverflow.com/questions/9196655/what-do-the-dollar-and-percentage-signs-represent-in-x86-assembly

; nasm -f macho64 modernasm.asm && gcc -o modernasm modernasm.o && ./modernasm
; nasm -f elf modernasm.asm && gcc -o modernasm modernasm.o && ./modernasm


; NASM syntax (64bit as default for macOS):
section .data
    mystring db 'Hello, NASM!', 0

section .text
    global _start

_start:
    ; Write to screen
    mov eax, 4         ; System Call to Write
    mov edi, 1         ; Write to screen (stdout)
    mov rsi, mystring  ; Address of String to send
    mov edx, 13        ; String Length (bytes)
    syscall            ; Invoke syscall

    ; Exit
    mov eax, 1         ; System Call to Exit
    xor rdi, rdi       ; Exit code 0
    syscall            ; Invoke syscall


; nasm -f macho -o modernasm.o modernasm.asm
; gcc -m32 -o modernasm modernasm.o
; ld modernasm.o -o modernasm -no_pie -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem 
; ./modernasm
