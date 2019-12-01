#pragma once

#include <syscall.h>

DEF_SYSCALL(SYSCALL_EXIT, exit, int, status);
DEF_SYSCALL(SYSCALL_YIELD, yield);
DEF_SYSCALL(SYSCALL_GETPID, getpid);


