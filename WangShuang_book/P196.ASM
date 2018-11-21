assume cs:code

stack segment
        dw 8 dup (0)
stack ends

code segment
 start: mov ax, stack
        mov ss, ax
        mov sp, 16
        mov word ptr ss:[0], offset s
        mov ss:[2], cs
        call dword ptr ss:[0]
        nop
     s: mov ax, offset s
        sub ax, ss:[0ch]
        mov bx, cs
        sub bx, ss:[0eh]
        mov ax, 4c00h
        int 21h
code ends
end start
