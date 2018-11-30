; store new 9th interrupt handler at 0000:0204
; store the old entry address of 9th interrupt handler at 0000:0200
; function of the new handler: pushing F1 button will change 
; the color setting of whole dosbox screen

assume cs:code

stack segment
	db 128 dup (0)
stack ends

code segment
start:  mov ax, stack
	mov ss, ax
	mov sp, 128

	push cs
	pop ds
	mov si, offset int9
	mov ax, 0
	mov es, ax
	mov di, 204h
	mov cx, offset int9end - offset int9
	cld
	rep movsb

	push word ptr es:[9*4]
	pop word ptr es:[200h]
	push word ptr es:[9*4+2]
	pop word ptr es:[202h]

	cli
	mov word ptr es:[9*4], 204h
	mov word ptr es:[9*4+2], 0
	sti

	mov ax, 4c00h
	int 21h

  int9:	;push F1 button to change the color setting of whole
	;dosbox screen
	
	push ax
	push bx
	push cx
	push es
	push di

	in al, 60h

	pushf
	pushf
	pop bx
	and bh, 11111100b
	push bx
	popf
	mov bx, 0
	mov es, bx
	call dword ptr es:[200h]

	cmp al, 3bh  ;pushing F1 button will produce scan code 3bh
	jne int9ret
	
	mov ax, 0b800h
	mov es, ax
	mov di, 1
    	mov cx, 2000
    s:  inc byte ptr es:[di]
	add di, 2
	loop s

int9ret:
	pop di
	pop es
	pop cx
	pop bx
	pop ax

	iret

int9end: nop

code ends

end start


