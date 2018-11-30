; display chars 'a'~'z' in order

assume cs:code

code segment
start:  mov ax, 0b800h
	mov es, ax
	mov ah, 'a'
    s: 	mov es:[160*12+40*2], ah
	inc ah
	cmp ah, 'z'
	jna s
	
	mov ax, 4c00h	
	int 21h
code ends

end start
