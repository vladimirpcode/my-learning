%macro  pushxmm 1
    section .text
        sub rsp, 16
        movsd  qword [rsp], %1
%endmacro

%macro  popxmm 1
    section .text
        movsd  %1, qword [rsp]
        add rsp, 16
%endmacro

%macro int_to_double_via_rax 2
    section .text
        mov rax, %2
        cvtsi2sd %1, rax
%endmacro
