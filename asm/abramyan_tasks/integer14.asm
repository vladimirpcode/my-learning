; integer14.asm
; Дано трехзначное число. В нем зачеркнули первую справа цифру
; и приписали ее слева. Вывести полученное число.

%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter three digit number: ",10,0
    result_msg1  db "Result number: %d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_int
    mov rdx, 0
    mov rdi, 10
    idiv rdi
    mov rsi, rax
    mov rax, rdx
    mov rdi, 100
    imul rdi
    add rsi, rax
    mov rdi, result_msg1
    mov rax, 0
    call printf
    leave
    ret