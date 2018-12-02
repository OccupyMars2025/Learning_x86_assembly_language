assume cs:code

stack segment
	db 128 dup (0)
stack ends

code segment
     a: db 1, 2, 3, 4, 5, 6, 7, 208
     b:	dw 0

start:	;add up all numbers at a, store result at b
	mov si, offset a
	mov di, offset b
	mov cx, 8
    s:	mov al, cs:[si]
	mov ah, 0
	add cs:[di], ax
	inc si
	loop s
	
	;transform the sum to a string with a decimal representation
	; stored on the stack
	mov cx, 0  ;count number of digits
	mov ax, cs:[di]
	mov bx, 10 ;divisor
   s0:	mov dx, 0
	div bx
	add dx, 30H
	push dx	
	inc cx
	cmp ax, 0
	jne s0


	;display the sum on the dosbox screen with a decimal 
	;representation
	mov ax, 0b800h
	mov es, ax
	mov di, 160*12+40*2
	;(cx)=number of digits
   s1:	pop es:[di]
	mov byte ptr es:[di+1], 10011100b
	add di, 2
	loop s1
	
	mov ax, 4c00h
	int 21h
code ends

end start




