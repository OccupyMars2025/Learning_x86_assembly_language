; display 80 '!' in the center of dosbox screen
; using int 7ch instead of loop s

assume cs:code

code segment
start:  mov ax, 0b800h
	mov es, ax
	mov di, 160*12

	mov cx, 80
        mov bx, offset s - offset se
     s: mov byte ptr es:[di], '!'
	mov byte ptr es:[di+1], 00100100b
	add di, 2
	int 7ch
    se: nop

	mov ax, 4c00h
	int 21h
code ends

end start
