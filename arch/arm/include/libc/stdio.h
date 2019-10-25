#pragma once

#include <syscall.h>

/*
#define DEF_SYSCALL(_syscall, _func, ...) \
    int _func(__VA_ARGS__) { \
        return syscall(_syscall, ##__VA_ARGS__); \
    }

DEF_SYSCALL(SYSCALL_PUTS, puts, const char *s);
*/
