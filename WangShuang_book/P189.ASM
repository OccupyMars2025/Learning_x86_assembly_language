assume cs:code

data segment
	db 'Welcome to masm!'
data ends

code segment
start:
	mov ax,data
	mov es,ax
	mov ax,0b800h;基地址
	mov ds,ax
	mov bx,0710h;设置字符串首地址

	mov cx,16;总共16个字符，所以循环16次 
	mov si,0 
      s:mov al,es:[si];取出字符 

	mov ah,02h;设置属性为绿色 
	mov word ptr ds:[bx],ax;把字符输入到需要显示的地址 
	
	mov ah,24h;设置属性为绿底红色、 
	mov word ptr ds:[bx+0a0h],ax 
	
	mov ah,71h;设置属性为白底蓝色 
	mov word ptr ds:[bx+0a0h+0a0h],ax 
	
	inc si 
	add bx,2
	loop s

        mov ax,4c00h
        int 21h
code ends

end start
