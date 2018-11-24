assume cs:code, ds:data

data segment
	db 'Welcome to masm!', 0
data ends

code segment
start:  mov ax, data
	mov ds, ax
	mov si, 0
	mov ax, 0b800h
	mov es, ax
	mov di, 520
	mov ah, 2  ; color setting
	
	call show_str

	mov ax, 4c00h
	int 21h

show_str: 
	push si
	push cx
	push ax
	push es
	push di

s: 	mov cl, [si]
	mov ch, 0
	jcxz ok
	mov al, [si]
	mov es:[di], ax
	inc si
	add di, 2
	jmp short s

ok:     pop di
	pop es
	pop ax
	pop cx
	pop si
	ret
code ends

end start
