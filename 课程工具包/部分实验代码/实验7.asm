assume cs:code,ds:data,ss:stack

data segment


		db	'1975','1976','1977','1978','1979','1980','1981','1982','1983'
		db	'1984','1985','1986','1987','1988','1989','1990','1991','1992'
		db	'1993','1994','1995'
		;以上是表示21年的21个字符串 year


		dd	16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
		dd	345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
		;以上是表示21年公司总收入的21个dword数据	sum

		dw	3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
		dw	11542,14430,15257,17800

		;employee


data ends

table segment
		db	21 dup ('year summ ne ?? ')
table ends


stack segment stack
	db	128 dup (0)
stack ends



code segment

	start:	mov ax,stack
		mov ss,ax
		mov sp,128


		mov bx,data
		mov ds,bx			;ds:[si]	ds:[si+84]	ds:[di]

		mov bx,table
		mov es,bx			;es:[bx]

		mov si,0
		mov di,21*4*2
		mov bx,0			

		mov cx,21
				

;				 0123456789ABCDEF
;		db	21 dup ('year summ ne ?? ')

setDate:	;year
		push ds:[si]
		pop es:[bx]
		push ds:[si+2]
		pop es:[bx+2]

		mov ax,ds:[si+21*4]
		mov dx,ds:[si+21*4+2]
		mov es:[bx+5],ax
		mov es:[bx+7],dx

		push ds:[di]
		pop es:[bx+10]

		div word ptr es:[bx+10]

		mov es:[bx+13],ax

		
		add si,4
		add di,2
		add bx,16
		loop setDate
		




		mov ax,4C00H
		int 21H



code ends



end start
