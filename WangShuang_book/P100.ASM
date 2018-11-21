assume cs:code

code segment
        mov ax,2
        add ax,ax

        mov ax,4c00H
        int 21H
code ends

end
