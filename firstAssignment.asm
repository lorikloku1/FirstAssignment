format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    num dw 3552
    divisor dw 10
    reservedNum dw 0
	isPalindrome dd 'yes', 0
	isNotPalindrome dd 'no', 0
section '.text' code readable executable
start:

    mov ax, [num]       
    xor dx, dx            
    mov bx, [divisor]      
    mov cx, [reservedNum]
	
start_loop:
    div bx    
	
	mov di, ax 
	mov ax, cx 
	mov si, dx 
	
	mul bx     
	add ax, si
	
	mov cx, ax
	mov ax, di
	
	cmp ax, 0
	jnz start_loop
	
	movzx eax, cx
	movzx   ebx, [num]
	cmp   eax, ebx
	jne   not_a_palindrome  
	mov   esi, isPalindrome 
    jmp   end_sec:
	
not_a_palindrome:

mov esi, isNotPalindrome

end_sec:

	call    print_str
    
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'