; use 7ch interrupt handler to achieve the function of "jmp near ptr s"
; use (bx)=displacement as a passing parameter
; 7ch interrupt handler is stored at 0000:0200

assume cs:code

code segment
start:  mov ax, cs
	mov ds, ax
	mov si, offset myjmp
	mov ax, 0
	mov es, ax
	mov di, 0200h
	mov cx, offset myjmpend - offset myjmp
	cld    ; set df flag to 0
	rep movsb

	mov ax, 0
	mov es, ax
	mov word ptr es:[7ch*4], 0200h
	mov word ptr es:[7ch*4+2], 0

	mov ax, 4c00h
	int 21h

 myjmp: ; 7ch interrupt handler, will be stored at 0000:0200
	push bp

	mov bp, sp
	add ss:[bp+2], bx   ; modify ip
	
	pop bp
	iret
myjmpend: nop

code ends

end start



