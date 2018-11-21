assume cs:code, ds:data

data segment
        db 'ibm             '
        db 'dec             '
        db 'dos             '
        db 'vax             '
data ends

code segment
 start: mov ax, data
        mov ds, ax

        mov bx, 0
        mov cx, 4
    s0: mov dx, cx
        mov si, 0

        mov cx, 3
     s: mov al, [bx+si]
        and al, 11011111B
        mov [bx+si], al
        inc si
        loop s

        mov cx, dx
        add bx, 16
        loop s0

        mov ax, 4c00H
        int 21H
code ends

end start
