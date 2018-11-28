; store an interrupt handler at 0000:0200
; int 7ch: store 0000:0200 at 7ch

assume cs:code

code segment
start:  ; store the interrupt handler
	mov ax, cs  
	mov ds, ax
	mov si, offset capital
	mov ax, 0
	mov es, ax
	mov di, 0200h
	mov cx, offset capitalend - offset capital
	cld
	rep movsb

	;set interrupt vector table
	mov ax, 0
	mov es, ax
	mov word ptr es:[7ch*4], 0200h
	mov word ptr es:[7ch*4+2], 0

	mov ax, 4c00h
	int 21h

capital:; transform all lowercase letters of a string that ends with a 0 
	;  to uppercase letters
	;params: ds:si points to the string

	push cx
	push si

change:	mov cl, [si]
	mov ch, 0
	jcxz ok
	cmp cl, 97
	jb next
	cmp cl, 122
	ja next
	sub byte ptr [si], 32
 next:  inc si
        jmp short change

   ok:  pop si
	pop cx

	iret
	
capitalend: nop
	
code ends

end start
