assume cs:code, ds:data

data segment
	db 8, 11, 8, 0, 2, 100, 98, 8, 7  ; 9 bytes
data ends

code segment
	; count number of 8 in data segment, and store the result in ax
	
start:	mov ax, data
	mov ds, ax
	mov bx, 0  ; ds:bx points to 1st byte of data segment
	mov ax, 0  ; initialize the counter
	
	mov cx, 9
     s:	cmp byte ptr [bx], 8
    	jne next
	inc ax
  next: inc bx
	loop s

	mov ax, 4c00H
	int 21H
code ends

end start


