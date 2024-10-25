section .data
  ;Constants
  msg: db  "Hello, World!", 0xa ;our dear string
  len: equ $ - msg              ;length of our dear string


section .bss
  ;variables


section .text
  global _start

  _start:

  ; Write the string to stdout:

  mov rdx,len ;message length
  mov rsi,msg ;message to write
  mov rdi,1   ;file descriptor (stdout)
  mov rax,1   ;system call number (sys_write)
  syscall     ;call kernel

  ; Exit via the kernel:

  mov rdi,0   ;process' exit code
  mov rax,60  ;system call number (sys_exit)
  syscall     ;call kernel - this interrupt won't return
