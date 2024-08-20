;Write an X86/64 ALP to count number of positive and negative numbers from the array

global _start
_start:

section .text
mov rsi,arr

back1: mov rax,[rsi]

bt rax,63
jc n1
inc byte[pcnt]
jmp next

n1:inc byte[ncnt]

next: add rsi,8
dec byte[cnt]
jnz back1

;Displaying the Positive count
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

mov rax,[pcnt]
call display

;Displaying the Negative count
mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

mov rax,[ncnt]
call display

;Exit Procedure
mov rax,60
mov rdi,0
syscall

;Display Procedure
display:
mov rsi,disparr+15
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

mov rax,1
mov rdi,1
mov rsi,msg3
mov rdx,len3
syscall

ret


section .data
arr dq 1234567812345678H,8765432187654321H,9876987698769876H,2468246824682468H,3690369036903690H
cnt db 05H
msg1 db "Positive Count",0AH
len1 equ $-msg1
msg2 db "Negative Count",0AH
len2 equ $-msg2
msg3 db " ",0AH
len3 equ $-msg3

section .bss
disparr resb 32/lk
ncnt resb 10
pcnt resb 10

