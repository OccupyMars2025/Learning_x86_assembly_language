; test p262e1.asm: use interrupt handler to display a string

assume cs:code

data segment
	db 'Welcome to masm!!!', 0
data ends

code segment
start:  mov ax, data
	mov ds, ax
	mov si, 0
	mov dh, 15
	mov dl, 50
	mov cl, 10011100b
	int 7ch

	mov ax, 4c00h
	int 21h
code ends

end start


