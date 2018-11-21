assume cs:code
code segment
        mov ax,cs
        mov ds,ax
        mov ax,0020H
        mov es,ax
        mov bx,0
        mov cx,28
     s: mov dl,[bx]
        mov es:[bx],dl
        inc bx
        loop s

        mov ax,4c00H
        int 21H
code ends
end
