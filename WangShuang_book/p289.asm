assume cs:code

stack segment
	db 128 dup (0)
stack ends

code segment
     a	dw 23501, 2, 3, 4, 5, 6, 7, 8
     b	dd 0

start:	; add up all numbers at a, store result at b
	mov si, 0
	mov cx, 8
    s:	mov ax, a[si]
	add word ptr b[0], ax
	adc word ptr b[2], 0
	add si, 2
	loop s

	; transform the sum to decimal digit chars that are stored on the stack
	mov cx, 0  ;count number of digits
	mov ax, word ptr b[0]
	mov dx, word ptr b[2]
   s0:	mov bx, 10
	call divdw
	add bx, 30h
	push bx
	inc cx
	cmp ax, 0
	jne s0
	cmp dx, 0
	jne s0
	
	;display the decimal digit chars on the dosbox screen
	;(cx)=number of digits
	mov ax, 0b800h
	mov es, ax
	mov di, 160*12+40*2
   s1:	pop es:[di]
	mov byte ptr es:[di+1], 10011100b
	add di, 2
	loop s1

	mov ax, 4c00h
	int 21h

divdw:	;description: divide without overflow
	;params: (dx)*65536+(ax)=dividend, (bx)=divisor
	;return: (dx)*65536+(ax)=quotient, (bx)=remainder
	;algorithm: int(x/y)=quotient of x/y, rem(x/y)=remainder of x/y
	;   ((dx)*65536+(ax))/(bx) = int(dx/bx)*65536 + (rem(dx/bx)*65536+ax)/bx
	
	push cx

	mov cx, ax
	mov ax, dx
	mov dx, 0
	div bx
	push ax  ; (ax)=int(dx/bx)
	mov ax, cx
	div bx
	mov bx, dx
	pop dx

	pop cx

	ret
	
code ends

end start



