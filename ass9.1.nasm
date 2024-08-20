;Write X86/64 ALP to perform multiplication of two 8-bit hexadecimal numbers.Use successive addition and add and shift method.
;Successive Addition 

global _start:

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
mov rsi, %1
mov rdx, %2
syscall
%endmacro

dispmsg msg1,len1
accept num,3
call convert
mov [no1],al

dispmsg msg2,len2
accept num,3
call convert
mov [no2],al

dispmsg msg3,len3
mov bx,0000H
mov [res],bx
mov bx,[no1]

back4: add [res],bx
dec byte[no2]
jnz back4

mov rax,[res]
call display

;To exit the program
mov rax,60
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
mov rsi,disparr+1
mov rcx,16
l3: mov rbx, 10h
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
mov rdx,16
syscall
ret

section .data

msg1 db "Enter number1 : "
len1 equ $-msg1
msg2 db "Enter number2 : "
len2 equ $-msg2
msg3 db "Multiplication is : "
len3 equ $-msg3

section .bss

disparr resb 40
no1 resb 40
no2 resb 40
num resb 40
res resb 40
