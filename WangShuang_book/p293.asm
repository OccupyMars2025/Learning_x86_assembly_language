assume cs:code

code segment
start:	mov al, 11010110b
	call showbyte

	mov ax, 4c00h
	int 21h

showbyte:
	;description:display (al) in a hex representation on the dosbox screen
	;params: (al)
	;return: none

	jmp short show
	table db '0123456789ABCDEF'

 show:	push ax
	push bx
	push cx
	push es
	push di
	
	mov ah, al
	mov cl, 4
	shr ah, cl
	mov bl, ah
	mov bh, 0
	mov ah, table[bx] ;hex digit char corresponding to 4 high bits

	and al, 00001111b
	mov bl, al
	mov bh, 0
	mov al, table[bx] ;hex digit char corresponding to 4 low bits

	mov bx, 0b800h
	mov es, bx
	mov di, 160*12+40*2
	mov es:[di], ah
	mov byte ptr es:[di+1], 11001010b
	mov es:[di+2], al
	mov byte ptr es:[di+3], 10101001b

	pop di
	pop es
	pop cx
	pop bx
	pop ax

	ret

code ends

end start



