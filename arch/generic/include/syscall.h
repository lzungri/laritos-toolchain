#pragma once

#include <syscall-no.h>
#include <arch/syscall.h>


// Magical macros taken from linux/include/linux/syscalls.h
// -----------------------------------------
/*
 * __MAP - apply a macro to syscall arguments
 * __MAP(n, m, t1, a1, t2, a2, ..., tn, an) will expand to
 *    m(t1, a1), m(t2, a2), ..., m(tn, an)
 * The first argument must be equal to the amount of type/name
 * pairs given.  Note that this list of pairs (i.e. the arguments
 * of __MAP starting at the third one) is in the same format as
 * for SYSCALL_DEFINE<n>/COMPAT_SYSCALL_DEFINE<n>
 */
#define __MAP0(m,...) void
#define __MAP1(m,t,a,...) m(t,a)
#define __MAP2(m,t,a,...) m(t,a), __MAP1(m,__VA_ARGS__)
#define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
#define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
#define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
#define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
#define __MAP(n,...) __MAP##n(__VA_ARGS__)

#define __SC_DECL(t, a) t a
#define __SC_ARGS(t, a) a
// -----------------------------------------



/**
 * Returns the last argument (a14)
 */
#define LAST_ARG(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, ...) a14

/**
 * Counts the number of (type, varname) pairs given as arguments
 *
 * @param varargs: (type, varname)*
 */
#define COUNT_ARG_PAIRS(...) LAST_ARG(dummy, ##__VA_ARGS__, 6, 0, 5, 0, 4, 0, 3, 0, 2, 0, 1, 0, 0)

/**
 * Architecture-dependent syscall body
 *
 * @param x: Number of argument pairs
 * @param no: Syscall number
 * @param ret: Variable that will hold the return value
 * @param varargs: (type, varname)*
 */
#define ARCH_SYSCALLx(x, no, ret, ...) ARCH_SYSCALL##x(no, ret, ##__VA_ARGS__)

/**
 * Defines a syscall function
 *
 * @param x: Number of argument pairs
 * @param no: Syscall number
 * @param name: Syscall name
 * @param varargs: (type, varname)*
 */
#define DEF_SYSCALLx(x, no, name, ...) \
    static inline int name(__MAP(x, __SC_DECL, __VA_ARGS__)) { \
        int ret = 0; \
        ARCH_SYSCALLx(x, no, ret, ##__VA_ARGS__); \
        return ret; \
    }

/**
 * Defines a syscall function
 *
 * @param no: Syscall number
 * @param name: Syscall name
 * @param varargs: (type, varname)*
 */
#define DEF_SYSCALL(no, name, ...) DEF_SYSCALLx(COUNT_ARG_PAIRS(__VA_ARGS__), no, name, ##__VA_ARGS__)
