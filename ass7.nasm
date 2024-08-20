;Write X86/64 ALP to perform non-overlapped block transfer without string specific instructions. Block containing data can 
;be defined in the data segment. 

global _start
_start:

section .text

mov rsi,sarr
mov rdi,darr

back1: mov al,[rsi]
mov [rdi],al
inc rsi
inc rdi
dec byte[cnt1]
jnz back1

;Printing the Destination Array
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

;Destination Array
mov rsi,darr
back2:mov al,[rsi]
push rsi
call display
pop rsi
inc rsi
dec byte[cnt2]
jnz back2

mov rax,60
mov rdi,0
syscall

;Display procedure
display:
mov rsi,disparr+1
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

mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

ret


section .data

sarr db 01H,02H,03H,04,05H,06H,07H,08H,09H,0AH
darr db 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
cnt1 db 0AH
cnt2 db 0AH

msg1 db "Destination Array is : "
len1 equ $-msg1

msg2 db "  ",0AH
len2 equ $-msg2

section .bss
disparr resb 32


