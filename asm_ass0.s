section .data                    	; data section, read-write
        an:    DQ 0              	; this is a temporary var

section .text                    	; our code is always in the .text section
        global do_Str          	    ; makes the function appear in global scope
        extern printf            	; tell linker that printf is defined elsewhere 							; (not used in the program)

do_Str:                        	    ; functions are defined as labels
        push    rbp              	; save Base Pointer (bp) original value
        mov     rbp, rsp         	; use base pointer to access stack contents
        mov rcx, rdi			    ; get function argument

;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE STARTS HERE ;;;;;;;;;;;;;;;; 

	mov	qword [an], 0		; initialize answer
	label_here:

                isLower:
                        mov al, [rcx]
                        cmp al, 'a'
                        jb isHigher
                        cmp al, 'z'
                        ja isHigher
                        sub al, 0x20
                        jmp finally

                isHigher:
                        cmp al, 'A'
                        jb next
                        cmp al, 'Z'
                        ja next
                        jmp finally

                next:
                        inc qword [an]
                        cmp al, '('
                        jnz continue
                        mov al, '<'
                        jmp finally

                continue:
                        cmp al, ')'
                        jnz finally
                        mov al, '>'

                finally:
                        mov [rcx], al
                        inc rcx      	    ; increment pointer
                        cmp byte [rcx], 0   ; check if byte pointed to is zero
                        jnz label_here      ; keep looping until it is null terminated


;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE ENDS HERE ;;;;;;;;;;;;;;;; 

         mov     rax,[an]         ; return an (returned values are in rax)
         mov     rsp, rbp
         pop     rbp
         ret 
		 