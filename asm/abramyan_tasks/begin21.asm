; begin21.asm
; Даны координаты трех вершин треугольника: (x1, y1), (x2, y2), (x3, y3).
; Найти его периметр и площадь, используя формулу для расстояния между 
; двумя точками на плоскости (см. задание Begin20). Для нахождения
; площади треугольника со сторонами a, b, c использовать формулу Герона:
; S = √p·(p − a)·(p − b)·(p − c)

%include "xmm.asm"
%include "print.asm"

; (dst, x1,y1,x2,y2)
%macro fdistance_via_xmm1 5
    section .text
        movsd %1, %4
        subsd %1, %2
        mulsd %1, %1
        movsd xmm1, %5
        subsd xmm1, %3
        mulsd xmm1, xmm1
        addsd %1, xmm1
        sqrtsd %1, %1
%endmacro

extern input_double
extern printf
section .data
    enter_msg1   db  "x1 = ",10,0
    enter_msg2   db  "y1 = ",10,0
    enter_msg3   db  "x2 = ",10,0
    enter_msg4   db  "y2 = ",10,0
    enter_msg5   db  "x3 = ",10,0
    enter_msg6   db  "y3 = ",10,0
    result_msg1  db  "P = %f",10,0
    result_msg2  db  "S = %f",10,0
section .bss
    perimeter resq 1
    semiperimeter resq 1
    p_minus_a resq 1
    p_minus_b resq 1
    p_minus_c resq 1
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
    printmsg enter_msg5
    call input_double
    pushxmm xmm0
    printmsg enter_msg6
    call input_double
    pushxmm xmm0
    popxmm xmm13
    popxmm xmm12
    popxmm xmm11
    popxmm xmm10
    popxmm xmm9
    popxmm xmm8
    fdistance_via_xmm1 xmm14, xmm8, xmm9,xmm10,xmm11
    fdistance_via_xmm1 xmm15, xmm8, xmm9,xmm12,xmm13
    fdistance_via_xmm1 xmm3, xmm10, xmm11,xmm12,xmm13
    movsd xmm0, xmm14
    addsd xmm0, xmm15
    addsd xmm0, xmm3
    movsd [perimeter], xmm0
    int_to_double_via_rax xmm1, 2
    divsd xmm0, xmm1
    movsd [semiperimeter], xmm0
    subsd xmm0, xmm14
    movsd [p_minus_a], xmm0
    movsd xmm0, [semiperimeter]
    subsd xmm0, xmm15
    movsd [p_minus_b], xmm0
    movsd xmm0, [semiperimeter]
    subsd xmm0, xmm3
    movsd [p_minus_c], xmm0
    movsd xmm0, [perimeter]
    mov rdi, result_msg1
    mov rax, 1
    call printf
    movsd xmm0, [semiperimeter]
    movsd xmm1, [p_minus_a]
    mulsd xmm0, xmm1
    movsd xmm1, [p_minus_b]
    mulsd xmm0, xmm1
    movsd xmm1, [p_minus_c]
    mulsd xmm0, xmm1
    sqrtsd xmm0, xmm0
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret