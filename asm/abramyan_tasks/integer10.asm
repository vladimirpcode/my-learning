; integer10.asm
; Дано трехзначное число. Вывести вначале его последнюю цифру
; (единицы), а затем — его среднюю цифру (десятки)
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter three digit number: ",10,0
    result_msg1  db "Right digit: %d",10,0
    result_msg2  db "Middle digit: %d",10,0
section .bss
    middle_digit resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_int
    mov rdi, 100
    idiv rdi
    mov rax, rdx
    mov rdi, 10
    mov rdx, 0
    idiv rdi
    mov [middle_digit], rax
    mov rsi, rdx
    mov rdi, result_msg1
    mov rax, 0
    call printf
    mov rdi, result_msg2
    mov rsi, [middle_digit]
    mov rax, 0
    call printf
    leave
    ret