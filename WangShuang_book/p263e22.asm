;test p263e2.asm : display 80 '!' using 7ch interrupt handler

assume cs:code

code segment
start:  mov ax, 0b800h
	mov es, ax
	mov di, 160*20
	mov cx, 80  ;repeat times
	mov bx, offset s - offset se ;transfer displacement
	
    s:  mov byte ptr es:[di], '!'
	mov byte ptr es:[di+1], 10011100b
	add di, 2
	int 7ch    ;key
   se:  nop

	mov ax, 4c00h
	int 21h
code ends

end start


