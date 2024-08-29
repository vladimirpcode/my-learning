; begin10.asm
; Даны два ненулевых числа. Найти сумму, разность, 
; произведение и частное их квадратов.

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "a = ",10,0
    enter_msg2   db  "b = ",10,0
    result_msg1  db  "a^2 + b^2 = %f",10,0
    result_msg2  db  "a^2 - b^2 = %f",10,0
    result_msg3  db  "a^2 * b^2 = %f",10,0
    result_msg4  db  "a^2 / b^2 = %f",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd xmm8, xmm0
    pushxmm xmm8
    printmsg enter_msg2
    call input_double
    movsd xmm9, xmm0
    popxmm xmm8
    mulsd xmm8, xmm8
    mulsd xmm9, xmm9
    movsd xmm0, xmm8
    addsd xmm0, xmm9
    mov rdi, result_msg1
    mov rax, 1
    pushxmm xmm8
    pushxmm xmm9
    call printf
    popxmm xmm9
    popxmm xmm8
    movsd xmm0, xmm8
    subsd xmm0, xmm9
    mov rdi, result_msg2
    mov rax, 1
    pushxmm xmm8
    pushxmm xmm9
    call printf
    popxmm xmm9
    popxmm xmm8
    movsd xmm0, xmm8
    mulsd xmm0, xmm9
    mov rdi, result_msg3
    mov rax, 1
    pushxmm xmm8
    pushxmm xmm9
    call printf
    popxmm xmm9
    popxmm xmm8
    movsd xmm0, xmm8
    divsd xmm0, xmm9
    mov rdi, result_msg4
    mov rax, 1
    pushxmm xmm8
    pushxmm xmm9
    call printf
    popxmm xmm9
    popxmm xmm8
    leave
    ret