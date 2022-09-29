; 根据位移转移 test

assume cs:code

code segment

    mov ax, 1
s:  mov ax, 2
    jmp short s

code ends
end