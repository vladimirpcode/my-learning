; integer9.asm
; Дано трехзначное число. Используя одну операцию деления нацело,
; вывести первую цифру данного числа (сотни)
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter three digit number: ",10,0
    result_msg1  db "First digit: %d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_int
    mov rdi, 100
    mov rdx, 0
    idiv rdi
    mov rdi, result_msg1
    mov rsi, rax
    mov rax, 0
    call printf
    leave
    ret