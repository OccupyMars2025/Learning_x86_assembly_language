assume cs:code

code segment
 start: jmp short s
        db 128 dup (0)
     s: mov ax, 0ffffh

        mov ax, 4c00h
        int 21h
code ends

end start
