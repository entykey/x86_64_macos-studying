/*
for (int i = 0; i < 10; i++)
  a[i] = b[i] + c[i]
*/

.global _start
_start:
	// set times to loop to r3 (n)
	//mov r3,#0x2700
	mov r3, #4
	//orr r3,#0x0010
top:
	ldr r1,[r9],#4
	ldr r2,[r10],#4
	add r1,r1,r2
	str r1,[r8],#4
	
	// r3 = r3 - 1
	subs r3,#1
	bne top
	



// next: branching example:
// https://www.cs.cornell.edu/~tomf/notes/cps104/twoscomp.html
// https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/condition-codes-1-condition-flags-and-codes
; .global _start
; _start:
; 	mov r0, #2
; 	mov r1, #4
; 	cmp r0, r1
	
; 	blt addR2
; 	bal exit
; addR2:
; 	add r2, #1
; exit:
; 	mov r7, #0x1
; 	mov r0, #65
; 	swi 0




; .global _start
; _start:
; 	mov r0, #2
; 	mov r1, #4
; 	cmp r0, r1
	
; 	blt addR2
; 	bal exit
; addR2:
; 	add r2, #1
; exit:
; 	mov r7, #0x1
; 	//svc 0	// replace the above line with this sycall line will make the program infinite loop of addR2
; 	mov r0, #65
; 	swi 0
	



.global _start

_start:
    // Initialize counter to 0
    mov r0, #0

    // Loop to increment the counter
    loop_start:
        // Increment counter
        add r0, r0, #1

        // Compare counter with 10
        cmp r0, #10
        // If counter < 10, branch back to loop_start
        blt loop_start

        // Print the final value (replace this with your print code)
        // For simplicity, this example just uses swi to exit the program with the counter value
        mov r7, #0x1  // Exit system call number
        mov r0, r0    // Set the exit code to the counter value
        swi 0         // Invoke the system call

        // End of the program

// equivalent Rust program:
; fn main() {
;     let mut counter: i32 = 0;

;     // Loop to increment the counter
;     while counter < 10 {
;         counter += 1;
;     }

;     // Print the final value
;     println!("Final Counter Value: {}", counter);
; }



// https://armasm.com/docs/branches-and-conditionals/hello-world-revisited/
.macro      nullwrite       outstr
    @ Find length of string 
    ldr     r0, =\outstr        @ load outstring address
    mov     r1, r0              @ copy address for len calc later 
1:
    ldrb    r2, [r1]            @ load first char 
    cmp     r2, #0              @ check to see if we have a null char 
    beq     2f  
    add     r1, #1              @ Increment search address 
    b       1b                  @ go back to beginning of loop     
2:
    sub     r3, r1, r0          @ calculate string length 
    
    @ Setup write syscall 
    mov     r7, #4              @ 4 = write 
    mov     r0, #1              @ 1 = stdout 
    ldr     r1, =\outstr        @ outstr address 
    mov     r2, r3              @ load length 
    svc     0 
.endm 


//.include "write.s" 

.global _start

_start:
    @ Write hello world 
    nullwrite   hello
    
    @ setup exit syscall 
    mov     r7, #1      @ 1 = exit 
    mov     r0, #0      @ 0 = no error 
    svc     0

.data 
hello:      .asciz      "Hello World!\n"