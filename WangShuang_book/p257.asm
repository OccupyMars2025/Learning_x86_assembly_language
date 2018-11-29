; store the interrupt handler (act as loop s) at 0000:0200
; int 7ch: set the 7ch location of the interrupt vector table as 0000:0200

assume cs:code

code segment 
start:  mov ax, cs
	mov ds, ax
	mov si, offset lp
	mov ax, 0
	mov es, ax
	mov di, 0200h
	mov cx, offset lpend - offset lp
	cld
	rep movsb

	mov ax, 0
	mov es, ax
	mov word ptr es:[7ch*4], 0200h
	mov word ptr es:[7ch*4+2], 0

	mov ax, 4c00h
	int 21h

	; act as loop  
   lp:  push bp

	mov bp, sp
	dec cx
	jcxz ok
	add ss:[bp+2], bx
  ok:   pop bp
	iret
lpend:  nop

code ends

end start







