;store a new "int 7ch" interrupt handler at 0000:0204
;store the old entry address of "int 7ch" at 0000:0200
;the new "int 7ch" provides 4 sub procedure:
; 1. clear screen  (when (ah)=0)
; 2. set font color of the whole screen (when (ah)=1)
; 3. set background color of the whole screen (when (ah)=2)
; 4. scroll up the screen one row (when (ah)=3)
; (al) is the color setting , (al) belongs to {0, 1, 2, 3, 4, 5, 6, 7}

assume cs:code

code segment
start:	;store new one at 0000:0204
	push cs
	pop ds
	mov si, offset int7c
	mov ax, 0
	mov es, ax
	mov di, 204h
	cld
	mov cx, offset int7cend - offset int7c
	rep movsb

	;backup old entry address at 0000:0200
	mov ax, 0
	mov es, ax
	cli
	push es:[7ch*4]
	pop es:[200h]
	push es:[7ch*4+2]
	pop es:[202h]
	sti

	;store new entry address
	mov ax, 0
	mov es, ax
	cli
	mov word ptr es:[7ch*4], 204h
	mov word ptr es:[7ch*4+2], 0
	sti

	;try using the new "int 7ch"
	mov ah, 2
	mov al, 4
	int 7ch

	;restore the old entry address
	;only after restoring the old entry address can you run p299.exe arbitrary times without closing dosbox 
	mov ax, 0
	mov es, ax
	cli
	push es:[200h]
	pop es:[7ch*4]
	push es:[202h]
	pop es:[7ch*4+2]
	sti

	;a small test
;	mov ax, 0b800h
;	mov es, ax
;	mov di, 160*12+40*2
;	mov byte ptr es:[di], 'A'
;	mov byte ptr es:[di+1], 11001001b

	mov ax, 4c00h
	int 21h

int7c:	;description: call different sub procedures to achieve different functions
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

	; 4 displacement addresses
	table dw  offset sub1 - offset int7c + 204h, offset sub2 - offset int7c + 204h, offset sub3 - offset int7c + 204h, offset sub4 - offset int7c + 204h
	
  set:	push ax
	push bx

	cmp ah, 3
	ja setret
	mov bl, ah
	mov bh, 0
	add bx, bx

	;Caution!!! When p299.asm is compiled by masm, "table" may be interpreted having a displacement address relative to segment address (cs)
	mov si, offset start - offset int7c
	call word ptr table[bx+si+204H]
;	call word ptr table[bx]  ;Caution!!!

setret: pop bx
	pop ax

	iret  
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

int7cend: nop 
		
code ends

end start



