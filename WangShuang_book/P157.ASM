assume cs:code, ds:data

data segment
        db 'ibm             '
        db 'dec             '
        db 'dos             '
        db 'vax             '
        dw 0
data ends

code segment
 start: mov ax, data
        mov ds, ax
        mov bx, 0

        mov cx, 4
    s0: mov ds:[40H], cx
        mov si, 0

        mov cx, 3
     s: mov al, [bx+si]
        and al, 11011111B
        mov [bx+si], al
        inc si
        loop s

        add bx, 16
        mov cx, ds:[40H]
        loop s0

        mov ax, 4c00H
        int 21H
code ends

end start
