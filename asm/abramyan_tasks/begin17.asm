; begin17.asm
; Даны три точки A, B, C на числовой оси. 
; Найти длины отрезков AC и BC и их сумму

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "A = ",10,0
    enter_msg2   db  "B = ",10,0
    enter_msg3   db  "C = ",10,0
    result_msg1  db  "AC = %f",10,0
    result_msg2  db  "BC = %f",10,0
    result_msg3  db  "AC + BC = %f",10,0
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
    pushxmm xmm0
    printmsg enter_msg3
    call input_double
    pushxmm xmm0
    popxmm xmm10
    popxmm xmm9
    popxmm xmm8
    movsd xmm1, xmm8
    subsd xmm1, xmm10
    abs_xmm_via_xmm0 xmm1
    movsd xmm0, xmm1
    mov rdi, result_msg1
    mov rax, 1
    pushxmm xmm10
    pushxmm xmm9
    pushxmm xmm8
    pushxmm xmm0
    call printf
    popxmm xmm11
    popxmm xmm8
    popxmm xmm9
    popxmm xmm10
    movsd xmm1, xmm9
    subsd xmm1, xmm10
    abs_xmm_via_xmm0 xmm1
    movsd xmm0, xmm1
    mov rdi, result_msg2
    mov rax, 1
    pushxmm xmm10
    pushxmm xmm9
    pushxmm xmm8
    pushxmm xmm11
    pushxmm xmm0
    call printf
    popxmm xmm12
    popxmm xmm11
    popxmm xmm8
    popxmm xmm9
    popxmm xmm10
    movsd xmm0, xmm11
    addsd xmm0, xmm12
    mov rdi, result_msg3
    mov rax, 1
    call printf
    leave
    ret