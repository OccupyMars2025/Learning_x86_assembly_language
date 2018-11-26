assume cs:code, ds:data

data segment
	db 112, 234, 3, 7, 8, 9  ; 6 bytes
data ends

code segment
start:  ; count how many numbers are greater than 8 in data segment,
	;  store the count in ax
	
	mov ax, data
	mov ds, ax
	mov bx, 0   ; ds:bx points to the 1st byte
	mov ax, 0   ; initialize ax
	
	mov cx, 6
     s: cmp byte ptr [bx], 8
	jna next
	inc ax
  next: inc bx
	loop s

	mov ax, 4c00h
	int 21h
	
code ends

end start


