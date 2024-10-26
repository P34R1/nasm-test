section .text

global print
print:
  ; print (sys_write)
  mov rax,1   ;system call number (sys_write)
  syscall     ;call kernel
  ret


global closefile
closefile:
  ; Close file (sys_close)
  mov rax, 3                    ; sys_close system call number is 3
  syscall
  ret


global openfile
openfile:
  ; Open file (sys_open)
  mov rdx, 0o644  ; mode: rw-r--r-- (octal 644)
  mov rsi, 0x241  ; flags: O_CREAT | O_WRONLY | O_TRUNC (0x241)
  mov rax, 2      ; sys_open system call number is 2
  syscall
  ret
