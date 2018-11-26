assume cs:code, ds:data

data segment
	db "Beginner's All-purpose Symbolic Instruction Code.123456", 0
data ends

code segment
	; transform all lower-case letters to upper case
start:  mov ax, data
	mov ds, ax
	mov si, 0
	call letterc

	mov ax, 4c00h
	int 21h

letterc:
	;description: transform all lowercase letters to upper case
	;params: ds:si points to the head address of the string
	;return: none

     s:	mov al, [si]
	cmp al, 0
	je done
	cmp al, 97
	jb next
	cmp al, 122
	ja next
	sub byte ptr [si], 32
  next: inc si
	jmp short s
  done: ret

code ends

end start


