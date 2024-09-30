; integer19.asm
; С начала суток прошло N секунд (N — целое). 
; Найти количество полных минут, прошедших с начала суток.
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter N (sec): ",10,0
    result_msg1  db "minutes: %d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_int
    mov rdi, 60
    mov rdx, 0
    idiv rdi
    mov rsi, rax
    mov rdi, result_msg1
    mov rax, 0
    call printf
    leave
    ret