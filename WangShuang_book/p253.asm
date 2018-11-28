assume cs:code

code segment
start:  mov ax, 3456
	int 7ch
	add ax, ax
	adc dx, dx
	mov ax, 4c00H
	int 21H
code ends

end start
