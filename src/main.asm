section .data
  ;Constants
  msg: db  "Hello, World!", 0xa ; newline at end
  len: equ $ - msg              ; get length


section .bss
  ;variables
  fileptr resq 1 ; Reserve space for the file descriptor (64 bits)


section .text
  global _start

  ;https://man7.org/linux/man-pages/
  ;https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
  _start:

  ;https://stackoverflow.com/questions/35864291/get-argv2-address-in-assembler-x64
  ; Load the address of argv[1] (the filename) into rdi
  mov rdi, [rsp+16]  ; argv[1] is at offset +8 from rsp+8 (argv[0] is the program name)

  mov rdx, 0o644        ; mode: rw-r--r-- (octal 644)
  mov rsi, 0x241        ; flags: O_CREAT | O_WRONLY | O_TRUNC (0x241)
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
