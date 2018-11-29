; store 7ch interrupt handler at 0000:0200 which display a string

assume cs:code

code segment
start:  mov ax, cs
	mov ds, ax
	mov si, offset show
	mov ax, 0
	mov es, ax
	mov di, 0200h
	mov cx, offset showend - offset show
	cld
	rep movsb

	mov ax, 0
	mov es, ax
	mov word ptr es:[7ch*4], 0200h
	mov word ptr es:[7ch*4+2], 0

	mov ax, 4c00h
	int 21h

  show: ;params: (dh)=row number, (dl)=column number, (cl)=color
	;     ds:si points to the string which ends with a 0

	push ax
	push bx
	push cx
	push dx
	push es
	push ds
	push si
	push di
	
	mov ax, 0b800h
	mov es, ax
	mov al, 160
	mul dh
	mov di, ax
	mov al, 2
	mul dl
	add di, ax ;es:di points to where the string will be displayed

     s: mov al, [si]
	cmp al, 0
	je ok
	mov es:[di], al
	mov es:[di+1], cl
	inc si
	add di, 2
	jmp short s

  ok  : pop di
	pop si
	pop ds
	pop es
	pop dx
	pop cx
	pop bx
	pop ax

	iret

showend: nop

code ends

end start
