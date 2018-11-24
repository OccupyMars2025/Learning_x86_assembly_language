assume cs:code

code segment
start:  mov ax, 64423
	mov dx, 59873
	mov cx, 27
	
	call divdw

	mov ax, 4c00H
	int 21H

divdw:  ;description: do division without overflow, dividend is of 
	; dword kind, divisor is of word kind,
	; quotient is of dword kind
	;
	;params: (ax)=low 16 bits of dividend, L
	; 	(dx)=high 16 bits of dividend, H
	; 	 (cx)=divisor, N
	;
	;results: (ax)=low 16 bits of quotient
	; 	  (dx)=high 16 bits of quotient
	;	  (cx)=remainder
	;
	;algorithm: X=dividend
	;  X/N = int(H/N)*65536 + (rem(H/N)*65536 + L)/N
	; int() takes quotient, rem() takes remainder
	
	push bx
	
	push ax
	mov ax, dx
	mov dx, 0
	div cx	 ; now (dx)=rem(H/N), (ax)=int(H/N)
	pop bx   ; (bx)=L
	push ax  ; it is the final result in dx
	mov ax, bx
	div cx   ; now (dx)=rem(X/N), (ax) gets its final value
	mov cx, dx
	pop dx
	
	pop bx
	ret
code ends

end start








