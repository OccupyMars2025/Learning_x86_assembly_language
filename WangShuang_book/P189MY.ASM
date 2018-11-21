assume cs:code

data segment 
	db 'Welcome to masm!'  ; 16 chars
data ends

code segment

start:  
	mov ax, data
	mov es, ax
	mov ax, 0b800h
	mov ds, ax
	mov bx, 0720h   ; where to print 
	mov si, 0	

	mov cx, 16
     s: mov al, es:[si]	
	
	mov ah, 02h
	mov word ptr ds:[bx], ax

	mov ah, 24h
	mov word ptr ds:[bx+0a0h], ax

        mov ah, 71h
	mov word ptr ds:[bx+0a0h+0a0h], ax

	inc si
	add bx, 2
	loop s
	
	mov ax, 4c00h
	int 21h
code ends

end start
