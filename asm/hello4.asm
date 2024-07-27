; hello4.asm
extern printf       ; объявление фукнции как внешней
section .data
    msg     db  "Hello, World!",0
    fmtstr  db  "This is our string: %s",10,0   ; формат вывода строки
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    mov rdi, fmtstr     ; 1-ый арг для printf
    mov rsi, msg        ; 2-ой арг для printf
    mov rax, 0          ; регистры xmm не применяются
    call printf         ; вызов внешней функции
    mov rsp, rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall