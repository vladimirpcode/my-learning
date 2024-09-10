; begin19.asm
; Даны координаты двух противоположных вершин прямоугольника:
; (x1, y1), (x2, y2). Стороны прямоугольника параллельны осям координат.
; Найти периметр и площадь данного прямоугольника

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "x1 = ",10,0
    enter_msg2   db  "y1 = ",10,0
    enter_msg3   db  "x2 = ",10,0
    enter_msg4   db  "y2 = ",10,0
    result_msg1  db  "P = %f",10,0
    result_msg2  db  "S = %f",10,0
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
    movsd xmm1, xmm8
    subsd xmm1, xmm10
    abs_xmm_via_xmm0 xmm1
    movsd xmm12, xmm1
    movsd xmm1, xmm9
    subsd xmm1, xmm11
    abs_xmm_via_xmm0 xmm1
    movsd xmm13, xmm1
    addsd xmm1, xmm12
    int_to_double_via_rax xmm0, 2
    mulsd xmm0, xmm1
    mov rdi, result_msg1
    mov rax, 1
    pushxmm xmm12
    pushxmm xmm13    
    call printf
    popxmm xmm13
    popxmm xmm12
    movsd xmm0, xmm12
    mulsd xmm0, xmm13
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret