; display a string at a specified location using 21h interrupt handler

assume cs:code

data segment 
	db 'Welcome to masm!!!','$'    ; $ denotes the end of a string
data ends

code segment
start:  mov ah, 2 ; set location of cursor
	mov bh, 0 ; set page number
	mov dh, 15; row number
	mov dl, 50; column number
	int 10h

	mov ax, data
	mov ds, ax
	mov dx, 0  ; ds:dx points to the location of the string
	mov ah, 9  ;display a string at the cursor
	int 21h

	mov ax, 4c00h
	int 21h
code ends

end start



