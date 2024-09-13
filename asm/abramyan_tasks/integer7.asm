; integer7.asm
; Дано двузначное число. Найти сумму и произведение его цифр
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter two digit number: ",10,0
    result_msg1  db "Sum of digits: %d",10,0
    result_msg2  db "Product of digits: %d",10,0
section .bss
    left_digit resq 1
    right_digit resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_int
    mov rdi, 10
    mov rdx, 0
    idiv rdi
    mov [left_digit], rax
    mov [right_digit], rdx
    add rax, rdx
    mov rdi, result_msg1
    mov rsi, rax
    mov rax, 0
    call printf
    mov rax, [left_digit]
    mov rdx, [right_digit]
    imul rdx
    mov rdi, result_msg2
    mov rsi, rax
    mov rax, 0
    call printf
    leave
    ret