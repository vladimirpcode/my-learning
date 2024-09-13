; integer6.asm
; Дано двузначное число. Вывести вначале его левую цифру (десятки), 
; а затем — его правую цифру (единицы). Для нахождения десятков
; использовать операцию деления нацело, для нахождения единиц — опе-
; рацию взятия остатка от деления.
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter two digit number: ",10,0
    result_msg1  db "Left digit: %d",10,0
    result_msg2  db "Right digit: %d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_int
    mov rdi, 10
    mov rdx, 0
    idiv rdi
    mov rdi, result_msg1
    mov rsi, rax
    push rdx
    push rdx
    mov rax, 0
    call printf
    pop rdx
    pop rdx
    mov rdi, result_msg2
    mov rsi, rdx
    mov rax, 0
    call printf
    leave
    ret