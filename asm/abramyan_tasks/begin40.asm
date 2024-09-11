; begin40.asm
; Найти решение системы линейных уравнений вида
; A1·x + B1·y = C1,
; A2·x + B2·y = C2,
; заданной своими коэффициентами A1, B1, C1, A2, B2, C2, 
; если известно, что данная система имеет единственное решение. 
; Воспользоваться формулами
; x = (C1·B2 − C2·B1)/D, y = (A1·C2 − A2·C1)/D,
; где D = A1·B2 − A2·B1.

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "A1 = ",10,0
    enter_msg2 db "B1 = ",10,0
    enter_msg3 db "C1 = ",10,0
    enter_msg4 db "A2 = ",10,0
    enter_msg5 db "B2 = ",10,0
    enter_msg6 db "C2 = ",10,0
    result_msg1 db "x = %f",10,0
    result_msg2 db "y = %f",10,0
section .bss
    A1 resq 1
    B1 resq 1
    C1 resq 1
    A2 resq 1
    B2 resq 1
    C2 resq 1
    D resq 1
    x resq 1
    y resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [A1], xmm0
    printmsg enter_msg2
    call input_double
    movsd [B1], xmm0
    printmsg enter_msg3
    call input_double
    movsd [C1], xmm0
    printmsg enter_msg4
    call input_double
    movsd [A2], xmm0
    printmsg enter_msg5
    call input_double
    movsd [B2], xmm0
    printmsg enter_msg6
    call input_double
    movsd [C2], xmm0
    movsd xmm0, [A1]
    mulsd xmm0, [B2]
    movsd xmm1, [A2]
    mulsd xmm1, [B1]
    subsd xmm0, xmm1
    movsd [D], xmm0
    movsd xmm0, [C1]
    mulsd xmm0, [B2]
    movsd xmm1, [C2]
    mulsd xmm1, [B1]
    subsd xmm0, xmm1
    divsd xmm0, [D]
    movsd [x], xmm0
    movsd xmm0, [A1]
    mulsd xmm0, [C2]
    movsd xmm1, [A2]
    mulsd xmm1, [C1]
    subsd xmm0, xmm1
    divsd xmm0, [D]
    movsd [y], xmm0
    movsd xmm0, [x]
    mov rdi, result_msg1
    mov rax, 1
    call printf
    movsd xmm0, [y]
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret