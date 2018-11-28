; 编写除法溢出（中断源号0）中断处理程序（存储于0000:0200）

assume cs:code

code segment
start:  mov ax, 0
	mov es, ax
	mov di, 0200H
	
	mov ax, cs
	mov ds, ax
	mov si, offset do0
	
	mov cx, offset do0end - offset do0
	cld	; set flag df to 0
	rep movsb

	;设置中断向量表
	mov ax, 0
	mov es, ax
	mov word ptr es:[0*4],  0200H
	mov word ptr es:[0*4+2], 0

	mov ax, 1000H ; test the overflow
	mov bl, 1
	div bl

	mov ax, 4c00H
	int 21H

	; display the string 'overflow' in the middle of dosbox screen
  do0:  jmp short do0start
	db 'overflow!!!'

do0start:
	mov ax, 0
	mov ds, ax
	mov si, 0202H

	mov ax, 0b800H
	mov es, ax
	mov di, 160*12+30*2

	mov cx, 11
     s: mov al, [si]
	mov es:[di], al
	mov byte ptr es:[di+1], 01000001B
	inc si
	add di, 2
	loop s
	
	mov ax, 4c00H
	int 21H

do0end: nop

code ends

end start




