    .section .text.start, "ax"
    .global _start

_start:
    bl main
    # SYSCALL_EXIT: First argument (r0) is the application exit status
    svc 0
