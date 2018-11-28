assume cs:code

code segment
start:  mov ax, cs
	mov ds, ax
	mov si, offset sqr ; ds:si points to source address

	mov ax, 0
	mov es, ax
	mov di, 0200h  ; es:di points to the destination address

	cld  ; set df flag to 0
	mov cx, offset sqrend - offset sqr
	rep movsb

	; set interrupt vector table at 7ch
	mov ax, 0	
	mov es, ax
	mov word ptr es:[7ch*4], 0200h
	mov word ptr es:[7ch*4+2], 0

	mov ax, 4c00h
	int 21h

  sqr:  mul ax   ; interrupt handler to be stored at 0000:0200
	iret
sqrend: nop

code ends

end start


