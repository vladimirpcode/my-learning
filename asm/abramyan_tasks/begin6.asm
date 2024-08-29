; begin6.asm
; Даны длины ребер a, b, c прямоугольного параллелепипеда. Найти
; его объем V = a·b·c и площадь поверхности S = 2·(a·b + b·c + a·c).

%include "xmm.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "a = ",10,0
    enter_msg2   db  "b = ",10,0
    enter_msg3   db  "c = ",10,0
    result_msg1  db  "V = %f",10,0
    result_msg2  db  "S = %f",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    mov rdi, enter_msg1
    mov rax, 0
    call printf
    call input_double
    movsd xmm8, xmm0
    mov rdi, enter_msg2
    mov rax, 0
    pushxmm xmm8
    call printf
    call input_double
    movsd xmm9, xmm0
    popxmm xmm8
    mov rdi, enter_msg3
    mov rax, 0
    pushxmm xmm8
    pushxmm xmm9
    call printf
    call input_double
    movsd xmm10, xmm0
    popxmm xmm9
    popxmm xmm8
    movsd xmm0, xmm8
    mulsd xmm0, xmm9
    mulsd xmm0, xmm10
    mov rdi, result_msg1
    mov rax, 1
    pushxmm xmm8
    pushxmm xmm9
    pushxmm xmm10
    call printf
    popxmm xmm10
    popxmm xmm9
    popxmm xmm8
    movsd xmm11, xmm8
    mulsd xmm11, xmm9
    movsd xmm12, xmm9
    mulsd xmm12, xmm10
    addsd xmm11, xmm12
    movsd xmm13, xmm8
    mulsd xmm13, xmm10
    addsd xmm11, xmm13
    int_to_double_via_rax xmm0, 2
    mulsd xmm0, xmm11
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret