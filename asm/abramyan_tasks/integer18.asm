; integer18.asm
; Дано целое число, большее 999. Используя одну операцию деления 
; нацело и одну операцию взятия остатка от деления, найти цифру,
; соответствующую разряду тысяч в записи этого числа.
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter number: ",10,0
    result_msg1  db "Result digit: %d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_int
    mov rdx, 0
    mov rdi, 10000
    idiv rdi
    mov rax, rdx
    mov rdx, 0
    mov rdi, 1000
    idiv rdi
    mov rsi, rax
    mov rdi, result_msg1
    mov rax, 0
    call printf
    leave
    ret