; integer24.asm
;  Дни недели пронумерованы следующим образом: 
; 0 — воскресенье,1 — понедельник, 2 — вторник, 
; . . . , 6 — суббота.
; Дано целое число K, лежащее в диапазоне 1–365. 
; Определить номер дня недели для K-го дня года, 
; если известно, что в этом году 1 января было понедельником.
%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg1   db "Enter K (day number): ",10,0
    result_msg1  db "Day of week number: %d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_int
    mov rdi, 7
    mov rdx, 0
    idiv rdi
    mov rsi, rdx
    mov rdi, result_msg1
    mov rax, 0
    call printf
    leave
    ret