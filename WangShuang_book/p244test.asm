assume cs:code

code segment
start:  mov ax, 5000
	mov bh, 2
	div bh

	mov ax, 4c00h
	int 21h
code ends

end start
