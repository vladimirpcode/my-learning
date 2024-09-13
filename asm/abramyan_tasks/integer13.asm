; integer13.asm
; Дано трехзначное число. В нем зачеркнули первую слева цифру и
; приписали ее справа. Вывести полученное число

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
    mov rdi, 10
    imul rdi
    add rax, [left_digit]
    mov rsi, rax
    mov rdi, result_msg1
    mov rax, 0
    call printf
    leave
    ret