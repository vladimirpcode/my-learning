; begin18.asm
; даны три точки A, B, C на числовой оси. Точка C расположена
; между точками A и B. Найти произведение длин отрезков AC и BC.

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "A = ",10,0
    enter_msg2   db  "B = ",10,0
    enter_msg3   db  "C = ",10,0
    result_msg  db  "AC * BC = %f",10,0
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
    movsd xmm10, xmm0
    popxmm xmm9
    popxmm xmm8
    movsd xmm1, xmm8
    subsd xmm1, xmm10
    abs_xmm_via_xmm0 xmm1
    movsd xmm11, xmm1
    movsd xmm1, xmm9
    subsd xmm1, xmm10
    abs_xmm_via_xmm0 xmm1
    movsd xmm0, xmm1
    mulsd xmm0, xmm11
    mov rdi, result_msg
    mov rax, 1
    call printf
    leave
    ret