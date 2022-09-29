; 段间转移 test
assume cs:code

data segment
    dd 12345678h
data ends

code segment
start:  mov ax, data                 ; CS = DS + 10h, IP = 0
        mov ds, ax

        mov bx, 0
        mov [bx], bx
        mov [bx + 2], cs
        jmp dword ptr ds:[0]    ; 段间转移

        mov ax, 4c00h
        int 21h
code ends
end start
