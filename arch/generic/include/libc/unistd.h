#pragma once

#include <syscall.h>

DEF_SYSCALL(SYSCALL_SLEEP, sleep, unsigned int, secs);
DEF_SYSCALL(SYSCALL_MSLEEP, msleep, unsigned int, msecs);
DEF_SYSCALL(SYSCALL_USLEEP, usleep, unsigned int, usecs);
