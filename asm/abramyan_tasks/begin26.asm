; begin26.asm
; Найти значение функции y = 4(x−3)^6 − 7(x−3)^3 + 2 
; при данном значении x
%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "x = ",10,0
    result_msg1 db "y = %f",10,0
section .bss
    x resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [x], xmm0
    int_to_double_via_rax xmm1, 3
    subsd xmm0, xmm1
    movsd xmm2, xmm0
    mov rdi, 6
    call fpower
    int_to_double_via_rax xmm1, 4
    mulsd xmm0, xmm1
    movsd xmm8, xmm0
    movsd xmm0, [x]
    int_to_double_via_rax xmm1, 3
    subsd xmm0, xmm1
    movsd xmm2, xmm0
    mov rdi, 3
    pushxmm xmm8
    call fpower
    popxmm xmm8
    int_to_double_via_rax xmm1, 7
    mulsd xmm0, xmm1
    subsd xmm8, xmm0
    int_to_double_via_rax xmm1, 2
    addsd xmm8, xmm1
    movsd xmm0, xmm8
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret