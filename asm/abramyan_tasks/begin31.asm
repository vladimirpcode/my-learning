; begin31.asm
; Дано значение температуры T в градусах Фаренгейта. 
; Определить значение этой же температуры в градусах Цельсия. 
; Температура по Цельсию TC и температура по Фаренгейту TF 
; связаны следующим соотношением:
; TC = (TF − 32)·5/9.
%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "Enter temperature in degrees Fahrenheit: ",10,0
    result_msg1 db "Temperature in degrees Celsius: %f",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    int_to_double_via_rax xmm1, 32
    subsd xmm0, xmm1
    int_to_double_via_rax xmm8, 5
    int_to_double_via_rax xmm9, 9
    divsd xmm8, xmm9
    mulsd xmm0, xmm8
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret