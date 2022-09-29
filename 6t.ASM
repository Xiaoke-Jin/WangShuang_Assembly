assume cs:a

c segment
	dw 0123h, 0567
c ends


b segment
	dw 0123h, 0567
b ends

a segment
	s:            mov ax, 1h
		mov ax, 10
		mov ax, b
		mov bx, c
		mov ax, 4c00h
		int 21h
a ends

end s


