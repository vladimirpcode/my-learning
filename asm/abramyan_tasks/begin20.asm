; begin20.asm
; Найти расстояние между двумя точками с заданными координатами
; (x1, y1) и (x2, y2) на плоскости. Расстояние вычисляется по формуле

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "x1 = ",10,0
    enter_msg2   db  "y1 = ",10,0
    enter_msg3   db  "x2 = ",10,0
    enter_msg4   db  "y2 = ",10,0
    result_msg1  db  "distance = %f",10,0
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
    printmsg enter_msg4
    call input_double
    pushxmm xmm0
    popxmm xmm11
    popxmm xmm10
    popxmm xmm9
    popxmm xmm8
    movsd xmm0, xmm10
    subsd xmm0, xmm8
    mulsd xmm0, xmm0
    movsd xmm1, xmm11
    subsd xmm1, xmm9
    mulsd xmm1, xmm1
    addsd xmm0, xmm1
    sqrtsd xmm0, xmm0
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret