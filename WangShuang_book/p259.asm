; display the cursor at a specified location

assume cs:code

code segment
start:  mov ah, 2 ; set cursor
	mov bh, 0 ; the 0th page
	mov dh, 5 ; row number
	mov dl, 12; column number
	int 10h
code ends

end start
