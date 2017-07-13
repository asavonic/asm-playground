.text                                # section declaration

                                     # we must export the entry point to the ELF linker or
  .global main                       # loader. They conventionally recognize _start as their
                                     # entry point. Use ld -e foo to override the default.

main:
        pushq	%rbp
        movq	%rsp, %rbp

        movq    $0, %rcx             # accumulator
        movq    $0, %rax             # i
        movq    $5, %rbx             # iterations
loop_body:
        cmp     %rax, %rbx
        je      loop_exit

        addq    $2, %rcx             # actual loop body

        inc     %rax
        jmp     loop_body
loop_exit:

        movq    %rcx, %rdx
        movq    $10, %rsi
        movq	$msg, %rdi           # pass arguments through:
        call	printf               # %rdi, %rsi, %rdx, %rcx, %r8, %r9
                                     # others push to stack

        movq  $0, %rdi               # flush all
        call  fflush

        movq  $1, %rax               # normal exit
        movq  $0, %rbx
        int   $0x80


.data                                # section declaration

msg:
       .ascii    "Loop result expected %d, got %d\n" # our dear string
len = . - msg                 # length of our dear string
