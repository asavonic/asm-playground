.text                         # section declaration

                              # we must export the entry point to the ELF linker or
  .global main                # loader. They conventionally recognize _start as their
                              # entry point. Use ld -e foo to override the default.

main:
  pushq	%rbp
  movq	%rsp, %rbp

  movq	$msg, %rdi           # pass arguments through:
                             # %rdi, %rsi, %rdx, %rcx, %r8, %r9
                             # others push to stack
  xor   %rax, %rax           # and also zero %rax (number of vector arguments)
  call	printf

  movq  $0, %rdi             # flush all
  call  fflush

  movq  $1, %rax             # normal exit
  movq  $0, %rbx
  int   $0x80

.data                         # section declaration

msg:
  .ascii    "Hello, world!\n" # our dear string
len = . - msg                 # length of our dear string
