; begin39.asm
; Найти корни квадратного уравнения A·x2 + B·x + C = 0, 
; заданного своими коэффициентами A, B, C (коэффициент A != 0),
; если известно, что дискриминант уравнения положителен. 
; Вывести вначале меньший, а затем больший из найденных корней.
; Корни квадратного уравнения находятся по формуле
; x1, x2 = (−B ± √D)/(2·A),
;где D — дискриминант, равный B^2 − 4·A·C. 

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "A = ",10,0
    enter_msg2 db "B = ",10,0
    enter_msg3 db "C = ",10,0
    result_msg1 db "x1 = %f",10,0
    result_msg2 db "x2 = %f",10,0
section .bss
    A resq 1
    B resq 1
    C resq 1
    D resq 1
    x1 resq 1
    x2 resq 1
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
    printmsg enter_msg3
    call input_double
    movsd [C], xmm0
    movsd xmm0, [B]
    mulsd xmm0, xmm0                ; B^2
    int_to_double_via_rax xmm1, 4
    mulsd xmm1, [A]
    mulsd xmm1, [C]
    subsd xmm0, xmm1                ; B^2-4AC
    movsd [D], xmm0
    movsd xmm0, [B]
    int_to_double_via_rax xmm1, -1
    mulsd xmm0, xmm1
    movsd xmm1, [D]
    sqrtsd xmm1, xmm1
    movsd xmm8, xmm0
    addsd xmm0, xmm1    ; -B + sqrt(D)
    movsd [x1], xmm0
    movsd xmm0, xmm8
    subsd xmm0, xmm1    ; -B - sqrt(D)
    movsd [x2], xmm0
    int_to_double_via_rax xmm1, 2
    mulsd xmm1, [A]
    movsd xmm0, [x1]
    divsd xmm0, xmm1
    movsd [x1], xmm0
    movsd xmm0, [x2]
    divsd xmm0, xmm1
    movsd [x2], xmm0
    movsd xmm0, [x2]
    mov rdi, result_msg1
    mov rax, 1
    call printf
    movsd xmm0, [x1]
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret