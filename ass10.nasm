;Write x86 ALP to find the factorial of a given integer number on a Command line by using recursion.Explicit stack
;manipulation is expected in the code

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

dispmsg msg1,len1
accept num,3
call convert
mov [no1],al

mov rcx,rax
dec rcx

a1: push rax
dec rax
cmp rax,01
ja a1

a2:pop rbx
mul rbx
dec rcx
jnz a2 

call display

;To exit
mov rax,60
mov rdi,0
syscall

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
mov rsi,disparr+3
mov rcx,4
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
msg1 db "Enter a number : "
len1 equ $-msg1


section .bss
disparr resb 32
no1 resb 40
num resb 40



