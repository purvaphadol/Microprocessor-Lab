;Write X86/64 ALP to convert 4-digit Hex number into its equivalent BCD number and 5-digit BCD number into its equivlent HEX
;number. Make your program user friendly to accept the choice from user for : (a) HEX to BCD (b) BCD to HEX (c) EXIT.
;Display proper strings to prompt the user while accepting the input and displaying the result. 

;BCD to HEX

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
mov rsi,array1
back6:push rsi
accept num,01
call convert2
pop rsi

mov bx,[rsi]
mul bx
add [result],ax
inc esi
inc esi
dec byte[cnt2]
jnz back6

dispmsg msg2,len2
mov ax,[result]
call display4

;To exit
mov rax,60
mov rdi,0
syscall

convert2: mov al,[num]
sub al,30H
ret

;Display procedure
display4:
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
msg1 db "Enter 5-digit BCD no. : "
len1 equ $-msg1
msg2 db "Hex is : "
len2 equ $-msg2
array1 dw 2710H,03E8H,0064H,000AH,0001H
cnt2 db 5

section .bss
disparr resb 32
result resb 40
num resb 40



