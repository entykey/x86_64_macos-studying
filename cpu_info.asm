section .data
sys_write equ 4
sys_read equ 3
sys_exit equ 1
stdin equ 0
stdout equ 1
;string declarations
vendor_id db "Your Vendor id string is 'XXXXXXXXXXXX'",0x0A,0h
vLen equ $-vendor_id



fam dd "Family = %d ",0x0A,0x0
section .bss



section .text

global _main
extern printf
	_main:
	; get vendor id string
      ;  mov eax,0

       ; cpuid
       ; mov edi,vendor_id
       ; mov [edi+26],ebx
        ;mov [edi+30],edx
        ;mov [edi+34],ecx
        ;mov eax,sys_write
        ;mov ebx,stdout
        ;mov ecx,vendor_id
        ;mov edx,vLen
        ;int 0x80
       
	;cpu family
	push ebp
	mov ebp,esp
	sub esp,0x04
	mov eax,1
	cpuid ;call cpu instruction
	shr eax,0x08
	and eax,0x0F
	push eax
	push dword fam
	call printf
	int 0x80
	add esp,0x04
	mov esp,ebp
	pop ebp
	



	quit:
		mov eax,sys_exit
		mov ebx,0
		int 0x80

; nasm -fmacho64 cpu_info.asm
; ld cpu_info.o -o cpu_info -no_pie -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem 


; nasm -felf32 cpu_info.asm
; gcc -o cpu_info -m32 cpu_info.o