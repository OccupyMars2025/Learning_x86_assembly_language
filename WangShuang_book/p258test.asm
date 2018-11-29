; display the string of data segment at the middle of dosbox screen
; but use "int 7ch" interrupt handler to achieve the function of  "jmp near ptr s"

assume cs:code, ds:data

data segment
	db 'conversation!!!', 0
data ends

code segment
start:  mov ax, data
	mov ds, ax
	mov si, 0
	mov ax, 0b800h
	mov es, ax
	mov di, 160*12

    s:  mov al, [si]
	cmp al, 0
	je ok
	mov es:[di], al
	mov byte ptr es:[di+1], 00010100b
	inc si
	add di, 2
	;jmp near ptr s
	mov bx, offset s - offset ok
	int 7ch
   ok:  nop

	mov ax, 4c00h
	int 21h
code ends

end start




