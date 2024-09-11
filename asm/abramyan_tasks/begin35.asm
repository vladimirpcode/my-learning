; begin35.asm
; Скорость лодки в стоячей воде V км/ч, 
; скорость течения реки U км/ч (U < V ). 
; Время движения лодки по озеру T1 ч, 
; а по реке (против течения)— T2 ч. 
; Определить путь S, пройденный лодкой (путь = время · скорость).
; Учесть, что при движении против течения скорость лодки 
; уменьшается на величину скорости течения

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "V = ",10,0
    enter_msg2 db "U = ",10,0
    enter_msg3 db "T1 = ",10,0
    enter_msg4 db "T2 = ",10,0
    result_msg1 db "S = %f",10,0
section .bss
    V resq 1
    U resq 1
    T1 resq 1
    T2 resq 1
    S_lake resq 1
    S_river resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [V], xmm0
    printmsg enter_msg2
    call input_double
    movsd [U], xmm0
    printmsg enter_msg3
    call input_double
    movsd [T1], xmm0
    printmsg enter_msg4
    call input_double
    movsd [T2], xmm0
    movsd xmm0, [V]
    mulsd xmm0, [T1]
    movsd [S_lake], xmm0
    movsd xmm0, [V]
    subsd xmm0, [U]
    mulsd xmm0, [T2]
    addsd xmm0, [S_lake]
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret