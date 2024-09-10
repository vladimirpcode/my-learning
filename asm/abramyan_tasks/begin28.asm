; begin28.asm
; Дано число A. Вычислить A^15, используя две вспомогательные 
; переменные и пять операций умножения. 
; Для этого последовательно находить A^2, A^3, A^5, A^10, A^15. 
; Вывести все найденные степени числа A
%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "a = ",10,0
    result_msg1 db "A^2 = %f",10,0
    result_msg2 db "A^3 = %f",10,0
    result_msg3 db "A^5 = %f",10,0
    result_msg4 db "A^10 = %f",10,0
    result_msg5 db "A^15 = %f",10,0
section .bss
    a resq 1
    temp1 resq 1
    temp2 resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [a], xmm0
    mulsd xmm0, xmm0
    movsd [temp1], xmm0
    mov rdi, result_msg1
    mov rax, 1
    call printf             ; printf a^2 = ...
    movsd xmm0, [a]
    mulsd xmm0, [temp1]     ; a * a^2
    movsd [temp2], xmm0
    mov rdi, result_msg2
    mov rax, 1
    call printf             ; printf a^3 = ...
    movsd xmm0, [temp1]
    mulsd xmm0, [temp2]
    movsd [temp1], xmm0
    mov rdi, result_msg3
    mov rax, 1
    call printf             ; printf a^5
    movsd xmm0, [temp1]
    mulsd xmm0, [temp1]
    movsd [temp2], xmm0
    mov rdi, result_msg4
    mov rax, 1
    call printf             ; printf a^10
    movsd xmm0, [temp1]
    mulsd xmm0, [temp2]
    mov rdi, result_msg5
    mov rax, 1
    call printf
    leave
    ret