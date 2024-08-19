;bits3.asm
extern printb
extern printf
section .data
    msg1    db  "No bits are set:",10,0
    msg2    db  10,"Set bit #4, that is the 5th bit:",10,0
    msg3    db  10,"Set bit #7, that is the 8th bit:",10,0
    msg4    db  10,"Set bit #8, that is the 9th bit:",10,0
    msg5    db  10,"Set bit #61, that is the 62nd bit:",10,0
    msg6    db  10,"Clear bit #8, that is the 9th bit:",10,0
    msg7    db  10,"Test bit #61, and display rdi",10,0
    bitflags    dq  0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    ; Вывод заголовка
    mov rdi, msg1
    xor rax, rax
    call printf
    ; Вывод переменной bitflags
    mov rdi, [bitflags]
    call printb
    ; Установить в 1 бит 4 (== 5-й бит)
    ; Вывод заголовка
    mov rdi, msg2
    xor rax, rax
    call printf
    bts qword[bitflags], 4      ; Установить бит 4
    ; Вывод переменной bitflags
    mov rdi, [bitflags]
    call printb
    ; Установить в 1 бит 7 (== 8-й бит)
    ; Вывод заголовка
    mov rdi, msg3
    xor rax, rax
    call printf
    bts qword[bitflags], 7      ; Установить бит 7
    ; Вывод переменной bitflags
    mov rdi, [bitflags]
    call printb
    ; Установить в 1 бит 8 (== 9 бит)
    ; Вывод заголовка
    mov rdi, msg4
    xor rax, rax
    call printf
    bts qword[bitflags], 8      ; Установить бит 8
    ; вывод переменной bitflags
    mov rdi, [bitflags]
    call printb
    ; Установить в 1 бит 61 (== 62-й бит)
    ; Вывод заголовка
    mov rdi, msg5
    xor rax, rax
    call printf
    bts qword[bitflags], 61     ; Установить бит 61
    ; вывод bitlfags
    mov rdi, [bitflags]
    call printb
    ; Очистить бит 8 (==9-ый бит)
    ; Вывод заголовка
    mov rdi, msg6
    xor rax, rax
    call printf
    btr qword[bitflags], 8          ; сброс бита 8
    ; вывод bitflags
    mov rdi, [bitflags]
    call printb
    ; Проверка бита 61 (будет установлен в 1 флан переноса CF, если бит равен 1)
    ; Вывод заголовка
    mov rdi, msg7
    xor rax, rax
    call printf
    xor rdi, rdi
    mov rax, 61         ; нужно проверить бит 61
    xor rdi, rdi        ; чтобы все биты были равны 0
    bt [bitflags], rax  ; проверка бита
    setc dil        ; установить dil (=младший rdi) в 1, если CF установлен
    call printb
    leave
    ret