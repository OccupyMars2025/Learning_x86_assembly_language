assume cs:code, ds:data, ss:stack

data segment
        db 'ibm             '
        db 'dec             '
        db 'dos             '
        db 'vax             '
data ends

stack segment
        dw 0, 0, 0, 0, 0, 0, 0, 0   ; 8 words
stack ends

code segment
 start: mov ax, stack
        mov ss, ax
        mov sp, 16

        mov ax, data
        mov ds, ax
        mov bx, 0

        mov cx, 4
    s0: push cx
        mov si, 0

        mov cx, 3
     s: mov al, [bx+si]
        and al, 11011111B
        mov [bx+si], al
        inc si
        loop s

        add bx, 16
        pop cx
        loop s0

        mov ax, 4c00H
        int 21H
code ends

end start
