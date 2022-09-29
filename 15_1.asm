assume cs:code

code segment

    mov dx, 3f8h
    in  al, 20h
    in  al, dx
    out dx, al

    mov ah, 4ch
    int 21h
code ends
end