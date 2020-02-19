#pragma once

#define ARCH_SYSCALL0(no, ret) do { \
    /* volatile to prevent any gcc optimization on the assembly code */ \
    asm volatile ( \
        "svc %1      \n" \
        "mov %0, r0  \n" \
        : "=r" (ret) \
        : "i" (no) \
        : "cc" /* Tell gcc this code modifies the cpsr */); \
} while(0)

#define ARCH_SYSCALL1(no, ret, t, a) do { \
    /* volatile to prevent any gcc optimization on the assembly code */ \
    asm volatile ( \
        "mov r0, %1  \n" \
        "svc %2      \n" \
        "mov %0, r0  \n" \
        : "=r" (ret) \
        : "r" (a), "i" (no) \
        : "cc" /* Tell gcc this code modifies the cpsr */); \
} while(0)

#define ARCH_SYSCALL2(no, ret, t, a, t2, a2) do { \
    /* volatile to prevent any gcc optimization on the assembly code */ \
    asm volatile ( \
        "mov r0, %1  \n" \
        "mov r1, %2  \n" \
        "svc %3      \n" \
        "mov %0, r0  \n" \
        : "=r" (ret) \
        : "r" (a), "r" (a2), "i" (no) \
        : "cc" /* Tell gcc this code modifies the cpsr */); \
} while(0)
