assume cs:code

code segment
 start: mov ax, 2000H
        mov ds, ax
        mov bx, 0
     s: mov ch, 0
        mov cl, [bx]
        jcxz ok
        inc bx
        loop s

    ok: mov dx, bx
        mov ax, 4c00H
        int 21H
code ends

end start
