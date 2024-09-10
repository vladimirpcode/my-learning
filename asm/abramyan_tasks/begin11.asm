; begin11.asm
; Даны два ненулевых числа. Найти сумму, разность, 
; произведение и частное их модулей

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "a = ",10,0
    enter_msg2   db  "b = ",10,0
    result_msg1  db  "[a] + [b] = %f",10,0
    result_msg2  db  "[a] - [b] = %f",10,0
    result_msg3  db  "[a] * [b] = %f",10,0
    result_msg4  db  "[a] / [b] = %f",10,0
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
    ;pcmpeqd xmm0, xmm0      ; 0xff...
    ;psrld xmm0, 1           ; 0x7fff
    ;andps xmm8, xmm0
    ;andps xmm9, xmm0
    abs_xmm_via_xmm0 xmm8
    abs_xmm_via_xmm0 xmm9
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