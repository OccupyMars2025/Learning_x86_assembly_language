assume cs:code

code segment
start:  mov ax, 1000H
	mov dx, 1
	mov bx, 1
	div bx

	mov ax, 4c00H
	int 21H
code ends

end start
