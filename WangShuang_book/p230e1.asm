assume cs:code, ds:data

data segment
	db 2, 35, 1, 87, 56, 77, 100, 220  ; 8 bytes
data ends

code segment
	; count how many numbers of data segment are in [10, 100]
start:	mov ax, data
	mov ds, ax
	mov bx, 0
	mov dx, 0  ; count numbers

	mov cx, 8
     s: mov al, [bx]
	cmp al, 10
	jb next
	cmp al, 100
	ja next
	inc dx
  next: inc bx
	loop s

	mov ax, 4c00h
	int 21h
code ends

end start
