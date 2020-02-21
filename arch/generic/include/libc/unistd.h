#pragma once

#include <syscall.h>

DEF_SYSCALL(SYSCALL_SLEEP, sleep, unsigned int, secs);
DEF_SYSCALL(SYSCALL_MSLEEP, msleep, unsigned int, msecs);
DEF_SYSCALL(SYSCALL_USLEEP, usleep, unsigned int, usecs);
DEF_SYSCALL(SYSCALL_CHDIR, chdir, const char *, path);
DEF_SYSCALL(SYSCALL_GETCWD, getcwd, char *, buf, int, buflen);
