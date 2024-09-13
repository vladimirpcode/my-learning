; integer16.asm
; Дано трехзначное число. Вывести число, полученное при перестановке
; цифр десятков и единиц исходного числа (например, 123 перейдет в 132).
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter three digit number: ",10,0
    result_msg1  db "Result number: %d",10,0
section .bss
    left_digit      resq 1
    middle_digit    resq 1
    right_digit     resq 1
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
    mov [left_digit], rax
    mov rax, rdx
    mov rdx, 0
    mov rdi, 10
    idiv rdi
    mov [middle_digit], rax
    mov [right_digit], rdx
    mov rax, [left_digit]
    imul rax, 100
    mov rsi, rax        ; сотни
    mov rax, [right_digit]
    imul rax, 10
    add rax, [middle_digit]
    add rsi, rax
    mov rdi, result_msg1
    mov rax, 0
    call printf
    leave
    ret