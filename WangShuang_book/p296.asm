assume cs:code

code segment
start:	mov ah, 2
	mov al, 00000100b
	call setscreen

	mov ax, 4c00h
	int 21h

setscreen:
	;description: call different sub procedures to achieve different functions
	;   (ah) in {0, 1, 2, 3}, (al) in {0, 1, 2, 3, 4, 5, 6, 7}
	; (ah)=0: clear screen
	; (ah)=1: set font color of the screen
	; (ah)=2: set background color of the screen
	; (ah)=3: scroll up the screen one row
	; (al) is color setting: red, green, blue, only useful when (ah)=1 or 2
	;
	;params: (ah), (al)
	;return: none
	
	jmp short set
	table dw sub1, sub2, sub3, sub4
	
  set:	push ax
	push bx

	cmp ah, 3
	ja setret
	mov bl, ah
	mov bh, 0
	add bx, bx
	call word ptr table[bx]  ;Caution!!!

setret: pop bx
	pop ax

	ret

;;;;;;;;;;;;;; here are 4 sub procedures: sub1, sub2, sub3, sub4 ;;;;;;;;;;;;;;

sub1:	; clear screen
	push ax
	push cx
	push es
	push di

	mov ax, 0b800h
	mov es, ax
	mov di, 0
	mov cx, 2000
 sub1s:	mov byte ptr es:[di], ' '
	add di, 2
	loop sub1s	

	pop di
	pop es
	pop cx
	pop ax

	ret


sub2:	;set font color of the whole screen
	;params: (al) is in {0, 1, 2, 3, 4, 5, 6, 7}, (al) is color setting

	push ax
	push cx
	push es
	push di

	mov di, 0b800h
	mov es, di
	mov di, 1
	mov cx, 2000
 sub2s:	and byte ptr es:[di], 11111000b
	or byte ptr es:[di], al
	add di, 2
	loop sub2s

	pop di
	pop es
	pop cx
	pop ax
	
	ret

sub3:	;set background color of the whole screen
	;params: (al) is in {0, 1, 2, 3, 4, 5, 6, 7}, (al) is color setting

	push ax
	push cx
	push es
	push di

	mov cl, 4
	shl al, cl
	mov di, 0b800h
	mov es, di
	mov di, 1
	mov cx, 2000
 sub3s:	and byte ptr es:[di], 10001111b
	or byte ptr es:[di], al
	add di, 2
	loop sub3s

	pop di
	pop es
	pop cx
	pop ax
	
	ret


sub4:	; scroll up the whole screen one row
	
	push cx
	push ds
	push si
	push es
	push di

	mov si, 0b800h	
	mov ds, si
	mov es, si
	mov si, 160
	mov di, 0
	cld   ;set df flag as 0	
	mov cx, 24
 sub4s: push cx
	mov cx, 160
	rep movsb
	pop cx
	loop sub4s

	; set bottom row as empty row
	mov cx, 80    ;now (di)=160*24
sub4s1:	mov byte ptr es:[di], ' '
	add di, 2
	loop sub4s1
	
	pop di
	pop es
	pop si
	pop ds
	pop cx

	ret

code ends

end start







