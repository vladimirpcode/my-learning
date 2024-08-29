%macro printmsg 1
    section .text
        mov rdi, %1
        mov rax, 0
        call printf
%endmacro
