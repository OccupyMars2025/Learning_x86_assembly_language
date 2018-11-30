; get year,month,day,hour,minute,second from CMOS RAM
; and display them in the screen

assume cs:code

code segment
start:  
	; push second, minute, hour
    	mov bl, 0
    	mov cx, 3
   s0: 	push cx
	mov al, bl
	out 70h, al	
	in al, 71h
	mov ah, al
	mov cl, 4
	shr ah, cl
	and al, 00001111b
	add ax, 3030h  ;(ax)=two digit chars

	pop cx
	push ax
	add bl, 2
	loop s0

	; push day, month, year
	mov bl, 7
   	mov cx, 3
   s1:  push cx
	mov al, bl
	out 70h, al
	in al, 71h
	mov ah, al
	mov cl, 4
	shr ah, cl
	and al, 00001111b
	add ax, 3030h     ; (ax)=two digit chars
	
	pop cx
	push ax
	inc bl
	loop s1

	; display the string
	mov ax, 0b800h
	mov es, ax
	mov di, 160*12+40*2
	mov cx, 3
   s2: 	pop ax
	mov byte ptr es:[di], ah
	mov byte ptr es:[di+2], al
	mov byte ptr es:[di+4], '/'
	add di, 6
	loop s2

	mov byte ptr es:[di-2], ' '
	
	mov cx, 3
   s3:	pop ax
	mov byte ptr es:[di], ah
	mov byte ptr es:[di+2], al
	mov byte ptr es:[di+4], ':'
	add di, 6
	loop s3

	mov byte ptr es:[di-2], ' '

	;color setting
	mov cx, 9
   	mov di, 160*12+40*2+1
   s4:	mov byte ptr es:[di], 11001001b
	add di, 2
	loop s4
	mov cx, 8
   s5:	mov byte ptr es:[di], 10100100b
	add di, 2
	loop s5

	mov ax, 4c00h
	int 21h
code ends

end start



