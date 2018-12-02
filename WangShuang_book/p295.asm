assume cs:code

code segment
start:	mov al, 120
	call showsin

	mov ax, 4c00h	
	int 21h

showsin:
	;description:display the value of sin(x),x in {0, 30, 60, 90, 120, 150, 180}
	;params: (al)=x
	;return: none

	jmp short show
	table dw ag0, ag30, ag60, ag90, ag120, ag150, ag180
	ag0 db '0', 0
	ag30 db '0.5', 0
	ag60 db '0.866', 0
	ag90 db '1', 0
	ag120 db '0.866', 0
	ag150 db '0.5', 0
	ag180 db '0', 0

 show:	push ax
	push bx
	push es
	push di

	mov ah, 0
	mov bl, 30
	div bl
	mov bl, 2
	mul bl     ;Caution!!! table dw, so be multiplied by 2
	mov bx, ax
	mov bx, table[bx]  ;now (bx)=displacement of the string to be displayed
	
	mov ax, 0b800h
	mov es, ax
	mov di, 160*12+40*2
 shows:	mov al, cs:[bx]
	cmp al, 0
	je showret
	mov es:[di], al
	mov byte ptr es:[di+1], 10011100b
	inc bx
	add di, 2
	jmp short shows

showret:pop di
	pop es
	pop bx
	pop ax
	
	ret

code ends

end start


