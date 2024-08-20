;Write X86/64 ALP to perform overlapped block transfer with string specific instructions. Block containing data can 
;be defined in the data segment. 

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

dispmsg msg1,len1
mov rsi,arr
mov rdi,arr
add rsi,9
add rdi,13
mov rcx,0AH
std
rep movsb

mov rsi,arr
back1: mov rax,[rsi]
push rsi
call display
pop rsi
inc rsi
dec byte[cnt1]
jnz back1

mov rax,60
mov rdi,0
syscall

;Display procedure
display:
mov rsi,disparr+1
mov rcx,2
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
mov rdx,2
syscall

mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall
ret

section .data
arr db 01H,02H,03H,04H,05H,06H,07H,08H,09H,0AH,0BH,0CH,0DH,0EH,0FH
cnt1 db 15
msg1 db "Block is : "
len1 equ $-msg1
msg2 db "  ",0AH
len2 equ $-msg2


section .bss
disparr resb 32
