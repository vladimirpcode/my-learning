; integer5.asm
; Даны целые положительные числа A и B (A > B). На отрезке длины A
; размещено максимально возможное количество отрезков длины B (без
; наложений). Используя операцию взятия остатка от деления нацело, найти
; длину незанятой части отрезка A
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "A = ",10,0
    enter_msg2   db "B = ",10,0
    result_msg  db "Length of unoccupied part: %d",10,0
section .bss
    A resq 1
    B resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_int
    mov [A], rax
    printmsg enter_msg2
    call input_int
    mov [B], rax
    mov rax, [A]
    mov rsi, [B]
    mov rdx, 0
    idiv rsi
    mov rsi, rdx
    mov rdi, result_msg
    mov rax, 0
    call printf
    leave
    ret