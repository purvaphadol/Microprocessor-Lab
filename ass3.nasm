;Write a switchcase driven x86/64 ALP to perform 64-bit hexadecimal arithmetic operations (+,-,/,*) using suitable macros.

global _start
_start:

section .text

%macro dispmsg 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro accept 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro

back1:dispmsg msg1,len1
dispmsg msg2,len2
accept num,2
mov al,[num]

cmp al,31H
je ch1

cmp al,32H
je ch2

cmp al,33H
je ch3

cmp al,34H
je ch4

cmp al,35H
je ch5

jmp exit

ch1: call add1
jmp back1

ch2: call sub1
jmp back1

ch3: call mul1
jmp back1

ch4: call div1
jmp back1

ch5: jmp exit

add1: dispmsg msg3,len3
	accept num,3
	call convert
	mov [no1],al
	
	dispmsg msg4,len4
	accept num,3
	call convert
	mov [no2],al

	mov rax,[no1]
	mov rbx,[no2]
	add rax,rbx
	call display 
	dispmsg msg5,len5
	ret 

sub1: dispmsg msg3,len3
	accept num,3
	call convert
	mov [no1],al
	
	dispmsg msg4,len4
	accept num,3
	call convert
	mov [no2],al

	mov rax,[no1]
	mov rbx,[no2]
	sub rax,rbx
	call display
	dispmsg msg5,len5
	ret

mul1: dispmsg msg3,len3
	accept num,3
	call convert
	mov [no1],al
	
	dispmsg msg4,len4
	accept num,3
	call convert
	mov [no2],al
	
	mov rax,[no1]
	mov rbx,[no2]
	mul rbx
	call display
	dispmsg msg5,len5
	ret

div1: dispmsg msg3,len3
	accept num,3
	call convert
	mov [no1],al
	
	dispmsg msg4,len4
	accept num,3
	call convert
	mov [no2],al
	
	mov rax,[no1]
	mov rbx,[no2]
	mov rdx,0
	div bx
	
	call display
	dispmsg msg5,len5
	ret
	

;To exit
exit: mov rax,60
mov rdi,0
syscall

;Convert program
convert:
mov rsi,num
mov al,[rsi]
cmp al,39H
jbe label5
sub al,07H
label5: sub al,30H
rol al,04
mov bl,al
inc rsi
mov al,[rsi]
cmp al,39H
jbe label6
sub al,07H
label6:sub al,30H
add al,bl
ret

;Display procedure
display:
mov rsi,disparr+15
mov rcx,16
l3: mov rbx, 10H
mov rdx,0
div rbx

cmp dl,09H
jbe l2
add dl,07H
l2: add dl,30H
mov[rsi],dl
dec rsi
dec rcx
jnz l3

;Display element in disparr
mov rax,1
mov rdi,1
mov rsi,disparr
mov rdx,4
syscall
ret

section .data
msg1 db "1. Addition 2. Subtraction 3. Multiplication 4. Division 5. Exit", 0AH
len1 equ $-msg1
msg2 db "Enter your choice : ",0AH
len2 equ $-msg2
msg3 db "Enter number1 : ",0AH
len3 equ $-msg3
msg4 db "Enter number2 : ",0AH
len4 equ $-msg4
msg5 db " ",0AH
len5 equ $-msg5

section .bss
disparr resb 32
no1 resb 40
no2 resb 40
num resb 40
