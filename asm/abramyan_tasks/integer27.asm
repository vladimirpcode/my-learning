; integer27.asm
;  Дни недели пронумерованы следующим образом: 1 — понедельник,
;  2 — вторник, . . . , 6 — суббота, 7 — воскресенье. 
; Дано целое число K, лежащее в диапазоне 1–365. 
; Определить номер дня недели для K-го дня года, 
; если известно, что в этом году 1 января было субботой.

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
    add rax, 4
    mov rdi, 7
    mov rdx, 0
    idiv rdi
    add rdx, 1
    mov rsi, rdx
    mov rdi, result_msg1
    call printf
    leave
    ret