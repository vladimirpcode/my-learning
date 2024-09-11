; begin38.asm
; Решить линейное уравнение A·x + B = 0,заданное своими 
; коэффициентами A и B (коэффициент A не равен 0) 

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "A = ",10,0
    enter_msg2 db "B = ",10,0
    result_msg1 db "x = %f",10,0
section .bss
    A resq 1
    B resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [A], xmm0
    printmsg enter_msg2
    call input_double
    movsd [B], xmm0
    int_to_double_via_rax xmm1, -1
    mulsd xmm0, xmm1
    divsd xmm0, [A]
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret