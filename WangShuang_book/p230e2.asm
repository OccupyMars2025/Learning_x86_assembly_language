assume cs:code, ds:data

data segment
	db 1, 235, 2, 9, 11, 23, 98, 111 ; 8 bytes
data ends

code segment
	; count how many numbers of data segment are in (11, 111)
	; store result in dx

start:  mov ax, data
	mov ds, ax
	mov bx, 0  ; ds:bx points to 1st byte of data segment
	mov dx, 0  ; count 

	mov cx, 8
     s: mov al, [bx]
	cmp al, 11
	jbe next
	cmp al, 111
	jae next
	inc dx
  next: inc bx
	loop s

	mov ax, 4c00h
	int 21h
code ends

end start



