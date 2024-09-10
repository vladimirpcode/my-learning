; begin12.asm
; Даны катеты прямоугольного треугольника a и b. 
; Найти его гипотенузу c и периметр P

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "a = ",10,0
    enter_msg2   db  "b = ",10,0
    result_msg1  db  "c = %f",10,0
    result_msg2  db  "P = %f",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    pushxmm xmm0
    printmsg enter_msg2
    call input_double
    movsd xmm9, xmm0
    popxmm xmm8
    movsd xmm0, xmm8
    mulsd xmm0, xmm0
    movsd xmm10, xmm9
    mulsd xmm10, xmm10
    addsd xmm0, xmm10
    sqrtsd xmm0, xmm0
    mov rdi, result_msg1
    mov rax, 1
    pushxmm xmm8
    pushxmm xmm9
    pushxmm xmm0
    call printf
    popxmm xmm0
    popxmm xmm9
    popxmm xmm8
    addsd xmm0, xmm8
    addsd xmm0, xmm9
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret