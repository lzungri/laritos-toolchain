#pragma once

#include <syscall.h>

DEF_SYSCALL(SYSCALL_PUTS, puts, const char *, s);
DEF_SYSCALL(SYSCALL_READLINE, readline, char *, buf, int, buflen);

