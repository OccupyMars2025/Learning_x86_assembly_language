;calculate n**3, n=1,2,...,8

assume cs:code, ds:data

data segment
	dw 1, 2, 3, 4, 5, 6, 7, 8
	dd 0, 0, 0, 0, 0, 0, 0, 0
data ends

code segment
 start: mov ax, data
	mov ds, ax
	mov si, 0	; first word unit
	mov di, 16	; first dword unit
	
	mov cx, 8
    s:  mov bx, [si]
	call cube
	mov [di], ax
	mov [di+2], dx
	add si, 2
	add di, 4
	loop s

	mov ax, 4c00h
	int 21h

  cube: mov ax, bx
	mul bx
	mul bx
	ret
code ends

end start
