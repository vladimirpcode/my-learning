; begin36.asm
; Скорость первого автомобиля V 1 км/ч, второго — V 2 км/ч, 
; расстояние между ними S км. Определить расстояние между ними
; через T часов, если автомобили удаляются друг от друга. 
; Данное расстояние равно сумме начального расстояния 
; и общего пути, проделанного автомобилями;
; общий путь = время · суммарная скорость.

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "V1 = ",10,0
    enter_msg2 db "V2 = ",10,0
    enter_msg3 db "S = ",10,0
    enter_msg4 db "T = ",10,0
    result_msg1 db "S after T hours = %f",10,0
section .bss
    V1 resq 1
    V2 resq 1
    S resq 1
    T resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [V1], xmm0
    printmsg enter_msg2
    call input_double
    movsd [V2], xmm0
    printmsg enter_msg3
    call input_double
    movsd [S], xmm0
    printmsg enter_msg4
    call input_double
    movsd [T], xmm0
    movsd xmm0, [V1]
    addsd xmm0, [V2]
    mulsd xmm0, [T]
    addsd xmm0, [S]
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret