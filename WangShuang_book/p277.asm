assume cs:code

stack segment
	db 20 dup (0)
stack ends

code segment
start:  mov ax, stack
	mov ss, ax
	mov sp, 20
	
	mov ax, 0b800h
	mov es, ax
    	mov ah, 'a'
	mov di, 160*12+40*2
    s:	mov es:[di], ah
	mov byte ptr es:[di+1], 10011010b
	call delay
	inc ah
	cmp ah, 'z'
	jna s

	mov ax, 4c00h
	int 21h

 delay: ;run useless code to delay
	push dx
	push ax

	mov dx, 10h
	mov ax, 0
    s0: sub ax, 1
	sbb dx, 0
	cmp ax, 0
	jne s0
	cmp dx, 0
	jne s0

	pop ax
	pop dx
	ret

code ends

end start



