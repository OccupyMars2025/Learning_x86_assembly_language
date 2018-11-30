;store a new 9th interrupt handler, in doxbox, press 'A' button, once 
;'A' button is released, whole-screen 'A' are displayed 
; new handler will be stored at 0000:0204
;old entry address of 9th interrupt handler will be stored at 0000:0200

assume cs:code

stack segment
	db 128 dup (0)
stack ends

code segment
start:	mov ax, stack
	mov ss, ax
	mov sp, 128
	
	; store new 9th interrupt handler at 0000:0204
	push cs
	pop ds
	mov si, offset int9
	mov ax, 0
	mov es, ax
	mov di, 204h
	mov cx, offset int9end - offset int9
	cld
	rep movsb

	; store entry address of original 9th interrupt handler
	mov ax, 0
	mov es, ax
	push es:[9*4]
	pop es:[200h]
	push es:[9*4+2]
	pop es:[202h]

	;modify the old entry address to the new one
	cli
	mov word ptr es:[9*4], 200h
	mov word ptr es:[9*4+2], 0
	sti
	
	; end of main program
	mov ax, 4c00h
	int 21h

 int9:	; new 9th interrupt handler
	; description: press 'A' button, when it is released, the 
	; screen will be full of 'A'
	; params: none
	; return: none

	push.....

	in al, 60h

	pushf
	pushf
	pop bx
	and bh, 11111100b
	push bx
	popf
	mov bx, 
	call dword ptr 

code ends

end start










