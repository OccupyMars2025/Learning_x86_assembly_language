assume cs:code

code segment
start:  mov ah, 2  ; set the location of the cursor
	mov bh, 0  ; set page number
	mov dh, 5  ; row number
	mov dl, 12 ; column number
	int 10h

	mov ah, 9  ; display chars at the cursor
	mov al, 'F'; set the char
	mov bl, 10101100b  ; color setting
	mov bh, 0  ;set page number
	mov cx, 5  ; repeat times
	int 10h

	mov ax, 4c00h
	int 21h
code ends

end start
