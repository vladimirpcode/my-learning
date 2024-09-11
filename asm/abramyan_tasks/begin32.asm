; begin32.asm
;  Дано значение температуры T в градусах Цельсия. 
; Определить значение этой же температуры в градусах Фаренгейта. 
; Температура по Цельсию TC и температура по Фаренгейту TF 
; связаны следующим соотношением:
; TC = (TF − 32)·5/9.
%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "Enter temperature in degrees Celsius: ",10,0
    result_msg1 db "Temperature in degrees Fahrenheit: %f",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    int_to_double_via_rax xmm8, 5
    int_to_double_via_rax xmm9, 9
    divsd xmm8, xmm9
    divsd xmm0, xmm8
    int_to_double_via_rax xmm8, 32
    addsd xmm0, xmm8
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret