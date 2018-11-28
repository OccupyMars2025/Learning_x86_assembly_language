assume cs:code, ds:data

data segment
	db 'hElLo, JAVA,12345,#$@#, python', 0
data ends

code segment
start:  mov ax, data
	mov ds, ax
	mov si, 0
	int 7ch

	mov ax, 4c00h
	int 21h
code ends

end start


