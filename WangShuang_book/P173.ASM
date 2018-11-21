assume cs:code, ds:data, ss:stack

data segment
        db '1975', '1976', '1977', '1978', '1979' ; 20 bytes
        ; 5 years
        dd 16, 22, 382, 1356, 2390                ; 20 bytes
        ; 5 total avenue
        dw 3, 7, 9, 13, 28                        ; 10 bytes
        ; numbers of employment of 5 years
data ends

stack segment
        dw 0, 0, 0, 0, 0, 0, 0, 0
stack ends

table segment
        db 5 dup ('year summ ne ?? ')
table ends

code segment
 start: mov ax, data
        mov ds, ax

        mov ax, stack
        mov ss, ax
        mov sp, 16

        mov ax, table
        mov es, ax

        ; deal with years
        mov bx, 0
        mov si, 0
        mov cx, 5
    s1: mov ax, [si]
        mov es:[bx], ax
        add si, 2
        mov ax, [si]
        mov es:[bx+2], ax
        add si, 2
        add bx, 16
        loop s1

        ; deal with total avenue
        mov bx, 0
        mov cx, 5
    s2: mov ax, [si]
        mov es:[bx+5], ax
        add si, 2
        mov ax, [si]
        mov es:[bx+7], ax
        add si, 2
        add bx, 16
        loop s2

        ; deal with numbers of employment
        mov bx, 0
        mov cx, 5
    s3: mov ax, [si]
        mov es:[bx+10], ax
        add si, 2
        add bx, 16
        loop s3

        mov bx, 0
        mov cx, 5
    s4: mov ax, es:[bx+5]
        mov dx, es:[bx+7]
        div word ptr es:[bx+10]
        mov es:[bx+13], ax
        add bx, 16
        loop s4

        mov ax, 4c00h
        int 21h
code ends

end start
