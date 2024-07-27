; memory.asm
section .data
    bNum    db  123
    wNum    dw  12345
    warray  times   5 dw 0  ; Массив из 5 слов, содержащих 0
    dNum    dd  12345
    qNum    dq  12345
    text1   db  "abc",0
    qNum2   dq  3.141592654
    text2   db  "cde",0
section .bss
    bvar    resb    1
    dvar    resd    1
    wvar    resw    10
    qvar    resq    3
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    lea rax, [bNum]     ;Загрузка адреса bNum в регистр rax
    mov rax, bNum       ;Загрузка адреса bNum в регистр rax
    mov rax, [bNum]     ;Загрузка значения bNum в регистр rax
    mov [bvar], rax     ;Загрузка из регистра rax в адрес памяти bvar
    lea rax, [bvar]     ;Загрузка адреса bvar в регистр rax
    lea rax, [wNum]     ;Загрузка адреса wNum в регистр rax
    mov rax, [wNum]     ;Загрузка содержимого wNum в регистр rax
    lea rax, [text1]    ;Загрузка адреса text1 в регистр rax
    mov rax, text1      ;Загрузка адреса text1 в регистр rax
    mov rax, text1+1    ;Загрузка второго символа в регистр rax
    lea rax, [text1+1]   ;Загрузка второго символа в регистр rax
    mov rax, [text1]    ;Загрузка, начиная с адреса text1, в регистр rax
    mov rax, [text1+1]  ;Загрузка, начиная с адреса text1+1, в регистр rax
    mov rsp, rbp
    pop rbp
    ret
