assume cs:code, ds:data

data segment
	db 'Welcome to masm!Hello java,dos,c,c++,python', 0
data ends

code segment
start:  mov dh, 8
	mov dl, 44
	mov cl, 01000010b
	mov ax, data
	mov ds, ax
	mov si, 0

	call show_str

	mov ax, 4c00h
	int 21h

show_str:
	;description: display a string that ends with a 0 
	;          at a specified location with a specified color
	;params: (dh)=row number(range 0-24), (dl)=column number(range 0-79), (cl)=          ;         color, ds:si points to the first char to be displayed
	;return: none
	push es
	push ax
	push dx
	push bx
	push cx
	push si

	mov ah, 0    ; change (dl) to an even number
	mov al, dl   ; if (dl) is odd, (dl)++, else don't change
	mov bl, 2    
	div bl
	add dl, ah

	mov ax, 0b800h
	mov es, ax 
	mov al, 160
	mul dh
	mov dh, 0
	add ax, dx
	mov bx, ax     ; offset location where the first char will be displayed
	mov ah, cl     ; Caution!!! whether (bx) is even or odd, so we change (dl) at
		       ; first
		       ; graphics card memory: b800:0000 char, b800:0001 color, ...

s:	mov cl, [si]
	mov ch, 0
	jcxz ok
  	mov al, [si]
	mov es:[bx], ax
	inc si
	add bx, 2
	jmp short s

ok:     pop si
	pop cx
	pop bx
	pop dx
	pop ax
	pop es
	ret
code ends

end start
