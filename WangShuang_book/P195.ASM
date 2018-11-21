assume cs:code

code segment
 start: mov sp, 10h
        mov ax, 0123h
        mov ds:[0], ax
        call word ptr ds:[0]

        mov ax, 4c00h
        int 21h
code ends

end start
