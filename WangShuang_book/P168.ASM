assume cs:code

code segment
 start: mov ax, 2000H
        mov ds, ax
        mov bx, 60H
        mov word ptr [bx+0ch], 38
        add word ptr [bx+0eh], 70

        mov si, 0
        mov byte ptr [bx+10h+si], 'V'
        inc si
        mov byte ptr [bx+10h+si], 'A'
        inc si
        mov byte ptr [bx+10h+si], 'X'

        mov ax, 4c00h
        int 21h
code ends

end start
