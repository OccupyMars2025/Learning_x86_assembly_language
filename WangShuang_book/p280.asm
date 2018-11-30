; display 'a'~'z' in the middle of dosbox screen in alphabet order
; after a letter is displayed, wait enough time for human eyes to 
; see it clearly
; enter Esc button to change color setting

assume cs:code

stack segment
	db 128 dup (0)
stack ends

data segment
	dw 0, 0 ;store entry address of original 9th interrupt handler
data ends

code segment
start:  mov ax, stack
	mov ss, ax
	mov sp, 128
	mov ax, data
	mov ds, ax
	
	;store the entry address of the original 9th interrupt handler
	; at ds:0
	mov ax, 0
	mov es, ax
	push es:[9*4]
	pop ds:[0]
	push es:[9*4+2]
	pop ds:[2]
	
	;modify the entry address of the original 9th interrupt handler
	;to my own newly-written one
	mov ax, 0
	mov es, ax
	mov word ptr es:[9*4], offset int9
	mov es:[9*4+2], cs

	; display 'a'~'z' one by one
	mov ax, 0b800h
	mov es, ax
   	mov di, 160*12+2*2
	mov ah, 'a'
   s0:	mov es:[di], ah
	call delay
	add di, 6
	inc ah
	cmp ah, 'z'
	jna s0

	;restore the entry address of the original 9th interrupt handle
        ; -r
	mov ax, 0
	mov es, ax
	push ds:[0]
	pop es:[9*4]
	push ds:[2]
	pop es:[9*4+2]

	;end of the program
	mov ax, 4c00h
	int 21h

 delay:	;use useless operation to delay CPU for human eyes to see
	;the displayed letter clearly
	push ax
	push dx

	mov dx, 10h
	mov ax, 0
   s1:	sub ax, 1
	sbb dx, 0
	cmp ax, 0
	jne s1
	cmp dx, 0
	jne s1

	pop dx
	pop ax
	ret

;;;;;;;;;;;;;;;; my own newly-written 9th interrupt handler;;;;;;
 int9:	push ax
	push bx

	in al, 60h

	pushf
	pushf
	pop bx
	and bh, 11111100b
	push bx
	popf
	call dword ptr ds:[0] ;use original 9th interrupt handler
			      ; to deal with hardware details

	cmp al, 1 ;check whether Esc button is pushed
	jne int9end
	inc byte ptr es:[di+1]

int9end:
	pop bx
	pop ax
	iret

code ends

end start




