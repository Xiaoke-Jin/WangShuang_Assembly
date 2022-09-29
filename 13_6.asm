assume cs:code

code segment
start:
    mov ax, 0B800h
    mov es, ax
    ; mov bx, 160 * 12 + 38 * 2
    mov bx, 160 * 2 + 2

    mov byte ptr es:[bx], 'a'
    mov byte ptr es:[bx + 1], 0100100b

    mov ah, 4ch
    int 21h
code ends
end start