; begin13.asm
; Даны два круга с общим центром и радиусами R1 и R2 (R1 > R2).
; Найти площади этих кругов S1 и S2, а также площадь S3 кольца, внешний
; радиус которого равен R1, а внутренний радиус равен R2

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "R1 = ",10,0
    enter_msg2   db  "R2 = ",10,0
    result_msg1  db  "S1 = %f",10,0
    result_msg2  db  "S2 = %f",10,0
    result_msg3  db  "S3 = %f",10,0
    pi           dq  3.14
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
    movsd xmm1, [pi]
    mulsd xmm0, xmm1
    mov rdi, result_msg1
    mov rax, 1
    pushxmm xmm8
    pushxmm xmm9
    pushxmm xmm0
    call printf
    popxmm xmm10
    popxmm xmm9
    popxmm xmm8
    movsd xmm1, [pi]
    movsd xmm0, xmm9
    mulsd xmm0, xmm0
    mulsd xmm0, xmm1
    mov rdi, result_msg2
    mov rax, 1
    pushxmm xmm8
    pushxmm xmm9
    pushxmm xmm10
    pushxmm xmm0
    call printf
    popxmm xmm11
    popxmm xmm10
    popxmm xmm9
    popxmm xmm8
    movsd xmm0, xmm10
    subsd xmm0, xmm11
    mov rdi, result_msg3
    mov rax, 1
    call printf
    leave
    ret