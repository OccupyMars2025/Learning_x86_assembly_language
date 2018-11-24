assume cs:code, ds:data

data segment
	db 10 dup (0)
data ends

code segment
; store an integer in a register then display it on the screen of
; dosbox
start:  mov ax, data
	mov ds, ax
	mov si, 0
	mov ax, 65530
	call dtoc  ; Caution: after this, (si) must be restored to 0

	mov dh, 8
	mov dl, 3
	mov cl, 00100100b
	call show_str

	mov ax, 4c00H
	int 21H


dtoc:	;description: change an integer in a word unit to a string of
	; decimal representation
	;
	;params: (ax)= integer in a word unit
	;	 ds:si=head location of the transformed string
	;return: none
	
	push ax
	push si
	push di
	push bx
	push dx
	push cx

	mov di, 0  ; count number of digits in the string
	mov bx, 10
s0:	mov dx, 0
	div bx
	add dx, 30H
	inc di
	push dx
	mov cx, ax ; determine whether the division can be stopped
	jcxz ok0
	jmp short s0

ok0:	mov cx, di  ; transfer all the digits from the stack to ds:si
s1:  	pop dx
	mov [si], dl
	inc si
	loop s1
	mov byte ptr [si], 0 ; add a 0 to indicate the end of a string

	pop cx
	pop dx
	pop bx
	pop di
	pop si
	pop ax
        
	ret
;;;;;;;;;;;;  end of sub-procedure dtoc ;;;;;;;;;;;;;;;;;;;;


show_str:
	;description: display  a string that ends with a 0 
	; at a specified location of the screen , with a specified 
	; color setting
	;
	;params: (dh)=row number(range(0,25)), (dl)=column number
	; (range(0,80)), (cl)=color setting, ds:si points to the locat
	; -ion where the string is stored
	;
	;return: none

	push ax
	push bx
	push cx
	push dx
	push es
	push si
	push di
	
	; if (dl) is odd,then (dl)++, else don't change
	; because you can only store char in even address and
	; color setting in odd address
	; b800:0000 char, b800:0001 color,...
	mov ah, 0
	mov al, dl
	mov bl, 2
	div bl
	add dl, ah

	; find the address to display
	mov ah, 0
	mov al, 160
	mul dh
	mov dh, 0
	add ax, dx
	mov di, ax  ; (di)=offset address where to display
	mov ax, 0b800H
	mov es, ax  ; es:di = address where to display

	; now display!
	mov ah, cl
s2:	mov cl, [si]
	mov ch, 0
	jcxz ok1
	mov al, [si]
	mov es:[di], ax
	inc si
	add di, 2
	jmp short s2

ok1:	pop di
	pop si
	pop es
	pop dx
	pop cx
	pop bx
	pop ax

	ret
;;;;;;;;;;;;;;;;;; end of sub-procedure show_str ;;;;;;;;;;;;;;;;;

code ends

end start
