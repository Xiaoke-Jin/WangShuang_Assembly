assume cs:code

code segment
    mov ax, 0b800h
    mov es, ax
    mov byte ptr es:[12*160+40*2], '!'
    int 0

    mov ah, 4ch
    int 21h
code ends
end