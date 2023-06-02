format PE console
entry start

include 'win32a.inc'

section '.data' data readable writable
									    
									    
        phrase db 'Enter the %s: ',0    
        first db 'first number',0
        second db 'second number',0
        operator db 'arithetic operator',0
        result db 'The result is: %d',0
		point db ',',0					
									    
		notAllowed1 db 'Error: Division by 0 not allowed!', 0
		
        inputType1 db '%d',0			
		inputType2 db ' %c',0
		
        A dd ?							
        B dd ?
        C dd ?

section '.text' code readable executable

start:									
	cinvoke printf, phrase, first   	
	cinvoke scanf, inputType1, A		
										
	cinvoke printf, phrase, second
	cinvoke scanf, inputType1, B
	cinvoke printf, phrase, operator
	cinvoke scanf, inputType2, C	

	mov eax, [C]
	
	cmp eax, 43							
	jnz @notAdd							
		mov ecx, [A]
		add ecx, [B]
		cinvoke printf, result, ecx
		
	@notAdd:
	cmp eax, 45						
	jnz @notSub
		mov ecx, [A]
		sub ecx, [B]
		cinvoke printf, result, ecx
		
	@notSub:		
	cmp eax, 42							
	jnz @notMul
		mov ecx, [A]
		imul ecx, [B]					
		cinvoke printf, result, ecx
		
	@notMul: 
	cmp eax, 47 						
	jnz @notDiv
		cmp [B], 0						
		jnz @bNotZero
			cinvoke printf, notAllowed1	
			
		@bNotZero:
		mov eax, [A]					
		mov ecx, [B]					
		mov edx, 0						
		div ecx							
		
		mov [C], edx					

		cinvoke printf, result, eax 	
		cinvoke printf, point			

        mov ebx, 0					
        @loop:
                mov eax, [C]			
				imul eax, 10			
				mov edx, 0				
				idiv [B]					
				mov [C], edx			
                cinvoke printf, inputType1, eax 
                inc ebx				
        cmp ebx, 2                      
        jnz @loop		
		
	@notDiv:

	push 0
	call [ExitProcess]
	
@finish:
invoke getch    
invoke ExitProcess, 0

section '.idata' import data readable
library kernel,'kernel32.dll',\
msvcrt,'msvcrt.dll'

import kernel,\
ExitProcess,'ExitProcess'

import msvcrt,\							
printf,'printf',\						
scanf,'scanf',\
getch,'_getch'
