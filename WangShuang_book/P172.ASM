assume cs:code, ss:stack

stack segment
        db 200 dup (0)
stack ends

code segment
 start: mov ax, 0aaafH

        mov ax, 4c00h
        int 21h
code ends

end start
