;Write an X86/64 ALP to accept five 64 bit Hexadecimal numbers from user and store them in an array and display the
;accepted  numbers.

global _start
_start:

section .text

;Display Message 
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

;Point rsi to base address of array
mov rsi,arr
l1:mov rax,[rsi]
push rsi
call display
pop rsi

;Move rsi to next element 
add rsi,8
dec byte[cnt]
jnz l1

;Exiting the program 
mov rax,60
mov rdi,0
syscall

;Display procedure
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
mov rsi,msg2
mov rdx,len2
syscall
ret

section .data
arr dq 1234567812345678H,1122334411223344H,9988776699887766H,2244668822446688H,1133557711335577H,2211443366558877H,0AABBCCDDAABBCCDDH,0FFEECCDDFFEECCDDH,0ABCDEFABCDEFABCDH,00123456789ABCDEFH
cnt db 10
msg1 db "Array Elements are : "
len1 equ $-msg1
msg2 db " ",0AH
len2 equ $-msg2

section .bss
disparr resb 32

