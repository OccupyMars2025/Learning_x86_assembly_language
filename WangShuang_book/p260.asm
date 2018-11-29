assume cs:code

code segment
start:  mov ah, 9   ; show chars at the cursor
	mov al, 'a' ; char
	mov bl, 10101100b   ; color setting
	mov bh, 0   ; page number
	mov cx, 5   ; repeat times
	
	; first set (ah)=2, then set (ah)=9
	;mov dh, 5   ; row number
	;mov dl, 13  ; column number
	int 10h

	mov ax, 4c00h
	int 21h
code ends

end start
