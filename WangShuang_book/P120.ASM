assume cs:code
code segment
        mov bx,0
        mov cx,12
        mov ax,0
        mov ds,ax
        mov ax,1000H
        mov es,ax

     s: mov dl,ds:[bx]
        mov es:[bx],dl
        inc bx
        loop s

        mov ax,4c00H
        int 21H
code ends
end
