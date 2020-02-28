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
        "ldr r0, %1  \n" \
        "svc %2      \n" \
        "mov %0, r0  \n" \
        : "=r" (ret) \
        : "m" (a), "i" (no) \
        : "cc" /* Tell gcc this code modifies the cpsr */); \
} while(0)

#define ARCH_SYSCALL2(no, ret, t, a, t2, a2) do { \
    /* volatile to prevent any gcc optimization on the assembly code */ \
    asm volatile ( \
        "ldr r0, %1  \n" \
        "ldr r1, %2  \n" \
        "svc %3      \n" \
        "mov %0, r0  \n" \
        : "=r" (ret) \
        : "m" (a), "m" (a2), "i" (no) \
        : "cc" /* Tell gcc this code modifies the cpsr */ ); \
} while(0)

#define ARCH_SYSCALL3(no, ret, t, a, t2, a2, t3, a3) do { \
    /* volatile to prevent any gcc optimization on the assembly code */ \
    asm volatile ( \
        "ldr r0, %1  \n" \
        "ldr r1, %2  \n" \
        "ldr r2, %3  \n" \
        "svc %4      \n" \
        "mov %0, r0  \n" \
        : "=r" (ret) \
        : "m" (a), "m" (a2), "m" (a3), "i" (no) \
        : "cc" /* Tell gcc this code modifies the cpsr */ ); \
} while(0)

#define ARCH_SYSCALL4(no, ret, t, a, t2, a2, t3, a3, t4, a4) do { \
    /* volatile to prevent any gcc optimization on the assembly code */ \
    asm volatile ( \
        "ldr r0, %1  \n" \
        "ldr r1, %2  \n" \
        "ldr r2, %3  \n" \
        "ldr r3, %4  \n" \
        "svc %5      \n" \
        "mov %0, r0  \n" \
        : "=r" (ret) \
        : "m" (a), "m" (a2), "m" (a3), "m" (a4), "i" (no) \
        : "cc" /* Tell gcc this code modifies the cpsr */ ); \
} while(0)
