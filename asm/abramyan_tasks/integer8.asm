; integer8.asm
; Дано двузначное число. Вывести число, 
; полученное при перестановке цифр исходного числа.
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter two digit number: ",10,0
    result_msg1  db "Reversed number: %d",10,0
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
    mov rax, [right_digit]
    mov rsi, 10
    imul rsi
    add rax, [left_digit]
    mov rsi, rax
    mov rdi, result_msg1
    mov rax, 0
    call printf
    leave
    ret