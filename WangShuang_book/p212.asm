; function: display all the data of the data segment in a table format
; algorithm: get an integer, transform it to its corresponding string, 
; display this string in its place

assume cs:code, ds:data

data segment
	dw 1975, 1976, 1984, 1993, 1994, 1995
	dd 16, 22, 97479, 3753000, 4649000, 5937000
	dw 3, 7, 778, 14430, 15257, 17800
	dw 5, 3, 125, 260, 304, 333
	db 20 dup (0)  ;ds:60, store the transformed string which ends with a 0
data ends

code segment
start:  mov ax, data
	mov ds, ax
	mov si, 0     ; ds:si=address where data is stored   
	mov ax, 0b800H
	mov es, ax
	
	; display all the years
	mov bh, 7 ; row number
	mov bl, 3 ; column number	
	mov dl, 01000010B   ; color setting
	mov cx, 6
    s0:	mov ax, [si]
	call dtoc
	call show_str 
	add si, 2
	inc bh
	loop s0

	; display 2nd column of the table
	mov bh, 7 
	mov bl, 15
	mov cx, 6
    s1: mov ax, [si]
	mov dx, [si+2]
	call dtoc2   ; another version of dtoc, deal with dword data
	mov dl, 00100100B
	call show_str
	add si, 4    ; dword
	inc bh
	loop s1
	
	; display 3rd, 4th column of the table
	mov bl, 40
	mov dl, 00010010B
	mov cx, 2
   s34: push cx
	mov bh, 7
	add bl, 20
	mov cx, 6
  s340: mov ax, [si]
	call dtoc
	call show_str
	add si, 2
	inc bh
	loop s340
	pop cx
	loop s34

	mov ax, 4c00H
	int 21H

 dtoc:  ;description: transform a word integer into its corresponding string
	;
	;params: (ax)=word integer, ds:60 = address where to store string
	;
	;return: none
	
	push ax
	push bx
	push cx
	push dx
	push si
	
	; push chars into stack
	mov si, 0   ; count number of digits
	mov bx, 10
    s4:	mov dx, 0
        div bx
	add dx, 30H
	push dx
	inc si
	mov cx, ax
	jcxz ok
	jmp short s4

	; pop chars to ds:60
    ok: mov bx, 60
        mov cx, si
    s5: pop dx
	mov [bx], dl
	inc bx
	loop s5
	mov byte ptr [bx], 0

	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	
	ret
;;;;;;;;;;;;;;;;;; end of subprocedure dtoc ;;;;;;;;;;;;;;;;


show_str: 
	; description: display a string that ends with a 0 at a specified location 
	; on the screen of dosbox , with a specified color setting
	;
	; params: (bh)=row number, (bl)=column number, (dl)=color setting
	;    ds:60 = address where the string is stored

	push ax
	push bx
	push cx
	push dx
	push si

	; if (bl) is odd, then (bl)++, else don't change
	mov ah, 0
	mov al, bl
	mov cl, 2
	div cl
	add bl, ah
	
	; get the address to display the string
	mov al, 160
	mul bh
	mov bh, 0
	add ax, bx
	mov bx, ax  ; es:bx = address where to display the string

	mov ah, dl  ; color setting
	mov si, 60
    s6: mov cl, [si]
	mov ch, 0
	jcxz ok1
	mov al, cl
	mov es:[bx], ax
	inc si
	add bx, 2
	loop s6

   ok1: pop si
	pop dx
	pop cx
	pop bx
	pop ax

	ret
;;;;;;;;;;;;;; end of subprocedure show_str ;;;;;;;;;;;;;;;;;;;;;;;;;;


dtoc2:  ;description: transform a dword integer to its corresponding decimal string
	; 
	;params: (dx)=high 16 bits, (ax)=low 16 bits, string is stored at ds:60
	; 		with an ending 0
	;return: none
	
	push ax
	push bx
	push cx
	push dx
	push si

	; push all digits into the stack
	mov si, 0  ; count number of digits
    s7:	mov bx, 10 ; divisor
	call divdw ; there may be division overflow, so call divdw
	add bx, 30H
	push bx
	inc si
	mov cx, dx
	add cx, ax
	jcxz ok2
	jmp short s7

	; transfer all the digits to ds:60
   ok2: mov cx, si
	mov si, 60
    s8:	pop bx
	mov [si], bl
	inc si
	loop s8
	mov byte ptr [si], 0
	
	pop si
	pop dx
	pop cx
	pop bx
	pop ax

	ret	
;;;;;;;;;;;;;;;;;;;;;end of subprocedure dtoc2 ;;;;;;;;;;;;;;;;;


divdw:  ;description: dword division without division overflow
	;
	; params: (dx)=high 16 bits of dividend,H, (ax)=low 16 bits of dividend, L
	;        (bx)=divisor,N
	;        (dx)*2^16+(ax)= X
	;	int() takes quotient,  rem() takes remainder
	;result: (dx)=high 16 bits of quotient, (ax)= low 16 bits of quotient
	;        (bx)=remainder
	;
	;algorithm: X/N = int(H/N)*65536 + (rem(H/N)*65536 + L)/N
	
	push cx

	push ax  ;  push L
	mov ax, dx
	mov dx, 0
	div bx 
	mov cx, ax ; (cx) =  high 16 bits of quotient
	pop ax     ;  now (dx) = rem(H/N), (ax) = L
	div bx
	mov bx, dx
	mov dx, cx
	
	pop cx

	ret
;;;;;;;;;;;;;;; end of subprocedure divdw ;;;;;;;;;;;;;;;;;
	
code ends

end start














