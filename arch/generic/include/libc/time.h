#pragma once

#include <stdint.h>
#include <syscall.h>

typedef struct {
    uint64_t secs;
    uint32_t ns;
} time_t;

DEF_SYSCALL(SYSCALL_TIME, time, time_t *, t);

