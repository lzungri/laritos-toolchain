    .section .text.start, "ax"
    .global _start

_start:
    bl main
    # First argument (r0) is the application exit status
    svc 0
