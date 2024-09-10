; begin16.asm
; Найти расстояние между двумя точками с заданными 
; координатами x1 и x2 на числовой оси: |x2 − x1|.

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "x1 = ",10,0
    enter_msg2   db  "x2 = ",10,0
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
    popxmm xmm1
    subsd xmm0, xmm1
    movsd xmm1, xmm0
    abs_xmm_via_xmm0 xmm1
    movsd xmm0, xmm1
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret