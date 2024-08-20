;Write an X86/64 ALP to accept a string and to display its length

global _start:
_start:

section .text

;to display msg as accept string
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

;Use system call of read
mov rax,0
mov rdi,0
mov rsi,str1
mov rdx,length
syscall
;This system call automatically returns the length of string in rax register

dec rax
mov [str_length],rax

;display msg as length of the string
mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

mov rax,[str_length]
call display		
;Whatever we want to display...it will be in rax

;exit
mov rax,60
mov rdi,0
syscall

;Display procedure
display:
mov rsi,disparr+15
mov rcx,2
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
mov rdx,2
syscall
ret

section .data

msg1 db "Enter String : ",0AH
len1 equ $-msg1
msg2 db "Length of the String : ",0AH
len2 equ $-msg2

section .bss

disparr resb 32
str1 resb 40
length resb 40
str_length resb 40

