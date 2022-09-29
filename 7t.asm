assume cs:code

code segment
    db 00, 99h, 00h, 06h, 00h, 11h, 2h

start:
    mov ax, cs
    mov ds, ax
    mov bx, 0

    mov si, 1
    mov ax, [bx + si]

    inc si
    mov cx, [bx + si]
    inc si
    mov cx, [bx + si]


    mov ax, 4c00h
    int 21h

code ends

end start