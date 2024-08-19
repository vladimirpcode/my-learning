;console2.asm
section .data
    msg1    db  "Hello, World!",10,0
    msg2    db  "Your turn (only a-z): ",0
    msg3    db  "You answered: ",0
    inputlen    equ 10  ; длина буфера ввода
    NL  db  0xa
section .bss
    input resb inputlen+1   ; for /0
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    mov rdi, msg1
    call prints
    mov rdi, msg2
    call prints
    mov rdi, input
    mov rsi, inputlen
    call reads
    mov rdi, msg3
    call prints
    mov rdi, input
    call prints
    mov rdi, NL
    call prints
    leave
    ret
prints:
    push rbp
    mov rbp, rsp
    push r12        ; Регистр, сохраняемый вызываемой функцией
    ; подсчет символов
    xor rdx, rdx
    mov r12, rdi
    .lengthloop:
        cmp byte[r12], 0
        je .lengthfound
        inc rdx
        inc r12
        jmp .lengthloop
    .lengthfound:
    cmp rdx, 0  ; length == 0
    je .done
    mov rsi, rdi
    mov rax, 1  ; 1= write
    mov rdi, 1  ; 1 -stdout
    syscall
    .done:
    pop r12
    leave
    ret
reads:
    section .data
    section .bss
        .inputchar resb 1
    section .text
        push rbp
        mov rbp, rsp
        push r12        ; Регистр, сохраняемый вызываемой функцией
        push r13        ; Регистр, сохраняемый вызываемой функцией
        push r14        ; Регистр, сохраняемый вызываемой функцией
        mov r12, rdi    ; адрес буфера ввода
        mov r13, rsi    ; Максимальная длина в r13
        xor r14, r14    ; Счетчик символов
        .readc:
            mov rax, 0  ; read
            mov rdi, 1  ; stdin
            lea rsi, [.inputchar]   ; куда
            mov rdx, 1              ; сколько
            syscall
            mov al, [.inputchar]    ; Введен символ NL (0xa)?
            cmp al, byte[NL]
            je .done
            cmp al, 97  ; char < 'a'
            jl .readc   ; отбросить символ
            cmp al, 122 ; char > 'z'
            jg .readc   ; отбросить символ
            inc r14     ; увеличить счетчик символов
            cmp r14, r13
            ja .readc   ; максимальное заполнение буфера, отбросить лишнее
            mov byte[r12], al ; сохранить символ в буфере
            inc r12     ; переместить указатель на следующий символ в буфере
            jmp .readc
        .done:
        inc r12
        mov byte [r12], 0
        pop r14
        pop r13
        pop r12
        leave 
        ret