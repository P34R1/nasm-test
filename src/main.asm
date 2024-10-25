section .data
  ;Constants
  msg: db  "Hello, World!", 0xa ; newline at end
  len: equ $ - msg              ; get length
  filename: db "output.txt", 0 ; Filename string, null-terminated


section .bss
  ;variables
  fileptr resq 1 ; Reserve space for the file descriptor (64 bits)


section .text
  global _start

  _start:

  mov rdx, 0o644        ; mode: rw-r--r-- (octal 644)
  mov rsi, 0x241        ; flags: O_CREAT | O_WRONLY | O_TRUNC (0x241)
  mov rdi, filename
  mov rax, 2            ; sys_open system call number is 2
  syscall
  mov [fileptr], rax  ; store the file descriptor in [fileptr]


  mov rdx,len ;message length
  mov rsi,msg ;message to write
  mov rdi,[fileptr] ;file descriptor (output.txt)
  mov rax,1   ;system call number (sys_write)
  syscall     ;call kernel

  ; Close the file (sys_close)
  mov rax, 3                    ; sys_close system call number is 3
  mov rdi, [fileptr]            ; file descriptor to close
  syscall

  ; Exit via the kernel:

  mov rdi,0   ;process' exit code
  mov rax,60  ;system call number (sys_exit)
  syscall     ;call kernel - this interrupt won't return
