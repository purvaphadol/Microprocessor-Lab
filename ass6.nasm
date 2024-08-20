;Write X86/64 ALP to detect protected mode and display the values of GDTR, LDTR, IDTR, TR and MSW. Registers also identify
;CPU type using CPUID instruction.


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

smsw eax
mov [crdata],eax
bt eax,0
jc protected 
dispmsg msg1,len1
jmp exit

protected:dispmsg msg2,len2

dispmsg msg3,len3
mov ax,[crdata+2]
call display4
mov ax,[crdata]
call display4

dispmsg msg4,len4
str[trdata]
mov ax,[trdata]
call display4

dispmsg msg5,len5
sldt [ldtrdata]
mov ax,[ldtrdata]
call display4

dispmsg msg6,len6
sgdt[gdtrdata]
mov ax,[gdtrdata+4]
call display4
mov ax,[gdtrdata+2]
call display4
mov ax,[gdtrdata]
call display4

dispmsg msg7,len7
sidt[idtrdata+4]
call display4
mov ax,[idtrdata+2]
call display4
mov ax,[idtr]
call display4

;To exit
mov rax,60
mov rdi,0
syscall

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
msg1 db "Real Mode"
len1 equ $-msg1
msg2 db "Protected Mode"
len2 equ $-msg2
msg3 db "MSW is : "
len3 equ $-msg3
msg4 db "TR is : "
len4 equ $-msg4
msg5 db "LDTR is : "
len5 equ $-msg5
msg6 db "GDTR is : "
len6 equ $-msg6
msg7 db "IDTR is : "
len7 equ $-msg7

section .bss
disparr resb 32
crdata resb 100
trdata resb 100
ldtrdata resb 100
gdtrdata resb 100
idtrdata resb 100
