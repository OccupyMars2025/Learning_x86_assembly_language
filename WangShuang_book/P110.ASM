assume cs:code
code segment
        mov ax,2000H
        mov ds,ax
        mov al,[0]
        mov bl,[1]
        mov cl,[2]
        mov dl,[3]

        mov ax,4c00H
        int 21H
code ends
end
