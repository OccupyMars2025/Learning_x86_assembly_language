assume cs:code

code segment 
   s1:	db 'This is good.','$'
   s2:  db 'Till good is better','$'
   s3:  db 'Practices makes perfect','$'
   s4:  db 'accomplish sth','$'
   s :	dw offset s1, offset s2, offset s3, offset s4
  row:  db 2, 5, 8, 11

start:  mov ax, cs
	mov ds, ax
	mov bx, offset s
	mov si, offset row

	mov cx, 4
   ok:  mov bh, 0
	mov dh, [si]
	mov dl, 10
	mov ah, 2
	int 10h

	mov dx, [bx]
	mov ah, 9
	int 21h

	inc si
	add bx, 2
	loop ok

	mov ax, 4c00h
	int 21h
code ends

end start



